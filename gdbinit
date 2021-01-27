add-auto-load-safe-path /usr/lib64/libthread_db-1.0.so
#set debug libthread-db 1
#set auto-load safe-path /

#set auto-load safe-path /
#set libthread-db-search-path /usr/lib64/
#set env LD_PRELOAD /usr/lib64/libpthread.so.0

#set auto-load safe-path /
#b _gf_event
#r
set breakpoint pending on
set confirm off

