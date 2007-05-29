From: "=?ISO-8859-1?Q?Ragner_N_Magalh=E3es?=" <ragner@users.sourceforge.net>
Subject: Re: Removing Gadget File Storage module
Date: Tue, 29 May 2007 11:22:56 -0400
Message-ID: <25c21ceb0705290822l69271364pcdc6ded14dcde9e3@mail.gmail.com>
References: <25c21ceb0705280932l32668663y6396faabec70c2ab@mail.gmail.com>
	<Pine.LNX.4.44L0.0705281608560.10323-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0705281608560.10323-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On 5/28/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 28 May 2007, Ragner N Magalh=E3es wrote:
>
> > Hi all,
> >  I am working with OMAP H2 and when I run "rmmod g_file_storage", it
> > stay waiting some thing and not terminate ...
> >
> >  Somebody know some thing about this ?
>
> Which version of the Linux kernel are you using?

I am using the last omap git tree from
http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

>
> If you enable debugging in g_file_storage, what shows up in the dmesg
> log?
...
udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
bus platform: add driver omap_udc
platform: Matched Device omap_udc with Driver omap_udc
platform: Probing driver omap_udc with device omap_udc
udc: OMAP UDC rev 3.6, Mini-AB
udc: hmc mode 19, isp1301_omap transceiver
udc: fifo mode 3, 392 bytes not used
DEV: registering device: ID =3D 'gadget'
PM: Adding info for No Bus:gadget
bound device 'omap_udc' to driver 'omap_udc'
platform: Bound Device omap_udc to Driver omap_udc
DEV: registering device: ID =3D 'vcs2'
PM: Adding info for No Bus:vcs2
DEV: registering device: ID =3D 'vcsa2'
PM: Adding info for No Bus:vcsa2
DEV: registering device: ID =3D 'vcs1'
PM: Adding info for No Bus:vcs1
DEV: registering device: ID =3D 'vcsa1'
PM: Adding info for No Bus:vcsa1
DEV: registering device: ID =3D 'gadget-lun0'
PM: Adding info for No Bus:gadget-lun0
g_file_storage gadget: File-backed Storage Gadget, version: 28 November 2005
g_file_storage gadget: Number of LUNs=3D1
g_file_storage gadget: transport=3DBulk-only (x50)
g_file_storage gadget: protocol=3DTransparent SCSI (x06)
g_file_storage gadget: VendorID=3Dx0525, ProductID=3Dxa4a5, Release=3Dx0308
g_file_storage gadget: removable=3D1, stall=3D1, buflen=3D16384
g_file_storage gadget: I/O thread pid: 957
otg: b_idle, SWITCH to gadget, ctrl 098021
isp1301_omap 1-002d: ready for dual-role USB ...
tps65010: battery charging
udc: USB reset done, gadget g_file_storage
g_file_storage gadget: suspend
g_file_storage gadget: resume
udc: USB reset done, gadget g_file_storage
g_file_storage gadget: suspend
g_file_storage gadget: resume
udc: USB reset done, gadget g_file_storage
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 01 00 00 40 00
g_file_storage gadget: get device descriptor
g_file_storage gadget: ep0-in, length 18:
     0:  12 01 00 02 00 00 00 40  25 05 a5 a4 08 03 01 02
    10:  03 01
udc: USB reset done, gadget g_file_storage
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 01 00 00 12 00
g_file_storage gadget: get device descriptor
g_file_storage gadget: ep0-in, length 18:
     0:  12 01 00 02 00 00 00 40  25 05 a5 a4 08 03 01 02
    10:  03 01
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 06 00 00 0a 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 06 00 00 0a 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 06 00 00 0a 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 02 00 00 09 00
g_file_storage gadget: get configuration descriptor
g_file_storage gadget: ep0-in, length 9:
     0:  09 02 23 00 01 01 04 e0  01
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 02 00 00 23 00
g_file_storage gadget: get configuration descriptor
g_file_storage gadget: ep0-in, length 35:
     0:  09 02 23 00 01 01 04 e0  01 03 09 03 09 04 00 00
    10:  02 08 06 50 05 07 05 81  02 40 00 00 07 05 02 02
    20:  40 00 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 00 03 00 00 ff 00
g_file_storage gadget: get string descriptor
g_file_storage gadget: ep0-in, length 4:
     0:  04 03 09 04
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 02 03 09 04 ff 00
g_file_storage gadget: get string descriptor
g_file_storage gadget: ep0-in, length 54:
     0:  36 03 46 00 69 00 6c 00  65 00 2d 00 62 00 61 00
    10:  63 00 6b 00 65 00 64 00  20 00 53 00 74 00 6f 00
    20:  72 00 61 00 67 00 65 00  20 00 47 00 61 00 64 00
    30:  67 00 65 00 74 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 01 03 09 04 ff 00
