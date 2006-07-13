From: Omap 850 <omap850@yahoo.de>
Subject: MMC/SDCard mount on OMAP850 (Wizard (WIZA100))
Date: Thu, 13 Jul 2006 10:32:10 +0200 (CEST)
Message-ID: <20060713083210.682.qmail@web27801.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



MMC/SDCard mount on OMAP850 (Wizard (WIZA100))


Hello,

sorry about my poor english, i am german.

I use the "HaRet.exe" from the Tornado Project from Nico.

I have Kernel 2.6.16.24 (with OMAP Patches from Nico)


I can=B4t mount the "MiniSDCad"

/ # mount /dev/mmcblk0p1 /mnt/
mount: Mounting /dev/mmcblk0p1 on /mnt failed: No such device or address
/ #


i need to mount /dev/mmcblk0p2, how to create the device file ?



Here are some infromatiosn from /proc filesystem


/proc # cat devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 29 fb
128 ptm
136 pts

Block devices:
  1 ramdisk
254 mmc


/proc # cat interrupts
           CPU0
  2:       1179   omap_udc pio
  3:          0   omap_udc iso
 19:          0   DMA
 20:          0   DMA
 21:          0   DMA
 22:          0   DMA
 23:          0   DMA
 24:          0   DMA
 25:          0   LCD DMA
 26:          1   mpu timer1 overflow
 30:      56821   mpu timer
 55:          6   mmci-omap
 61:         96   omap_udc
 67:          4   tornado-keypad
 85:          0   DMA
 86:          0   DMA
 87:          0   DMA
 88:          0   DMA
 89:          0   DMA
 90:          0   DMA
 91:          0   DMA
 92:          0   DMA
 93:          0   DMA
 94:          0   DMA
236:          8   tornado-kp-gpio
Err:          0


/dev # ls -la mmcblk0*
brw-r--r--    1 root     root     254,   0 May 25  2006 mmcblk0
brw-r--r--    1 root     root     254,   1 May 25  2006 mmcblk0p1






/proc # cat iomem
10000000-15ffffff : System RAM
  1001e000-101d921b : Kernel text
  101da000-10234c9f : Kernel data
20001020-2002681f : HTC vsfb
fefb7800-fefb787f : mmci-omap.1
  fefb7800-fefb787f : mmci-omap
fffb4000-fffb40ff : omap_udc
  fffb4000-fffb40ff : omap_udc



/proc # cat meminfo
MemTotal:        95232 kB
MemFree:         90940 kB
Buffers:          1432 kB
Cached:            492 kB
SwapCached:          0 kB
Active:           1056 kB
Inactive:         1364 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        95232 kB
LowFree:         90940 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            888 kB
Slab:             1404 kB
CommitLimit:     47616 kB
Committed_AS:     3464 kB
PageTables:         72 kB
VmallocTotal:   155648 kB
VmallocUsed:       156 kB
VmallocChunk:   155492 kB



/proc # cat partitions
major minor  #blocks  name


/proc # cat version
Linux version 2.6.16.24-omap1-htc-wizard (root@hntc56514) (gcc version 3.=
4.1) #11 PREEMPT Thu Jul 13 08:16:33 CEST 2006


/proc # cat misc
241 tornado-leds
240 tornado-vibrator
130 omap730_wdt



/proc # cat omap_clocks
mmc_ck 48000000 0
lcd_ck 97500000 0
tc_ck 97500000 0
armper_ck 48750000 1
arm_ck 195000000 0



/proc # cat stat
cpu  166 0 454 93925 0 64 31 0
cpu0 166 0 454 93925 0 64 31 0
intr 105615 0 0 10859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0=
 0 94640 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6 0 0 0 0 0 96 0=
 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 11238
btime 0
processes 75
procs_running 1
procs_blocked 0


/proc # cat fb
0 HTC VSFB



/proc # cat filesystems
nodev   sysfs
nodev   rootfs
nodev   bdev
nodev   proc
nodev   sockfs
nodev   pipefs
nodev   tmpfs
nodev   devpts
        ext3
        ext2
nodev   ramfs
        msdos
        vfat
nodev   nfs
nodev   rpc_pipefs



