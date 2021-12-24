function pgstop --wraps='pg_ctl -D /data/data/com.termux/files/usr/var/lib/postgresql stop'
	pg_ctl -D $PREFIX/var/lib/postgresql stop

end