g_file_storage gadget: get string descriptor
g_file_storage gadget: ep0-in, length 106:
     0:  6a 03 4c 00 69 00 6e 00  75 00 78 00 20 00 32 00
    10:  2e 00 36 00 2e 00 32 00  32 00 2d 00 72 00 63 00
    20:  32 00 2d 00 6f 00 6d 00  61 00 70 00 31 00 2d 00
    30:  67 00 61 00 38 00 62 00  32 00 38 00 39 00 39 00
    40:  65 00 2d 00 64 00 69 00  72 00 74 00 79 00 20 00
    50:  77 00 69 00 74 00 68 00  20 00 6f 00 6d 00 61 00
    60:  70 00 5f 00 75 00 64 00  63 00
g_file_storage gadget: ep0-setup, length 8:
     0:  80 06 03 03 09 04 ff 00
g_file_storage gadget: get string descriptor
g_file_storage gadget: ep0-in, length 26:
     0:  1a 03 33 00 32 00 33 00  38 00 32 00 30 00 34 00
    10:  45 00 36 00 46 00 37 00  36 00
g_file_storage gadget: ep0-setup, length 8:
     0:  00 09 01 00 00 00 00 00
g_file_storage gadget: set configuration
g_file_storage gadget: suspend
g_file_storage gadget: resume
tps65010: battery discharging
g_file_storage gadget: unbind
DEV: Unregistering device. ID =3D 'gadget-lun0'
PM: Removing info for No Bus:gadget-lun0

>
> When the rmmod is waiting, what does a stack trace (Alt-SysRq-T) show?

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C02074C4     0     1      0 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207fa8>] (schedule_timeout+0x9c/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c009203c>]
(do_select+0x3f0/0x460)
 r7:c032bf54 r6:000001f4 r5:c032bf74 r4:00000000
[<c0091c4c>] (do_select+0x0/0x460) from [<c0092384>] (sys_select+0x2d8/0x4b=
8)
[<c00920ac>] (sys_select+0x0/0x4b8) from [<c0026e40>]
(ret_fast_syscall+0x0/0x2c)
kthreadd      S C02074C4     0     2      0 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c005411c>] (kthreadd+0x68/0xf0)
[<c00540b4>] (kthreadd+0x0/0xf0) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000
ksoftirqd/0   S C02074C4     0     3      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c004608c>] (ksoftirqd+0x54/0xac)
[<c0046038>] (ksoftirqd+0x0/0xac) from [<c00542a4>] (kthread+0x58/0x90)
 r5:00000000 r4:c0330000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
watchdog/0    S C02074C4     0     4      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00626e4>] (watchdog+0x5c/0x70)
[<c0062688>] (watchdog+0x0/0x70) from [<c00542a4>] (kthread+0x58/0x90)
 r4:c0332000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
events/0      S C02074C4     0     5      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c0310a40 r4:c0334000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
khelper       S C02074C4     0     6      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c03109e0 r4:c0338000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
kblockd/0     S C02074C4     0    46      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c035bc80 r4:c0370000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
kseriod       S C02074C4     0    47      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c01432e4>] (serio_thread+0x2ac/0x3=
1c)
[<c0143038>] (serio_thread+0x0/0x31c) from [<c00542a4>] (kthread+0x58/0x90)
 r7:00000000 r6:c0143038 r5:00000000 r4:c0372000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
omap_uwire    S C02074C4     0    52      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c0365860 r4:c03a2000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
ksuspend_usbd S C02074C4     0    55      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c0365680 r4:c0390000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
khubd         S C02074C4     0    58      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c01708dc>] (hub_thread+0xb40/0xc1c)
[<c016fd9c>] (hub_thread+0x0/0xc1c) from [<c00542a4>] (kthread+0x58/0x90)
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
pdflush       S C02074C4     0    72      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c006bd00>] (pdflush+0xc4/0x1f4)
[<c006bc3c>] (pdflush+0x0/0x1f4) from [<c00542a4>] (kthread+0x58/0x90)
 r7:00000000 r6:c006bc3c r5:00000000 r4:c039c000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
pdflush       S C02074C4     0    73      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c006bd00>] (pdflush+0xc4/0x1f4)
[<c006bc3c>] (pdflush+0x0/0x1f4) from [<c00542a4>] (kthread+0x58/0x90)
 r7:00000000 r6:c006bc3c r5:00000000 r4:c039e000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