/proc # cat slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active=
_slabs> <num_slabs> <sharedavail>
rpc_buffers            8      8   2048    2    1 : tunables   24   12    =
0 : slabdata      4      4      0
rpc_tasks              8     24    160   24    1 : tunables  120   60    =
0 : slabdata      1      1      0
rpc_inode_cache        0      0    384   10    1 : tunables   54   27    =
0 : slabdata      0      0      0
UNIX                   0      0    352   11    1 : tunables   54   27    =
0 : slabdata      0      0      0
tcp_bind_bucket        1    203     16  203    1 : tunables  120   60    =
0 : slabdata      1      1      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
secpath_cache          0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
xfrm_dst_cache         0      0    288   13    1 : tunables   54   27    =
0 : slabdata      0      0      0
ip_fib_alias           9    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
ip_fib_hash            9    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
ip_dst_cache           3     15    256   15    1 : tunables  120   60    =
0 : slabdata      1      1      0
arp_cache              1     30    128   30    1 : tunables  120   60    =
0 : slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27    =
0 : slabdata      1      1      0
UDP                    0      0    448    9    1 : tunables   54   27    =
0 : slabdata      0      0      0
tw_sock_TCP            0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
TCP                    3      4   1024    4    1 : tunables   54   27    =
0 : slabdata      1      1      0
flow_cache             0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    =
0 : slabdata      0      0      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    =
0 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    =
0 : slabdata      4      4      0
nfs_inode_cache        0      0    536    7    1 : tunables   54   27    =
0 : slabdata      0      0      0
nfs_page               0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
fat_inode_cache        0      0    340   11    1 : tunables   54   27    =
0 : slabdata      0      0      0
fat_cache              0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
ext2_inode_cache     160    160    396   10    1 : tunables   54   27    =
0 : slabdata     16     16      0
journal_handle         0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
journal_head           0      0     52   72    1 : tunables  120   60    =
0 : slabdata      0      0      0
revoke_table           0      0     12  254    1 : tunables  120   60    =
0 : slabdata      0      0      0
revoke_record          0      0     16  203    1 : tunables  120   60    =
0 : slabdata      0      0      0
ext3_inode_cache       0      0    428    9    1 : tunables   54   27    =
0 : slabdata      0      0      0
ext3_xattr             0      0     44   84    1 : tunables  120   60    =
0 : slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    =
0 : slabdata      0      0      0
kioctx                 0      0    160   24    1 : tunables  120   60    =
0 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60    =
0 : slabdata      0      0      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60   =
 0 : slabdata      0      0      0
uid_cache              0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
blkdev_ioc             0      0     28  127    1 : tunables  120   60    =
0 : slabdata      0      0      0
blkdev_queue           1      4    900    4    1 : tunables   54   27    =
0 : slabdata      1      1      0
blkdev_requests        0      0    168   23    1 : tunables  120   60    =
0 : slabdata      0      0      0
biovec-(256)          23     24   3072    2    2 : tunables   24   12    =
0 : slabdata     12     12      0
biovec-128            46     50   1536    5    2 : tunables   24   12    =
0 : slabdata     10     10      0
biovec-64             92     95    768    5    1 : tunables   54   27    =
0 : slabdata     19     19      0
biovec-16            184    200    192   20    1 : tunables  120   60    =
0 : slabdata     10     10      0
biovec-4             184    236     64   59    1 : tunables  120   60    =
0 : slabdata      4      4      0
biovec-1             184    203     16  203    1 : tunables  120   60    =
0 : slabdata      1      1      0
bio                  256    295     64   59    1 : tunables  120   60    =
0 : slabdata      5      5      0
sock_inode_cache      10     11    352   11    1 : tunables   54   27    =
0 : slabdata      1      1      0
skbuff_fclone_cache     12     12    320   12    1 : tunables   54   27  =
  0 : slabdata      1      1      0
