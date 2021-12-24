function pgstart --wraps='pg_ctl -D /data/data/com.termux/files/usr/var/lib/postgresql start'
	pg_ctl -D $PREFIX/var/lib/postgresql start

end