kswapd0       S C02074C4     0    74      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c006f2e0>] (kswapd+0xcc/0x470)
[<c006f214>] (kswapd+0x0/0x470) from [<c00542a4>] (kthread+0x58/0x90)
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
aio/0         S C02074C4     0    75      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c03a0420 r4:c03ae000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
mtdblockd     S C02074C4     0   183      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0163b98>]
(mtd_blktrans_thread+0x70/0x1e0)
[<c0163b28>] (mtd_blktrans_thread+0x0/0x1e0) from [<c00542a4>]
(kthread+0x58/0x90)
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
rpciod/0      S C02074C4     0   198      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c00508fc>] (worker_thread+0xc8/0x1=
14)
[<c0050834>] (worker_thread+0x0/0x114) from [<c00542a4>] (kthread+0x58/0x90)
 r6:c0050834 r5:c1ca6f40 r4:c1c5e000
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
udevd         S C02074C4     0   277      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c009203c>]
(do_select+0x3f0/0x460)
 r7:c193bf54 r6:ffffffff r5:c193bf74 r4:00000000
[<c0091c4c>] (do_select+0x0/0x460) from [<c0092384>] (sys_select+0x2d8/0x4b=
8)
[<c00920ac>] (sys_select+0x0/0x4b8) from [<c0026e40>]
(ret_fast_syscall+0x0/0x2c)
syslogd       S C02074C4     0   898      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c009203c>]
(do_select+0x3f0/0x460)
 r7:c1633f54 r6:ffffffff r5:c1633f74 r4:00000000
[<c0091c4c>] (do_select+0x0/0x460) from [<c0092384>] (sys_select+0x2d8/0x4b=
8)
[<c00920ac>] (sys_select+0x0/0x4b8) from [<c0026e40>]
(ret_fast_syscall+0x0/0x2c)
klogd         R running     0   901      1 (NOTLB)
sshd          S C02074C4     0   910      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c009203c>]
(do_select+0x3f0/0x460)
 r7:c1079f54 r6:ffffffff r5:c1079f74 r4:00000000
[<c0091c4c>] (do_select+0x0/0x460) from [<c0092384>] (sys_select+0x2d8/0x4b=
8)
[<c00920ac>] (sys_select+0x0/0x4b8) from [<c0026e40>]
(ret_fast_syscall+0x0/0x2c)
dbus-daemon   S C02074C4     0   920      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c0092810>]
(do_sys_poll+0x2ac/0x3e8)
 r7:c1276400 r6:00000000 r5:00000000 r4:c111de74
[<c0092564>] (do_sys_poll+0x0/0x3e8) from [<c00929a4>] (sys_poll+0x58/0x60)
[<c009294c>] (sys_poll+0x0/0x60) from [<c0026e40>] (ret_fast_syscall+0x0/0x=
2c)
 r6:beb03a68 r5:00000003 r4:ffffffff
hald          S C02074C4     0   928      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c0092810>]
(do_sys_poll+0x2ac/0x3e8)
 r7:c13dd1c0 r6:00000000 r5:00000000 r4:c1b9de94
[<c0092564>] (do_sys_poll+0x0/0x3e8) from [<c00929a4>] (sys_poll+0x58/0x60)
[<c009294c>] (sys_poll+0x0/0x60) from [<c0026e40>] (ret_fast_syscall+0x0/0x=
2c)
 r6:0005aa50 r5:00000007 r4:ffffffff
hald-runner   S C02074C4     0   929    928 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c0092810>]
(do_sys_poll+0x2ac/0x3e8)
 r7:c03575e0 r6:00000000 r5:00000000 r4:c14fbe64
[<c0092564>] (do_sys_poll+0x0/0x3e8) from [<c00929a4>] (sys_poll+0x58/0x60)
[<c009294c>] (sys_poll+0x0/0x60) from [<c0026e40>] (ret_fast_syscall+0x0/0x=
2c)
 r6:00014800 r5:00000001 r4:ffffffff
getty         S C02074C4     0   946      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c0133dfc>]
(read_chan+0x350/0x610)
 r7:c1cb2400 r6:c1cb240c r5:c034a440 r4:c1f39edc
[<c0133aac>] (read_chan+0x0/0x610) from [<c013025c>] (tty_read+0x84/0xcc)
[<c01301d8>] (tty_read+0x0/0xcc) from [<c0085ad8>] (vfs_read+0xb4/0x140)
[<c0085a24>] (vfs_read+0x0/0x140) from [<c0085f24>] (sys_read+0x4c/0x80)
 r7:00000003 r6:c034a440 r5:00000000 r4:00000000