skbuff_head_cache     18     24    160   24    1 : tunables  120   60    =
0 : slabdata      1      1      0
file_lock_cache        0      0     88   44    1 : tunables  120   60    =
0 : slabdata      0      0      0
proc_inode_cache      26     26    304   13    1 : tunables   54   27    =
0 : slabdata      2      2      0
sigqueue               0      0    144   27    1 : tunables  120   60    =
0 : slabdata      0      0      0
radix_tree_node       37     42    276   14    1 : tunables   54   27    =
0 : slabdata      3      3      0
bdev_cache             2      9    416    9    1 : tunables   54   27    =
0 : slabdata      1      1      0
sysfs_dir_cache     2016   2024     40   92    1 : tunables  120   60    =
0 : slabdata     22     22      0
mnt_cache             12     30    128   30    1 : tunables  120   60    =
0 : slabdata      1      1      0
inode_cache          668    676    288   13    1 : tunables   54   27    =
0 : slabdata     52     52      0
dentry_cache         878    899    124   31    1 : tunables  120   60    =
0 : slabdata     29     29      0
filp                  54     60    128   30    1 : tunables  120   60    =
0 : slabdata      2      2      0
names_cache            1      1   4096    1    1 : tunables   24   12    =
0 : slabdata      1      1      0
idr_layer_cache       62     87    136   29    1 : tunables  120   60    =
0 : slabdata      3      3      0
buffer_head           76     78     48   78    1 : tunables  120   60    =
0 : slabdata      1      1      0
mm_struct             10     10    384   10    1 : tunables   54   27    =
0 : slabdata      1      1      0
vm_area_struct       132    132     88   44    1 : tunables  120   60    =
0 : slabdata      3      3      0
fs_cache              20    113     32  113    1 : tunables  120   60    =
0 : slabdata      1      1      0
files_cache            9      9    448    9    1 : tunables   54   27    =
0 : slabdata      1      1      0
signal_cache          22     22    352   11    1 : tunables   54   27    =
0 : slabdata      2      2      0
sighand_cache         15     15   1312    3    1 : tunables   24   12    =
0 : slabdata      5      5      0
task_struct           18     18    672    6    1 : tunables   54   27    =
0 : slabdata      3      3      0
anon_vma             111    339      8  339    1 : tunables  120   60    =
0 : slabdata      1      1      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    =
0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    =
0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    =
0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    =
0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    =
0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    =
0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    =
0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    =
0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    =
0 : slabdata      0      0      0
size-8192              1      1   8192    1    2 : tunables    8    4    =
0 : slabdata      1      1      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    =
0 : slabdata      0      0      0
size-4096              8      8   4096    1    1 : tunables   24   12    =
0 : slabdata      8      8      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    =
0 : slabdata      0      0      0
size-2048             16     16   2048    2    1 : tunables   24   12    =
0 : slabdata      8      8      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    =
0 : slabdata      0      0      0
size-1024             14     16   1024    4    1 : tunables   54   27    =
0 : slabdata      4      4      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    =
0 : slabdata      0      0      0
size-512              88     88    512    8    1 : tunables   54   27    =
0 : slabdata     11     11      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-256              32     45    256   15    1 : tunables  120   60    =
0 : slabdata      3      3      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-192             637    640    192   20    1 : tunables  120   60    =
0 : slabdata     32     32      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-128              46     60    128   30    1 : tunables  120   60    =
0 : slabdata      2      2      0
size-96(DMA)           0      0     96   40    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-96              116    120     96   40    1 : tunables  120   60    =
0 : slabdata      3      3      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    =
0 : slabdata      0      0      0
size-64              200    236     64   59    1 : tunables  120   60    =
0 : slabdata      4      4      0
size-32              947   1017     32  113    1 : tunables  120   60    =
0 : slabdata      9      9      0
kmem_cache           120    120     96   40    1 : tunables  120   60    =
0 : slabdata      3      3      0



/proc # cat zoneinfo
Node 0, zone      DMA
  pages free     22728
        min      313
        low      391
        high     469
        active   264
        inactive 341
        scanned  0 (a: 0 i: 0)
        spanned  24576
        present  24576
        protection: (0, 0, 0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 19
              high:  42
              batch: 7
    cpu: 0 pcp: 1
              count: 0
              high:  14
              batch: 3
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         65536


thanks

dennis

 	=09
---------------------------------
Besseren Schutz gegen Spam - jetzt bei dem neuen Yahoo! Mail .