[<c0085ed8>] (sys_read+0x0/0x80) from [<c0026e40>] (ret_fast_syscall+0x0/0x=
2c)
 r6:beb64e94 r5:beb64e60 r4:00013208
getty         S C02074C4     0   947      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c0207f2c>] (schedule_timeout+0x20/=
0xd0)
[<c0207f0c>] (schedule_timeout+0x0/0xd0) from [<c0133dfc>]
(read_chan+0x350/0x610)
 r7:c18bf400 r6:c18bf40c r5:c034ac60 r4:c1f25edc
[<c0133aac>] (read_chan+0x0/0x610) from [<c013025c>] (tty_read+0x84/0xcc)
[<c01301d8>] (tty_read+0x0/0xcc) from [<c0085ad8>] (vfs_read+0xb4/0x140)
[<c0085a24>] (vfs_read+0x0/0x140) from [<c0085f24>] (sys_read+0x4c/0x80)
 r7:00000003 r6:c034ac60 r5:00000000 r4:00000000
[<c0085ed8>] (sys_read+0x0/0x80) from [<c0026e40>] (ret_fast_syscall+0x0/0x=
2c)
 r6:bed87e94 r5:bed87e60 r4:00013208
login         S C02074C4     0   948      1 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c004388c>] (do_wait+0xa7c/0xbd4)
[<c0042e10>] (do_wait+0x0/0xbd4) from [<c0043a1c>] (sys_wait4+0x38/0x44)
[<c00439e4>] (sys_wait4+0x0/0x44) from [<c0026e40>] (ret_fast_syscall+0x0/0=
x2c)
 r4:00000000
bash          S C02074C4     0   953    948 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c004388c>] (do_wait+0xa7c/0xbd4)
[<c0042e10>] (do_wait+0x0/0xbd4) from [<c0043a1c>] (sys_wait4+0x38/0x44)
[<c00439e4>] (sys_wait4+0x0/0x44) from [<c0026e40>] (ret_fast_syscall+0x0/0=
x2c)
 r4:0000000a
file-storage- S C02074C4     0   957      2 (L-TLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<bf00d6ac>]
(sleep_thread+0x64/0x84 [g_file_storage])
[<bf00d648>] (sleep_thread+0x0/0x84 [g_file_storage]) from
[<bf00f10c>] (fsg_main_thread+0x464/0x1654 [g_file_storage])
 r5:c19dea00 r4:c0d12000
[<bf00eca8>] (fsg_main_thread+0x0/0x1654 [g_file_storage]) from
[<c00542a4>] (kthread+0x58/0x90)
[<c005424c>] (kthread+0x0/0x90) from [<c0043ab4>] (do_exit+0x0/0x79c)
 r6:00000000 r5:00000000 r4:00000000
rmmod         D C02074C4     0   961    953 (NOTLB)
[<c0206f60>] (schedule+0x0/0x63c) from [<c02077e0>]
(wait_for_completion+0xac/0x110)
[<c0207734>] (wait_for_completion+0x0/0x110) from [<bf00d128>]
(fsg_unbind+0xdc/0x190 [g_file_storage])
 r6:c19b8200 r5:c19dea00 r4:c19deaa4
[<bf00d04c>] (fsg_unbind+0x0/0x190 [g_file_storage]) from [<bf007260>]
(usb_gadget_unregister_driver+0xc0/0xfc [omap_udc])
[<bf0071a0>] (usb_gadget_unregister_driver+0x0/0xfc [omap_udc]) from
[<bf01033c>] (fsg_cleanup+0x40/0x6c [g_file_storage])
 r5:00000000 r4:c19dea00
[<bf0102fc>] (fsg_cleanup+0x0/0x6c [g_file_storage]) from [<c00610d8>]
(sys_delete_module+0x1b4/0x1e4)
 r4:bf012f40
[<c0060f24>] (sys_delete_module+0x0/0x1e4) from [<c0026e40>]
(ret_fast_syscall+0x0/0x2c)
 r8:c0026fe4 r7:00000081 r6:befb05a0 r5:befb0580 r4:befb2da0


>
> Really, you shouldn't expect people to be able to help if you don't
> provide any information...

Sorry my mistake ... :(
>
> Alan Stern
>
>

Best regards,

-- =

Ragner N Magalh=E3es

Instituto Nokia de Tecnologia - INdT
Open Source Mobile Research Center - OSMRC
Linux Kernel Team

E-mail: ragner.magalhaes@indt.org.br
            ragner@users.sourceforge.net

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
