From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Please help!  AM35xx mm/slab.c BUG
Date: Tue, 5 Jun 2012 23:14:58 -0700 (PDT)
Message-ID: <1338963298.87083.YahooMailNeo@web125204.mail.ne1.yahoo.com>
References: <1338878255.13133.YahooMailNeo@web125205.mail.ne1.yahoo.com> <20120605070853.GE12766@atomide.com> <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm27-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.157]:30647 "HELO
	nm27-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750994Ab2FFGPA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Jun 2012 02:15:00 -0400
In-Reply-To: <1338913755.88514.YahooMailNeo@web125201.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,


We've learned a few more things:

1.) We have found a way to get it to happen pretty consistently.=C2=A0 =
We simply run iperf in a loop using the EMAC port to some other device.


2.) The crash ONLY happens on our custom board, not on the Twister dev =
kit.=C2=A0 This is true despite the fact that I ported our latest linux=
-omap 3.4-rc6 over there.=C2=A0 We're still running Technexion's defaul=
t x-loader and u-boot to handle proper configs on that board. So, that'=
s a substantial bit of code that is different between our boxes.=C2=A0 =
The kernel is altered only in that the few pinmux changes I left in Lin=
ux have been removed to avoid configuration differences between the two=
 boards.


This suggests that either:
A) We have a hardware problem on our board.=C2=A0 Seems unlikely.=C2=A0=
 Can anyone think of anything hardware related that would manifest itse=
lf with these sorts of errors?


B) We have a issue in our bootloader code somehwere.=C2=A0 I hesitated =
to overwrite the bootloaders for this test on the Twister baseboard jus=
t because I did not want to have to mess with getting the pinmux's and =
the like put back and such.

Presuming something in those bootloaders is our problem, I wonder what =
EMAC-related stuff there really is.=C2=A0 For a long time we ran with o=
ur bootloaders NOT initializing either of the Eths.=C2=A0 This was Tech=
nexion's default.=C2=A0 They left that work to Linux.=C2=A0 We've recen=
tly done work to enable them in u-boot, but we were crashing like this =
long before that.=C2=A0 Once in Linux, we're just using the standard dr=
ivers and calls from within the board file to SMSC911x and the Davinci =
EMAC drivers.=C2=A0 I am using the patches that allow the e-fused MAC t=
o be pulled from the AM35xx for the EMAC, but I can't see how that woul=
d cause this.

Assuming the EMAC is perhaps an innocent bystander that happens just to=
 cause this, the place I would have to suspect the most in our bootload=
ers would be the GPMC settings.=C2=A0 We've done a good bit of tweaking=
 in there since we switched chips.=C2=A0 *Could a GPMC timing issue acc=
ount for these types of errors???*=C2=A0 The reason I bring it up is th=
at the GPMC has been one of those things that we've really struggled to=
 understand.=C2=A0 What should the timings *really* be?=C2=A0 We've don=
e the best we can to try to guess our way through it.=C2=A0 BUT, we cou=
ld certainly be very wrong.=C2=A0 If a GPMC setting could cause these t=
ypes of bugs, please let me know.=C2=A0 I'll be happy to post more info=
 on how we're setting that up now.=C2=A0 In case not, I'll save the ele=
ctrons and not spam it here.


Thanks again for all your help!


PS -- If it's useful, here is our latest crash, with SLAB debugging ena=
bled:

[ 5278.124023] slab: Internal list corruption detected in cache 'skbuff=
_head_cache'(20), slabp cecbb040(4). Tainted(Not tainted). Hex:
[ 5278.136840] 00000000: 00 01 10 00 00 02 20 00 b0 00 00 00 b0 b0 cb c=
e=C2=A0 ...... .........
[ 5278.145263] 00000010: 04 00 00 00 11 00 00 00 00 00 6b 6b 0f 00 00 0=
0=C2=A0 ..........kk....
[ 5278.153686] 00000020: 03 00 00 00 0c 00 00 00 09 00 00 00 fe ff ff f=
f=C2=A0 ................
[ 5278.162078] 00000030: fd ff ff ff fd ff ff ff fd ff ff ff 10 00 00 0=
0=C2=A0 ................
[ 5278.170501] 00000040: 02 00 00 00 13 00 00 00 00 00 00 00 ff ff ff f=
f=C2=A0 ................
[ 5278.178924] 00000050: 00 00 00 00 0b 00 00 00 0d 00 00 00 0a 00 00 0=
0=C2=A0 ................
[ 5278.187316] 00000060: 12 00 00 00 0e 00 00 00 01 00 00 00=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....=
=2E.......
[ 5278.195404] ------------[ cut here ]------------
[ 5278.200256] kernel BUG at mm/slab.c:3114!
[ 5278.204467] Internal error: Oops - BUG: 0 [#1] ARM
[ 5278.209503] Modules linked in:
[ 5278.212707] CPU: 0=C2=A0=C2=A0=C2=A0 Not tainted=C2=A0 (3.4.0-rc6 #2=
)
[ 5278.217681] PC is at check_slabp+0xe4/0xf4
[ 5278.222015] LR is at console_unlock+0x174/0x214
[ 5278.226776] pc : [<c00c3b08>]=C2=A0=C2=A0=C2=A0 lr : [<c002f8e0>]=C2=
=A0=C2=A0=C2=A0 psr: 80000093
[ 5278.226806] sp : cf83fc40=C2=A0 ip : 00000070=C2=A0 fp : cf83fc74
[ 5278.238861] r10: cecbb3b0=C2=A0 r9 : c04f91c0=C2=A0 r8 : cf812800
[ 5278.244354] r7 : 00000004=C2=A0 r6 : cecbb040=C2=A0 r5 : 00000014=C2=
=A0 r4 : c0486154
[ 5278.251220] r3 : c0508718=C2=A0 r2 : 20000093=C2=A0 r1 : 00000001=C2=
=A0 r0 : 0000005d
[ 5278.258117] Flags: Nzcv=C2=A0 IRQs off=C2=A0 FIQs on=C2=A0 Mode SVC_=
32=C2=A0 ISA ARM=C2=A0 Segment user
[ 5278.265716] Control: 10c5387d=C2=A0 Table: 8eda0019=C2=A0 DAC: 00000=
015
[ 5278.271759] Process iperf (pid: 1434, stack limit =3D 0xcf83e2f0)
[ 5278.277984] Stack: (0xcf83fc40 to 0xcf840000)
[ 5278.282562] fc40: 00000001 cecbb040 0000006c 00000001 cf83fca4 cecbb=
040 cf812800 cf813a00
[ 5278.291168] fc60: 00000005 cf816464 cf83fcbc cf83fc78 c00c4dbc c00c3=
a30 cf83fccc 00000000
[ 5278.299804] fc80: 00000010 00200200 00100100 00000000 cf83fce4 cf813=
a00 00000010 cf816440
[ 5278.308410] fca0: 00000000 cf812800 00000b90 cef89670 cf83fce4 cf83f=
cc0 c037ea2c c00c4cc0
[ 5278.317016] fcc0: cf81287c cf812800 cf816440 cef89678 c02ec07c 60000=
013 cf83fd0c cf83fce8
[ 5278.325653] fce0: c00c4b18 c037e998 cef89678 000005a8 000005a8 cedf9=
81c cedf9500 00000000
[ 5278.334259] fd00: cf83fd24 cf83fd10 c02ec07c c00c4a3c cedf953c cef89=
678 cf83fd84 cf83fd28
[ 5278.342864] fd20: c0325ec0 c02ec034 cf83fd6c c00c3fd0 c03172d4 c0317=
7a0 cfa52800 00000001
[ 5278.351470] fd40: cf83fecc 00000000 00000000 00001470 c05335c0 7ffff=
fff cf83fd94 c0530610
[ 5278.360107] fd60: cf83fecc 00000000 cf621cf0 00000000 cf83fecc 00002=
000 cf83fdbc cf83fd88
[ 5278.368713] fd80: c0343aa4 c03258a8 00000000 00000000 cf83fd9c cfa74=
f40 d08b4d80 00000000
[ 5278.377319] fda0: 000006fe 00000000 00000000 00000000 cf83feb4 cf83f=
dc0 c02e3234 c0343a64
[ 5278.385955] fdc0: 00000000 cfa4ff40 cf83fe1c cf83fdd8 00000000 00002=
000 cf621cf0 cecbbbf8
[ 5278.394561] fde0: 00000000 cf83fecc cecb9d78 60000113 cfa52c80 cfa52=
800 cecb9d78 837fee5f
[ 5278.403167] fe00: 00000000 000005ea c05335c0 cecbbbf8 00000000 00000=
001 ffffffff 00000000
[ 5278.411773] fe20: 00000000 00000000 00000000 00000000 cedc60c0 cfa74=
f40 00000000 00000000
[ 5278.420410] fe40: c0287e54 c0286b0c cf83fdc8 00000000 d26d4d80 d08d0=
660 cfa52800 cf83e000
[ 5278.429016] fe60: cf83fe8c cf83fe70 c0287f2c c0288a98 00000001 c02e5=
0d0 cf83fe94 cf83fe88
[ 5278.437622] fe80: c0026c64 c02e33dc cf83febc 00002000 cf621cf0 00000=
000 cf83fee8 00000000
[ 5278.446258] fea0: cf83e000 00082ee0 cf83ff8c cf83feb8 c02e508c c02e3=
188 00000001 fffffff7
[ 5278.454864] fec0: 00000001 00083a70 00001470 cf83fee8 00000080 cf83f=
ec4 00000001 00000000
[ 5278.463470] fee0: 00000000 00000001 00000003 c0034d8c 00000100 00000=
000 00000003 00000010
[ 5278.472076] ff00: cf83ff54 cf83ff10 c0034d8c c0034428 00000044 03419=
fc0 00000000 0000000a
[ 5278.480712] ff20: c05468c0 00000100 c007632c cf83e000 00000044 c0035=
218 c050b338 cf83e000
[ 5278.489318] ff40: 00000044 00000000 cf83ff6c cf83ff58 c0035218 c0079=
544 c007633c c0522b6c
[ 5278.497924] ff60: cf83ff8c cf83ff70 00082ec8 00084ee8 00082ee0 00000=
123 c000e9c4 00000000
[ 5278.506561] ff80: cf83ffa4 cf83ff90 c02e5104 c02e5000 00000000 00000=
000 00000000 cf83ffa8
[ 5278.515167] ffa0: c000e780 c02e50e8 00082ec8 00084ee8 00000004 00082=
ee0 00002000 00000000
[ 5278.523773] ffc0: 00082ec8 00084ee8 00082ee0 00000123 0346bfc0 00000=
000 00002000 b5ce4f9c
[ 5278.532379] ffe0: 00000000 b5ce4d98 b6e90788 b6e91394 80000010 00000=
004 6b6b6b6b a56b6b6b
[ 5278.540985] Backtrace:=20
[ 5278.543579] [<c00c3a24>] (check_slabp+0x0/0xf4) from [<c00c4dbc>] (f=
ree_block+0x108/0x20c)
[ 5278.552276]=C2=A0 r8:cf816464 r7:00000005 r6:cf813a00 r5:cf812800 r4=
:cecbb040
[ 5278.559387] [<c00c4cb4>] (free_block+0x0/0x20c) from [<c037ea2c>] (c=
ache_flusharray+0xa0/0xfc)
[ 5278.568420] [<c037e98c>] (cache_flusharray+0x0/0xfc) from [<c00c4b18=
>] (kmem_cache_free+0xe8/0xf0)
[ 5278.577850]=C2=A0 r8:60000013 r7:c02ec07c r6:cef89678 r5:cf816440 r4=
:cf812800
[ 5278.584747] r3:cf81287c
[ 5278.587524] [<c00c4a30>] (kmem_cache_free+0x0/0xf0) from [<c02ec07c>=
] (__kfree_skb+0x54/0xcc)
[ 5278.596496] [<c02ec028>] (__kfree_skb+0x0/0xcc) from [<c0325ec0>] (t=
cp_recvmsg+0x624/0x864)
[ 5278.605285]=C2=A0 r4:cef89678 r3:cedf953c
[ 5278.609069] [<c032589c>] (tcp_recvmsg+0x0/0x864) from [<c0343aa4>] (=
inet_recvmsg+0x4c/0x60)
[ 5278.617858] [<c0343a58>] (inet_recvmsg+0x0/0x60) from [<c02e3234>] (=
sock_recvmsg+0xb8/0xd8)
[ 5278.626617]=C2=A0 r6:00000000 r5:00000000 r4:00000000
[ 5278.631500] [<c02e317c>] (sock_recvmsg+0x0/0xd8) from [<c02e508c>] (=
sys_recvfrom+0x98/0xe8)
[ 5278.640289] [<c02e4ff4>] (sys_recvfrom+0x0/0xe8) from [<c02e5104>] (=
sys_recv+0x28/0x30)
[ 5278.648712] [<c02e50dc>] (sys_recv+0x0/0x30) from [<c000e780>] (ret_=
fast_syscall+0x0/0x30)
[ 5278.657409] Code: e58d3008 e3a03010 e59f100c eb04f0a3 (e7f001f2)=20
[ 5278.668273] ---[ end trace 018554de1af4a1fa ]---
[ 5300.147521] slab: Internal list corruption detected in cache 'skbuff=
_head_cache'(20), slabp cee4a000(12). Tainted(Tainted: G=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 :
[ 5300.161437] 00000000: 00 50 d8 ce 00 3a 81 cf 70 00 00 00 70 a0 e4 c=
e=C2=A0 .P...:..p...p...
[ 5300.169860] 00000010: 0c 00 00 00 07 00 00 00 00 00 6b 6b fd ff ff f=
f=C2=A0 ..........kk....
[ 5300.178283] 00000020: 05 00 00 00 fd ff ff ff fd ff ff ff fd ff ff f=
f=C2=A0 ................
[ 5300.186676] 00000030: 06 00 00 00 0a 00 00 00 fd ff ff ff 01 00 00 0=
0=C2=A0 ................
[ 5300.195098] 00000040: fd ff ff ff ff ff ff ff 08 00 00 00 fd ff ff f=
f=C2=A0 ................
[ 5300.203521] 00000050: fd ff ff ff fd ff ff ff fd ff ff ff fd ff ff f=
f=C2=A0 ................
[ 5300.211914] 00000060: fd ff ff ff fd ff ff ff fd ff ff ff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....=
=2E.......
[ 5300.220001] ------------[ cut here ]------------
[ 5300.224853] kernel BUG at mm/slab.c:3114!
[ 5300.229064] Internal error: Oops - BUG: 0 [#2] ARM
[ 5300.234100] Modules linked in:
[ 5300.237304] CPU: 0=C2=A0=C2=A0=C2=A0 Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (3.4.0-rc6 #2)
[ 5300.243286] PC is at check_slabp+0xe4/0xf4
[ 5300.247589] LR is at console_unlock+0x174/0x214
[ 5300.252349] pc : [<c00c3b08>]=C2=A0=C2=A0=C2=A0 lr : [<c002f8e0>]=C2=
=A0=C2=A0=C2=A0 psr: 80000193
[ 5300.252380] sp : c04efc98=C2=A0 ip : 00000070=C2=A0 fp : c04efccc
[ 5300.264434] r10: cf812800=C2=A0 r9 : fffffffe=C2=A0 r8 : cf812800
[ 5300.269927] r7 : 0000000c=C2=A0 r6 : cee4a000=C2=A0 r5 : 00000014=C2=
=A0 r4 : c0486154
[ 5300.276763] r3 : c0508718=C2=A0 r2 : 20000193=C2=A0 r1 : 00000001=C2=
=A0 r0 : 0000005d
[ 5300.283630] Flags: Nzcv=C2=A0 IRQs off=C2=A0 FIQs on=C2=A0 Mode SVC_=
32=C2=A0 ISA ARM=C2=A0 Segment kernel
[ 5300.291412] Control: 10c5387d=C2=A0 Table: 8eda0019=C2=A0 DAC: 00000=
015
[ 5300.297454] Process swapper (pid: 0, stack limit =3D 0xc04ee2f0)
[ 5300.303588] Stack: (0xc04efc98 to 0xc04f0000)
[ 5300.308166] fc80:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000001 cee4=
a000
[ 5300.316741] fca0: 0000006c 00000001 00000009 cee4a000 00000004 00000=
00c cecb905c cf816440
[ 5300.325347] fcc0: c04efd24 c04efcd0 c037e398 c00c3a30 c04efd74 fb000=
0e0 00000000 cf813a00
[ 5300.333953] fce0: 00000020 00000020 00000000 00000020 00200200 00100=
100 c0317ac8 cf812800
[ 5300.342559] fd00: 60000113 00000020 c02eb484 00000020 c05335c0 00000=
000 c04efd54 c04efd28
[ 5300.351165] fd20: c00c4784 c037e244 cfa52800 00000008 cfa52800 00000=
020 cf812800 00000634
[ 5300.359741] fd40: c02eba04 00000000 c04efd7c c04efd58 c02eb484 c00c4=
63c cfa52800 cecb3978
[ 5300.368347] fd60: 8385d0e8 00000000 00000073 cecb3978 c04efd94 c04ef=
d80 c02eba04 c02eb454
[ 5300.376953] fd80: cfa52c80 cfa52800 c04efdac c04efd98 c0285c74 c02eb=
9e4 019caec5 cfa52800
[ 5300.385559] fda0: c04efdd4 c04efdb0 c0286b74 c0285c58 c0017b30 c0548=
030 cfa4ff40 cfa4ff40
[ 5300.394165] fdc0: 60000113 cfa74f40 c04efdfc c04efdd8 c0287e54 c0286=
b0c cfa4ff40 00000000
[ 5300.402740] fde0: d26d4260 d08d0660 cfa52800 c04ee000 c04efe1c c04ef=
e00 c0287f2c c0287db0
[ 5300.411346] fe00: 00000000 cfa74f40 00000040 00000040 c04efe3c c04ef=
e20 c0288a98 c0287e6c
[ 5300.419952] fe20: 00000001 cfa52c8c 00000001 00000001 c04efe64 c04ef=
e40 c0287048 c0288a58
[ 5300.428558] fe40: c0286fac cfa52c8c 00000001 00000040 0000012c c0509=
978 c04efe9c c04efe68
[ 5300.437164] fe60: c02f5694 c0286fb8 00000001 0009c410 c04efebc 00000=
001 00000003 0000000c
[ 5300.445739] fe80: c05468d0 c05468cc 411fc087 c04ee000 c04efee4 c04ef=
ea0 c0034d1c c02f55f0
[ 5300.454345] fea0: 00000044 c04fa1c0 411fc087 0000000a c05468c0 00000=
100 c007632c c04ee000
[ 5300.462951] fec0: 00000044 00000000 00000044 c04fa1c0 411fc087 00000=
000 c04efefc c04efee8
[ 5300.471557] fee0: c0035220 c0034c78 c007633c c0522b6c c04eff1c c04ef=
f00 c000f0d0 c00351a0
[ 5300.480163] ff00: 00000044 fa200000 c04eff40 c0535aa0 c04eff3c c04ef=
f20 c00085cc c000f098
[ 5300.488769] ff20: c000f448 20000013 ffffffff c04eff74 c04effac c04ef=
f40 c000e3c0 c0008564
[ 5300.497344] ff40: 00000000 00000000 00000000 00000001 c04ee000 c04ee=
000 c05351c8 c04ee000
[ 5300.505950] ff60: c04fa1c0 411fc087 00000000 c04effac c04eff30 c04ef=
f88 c00794c8 c000f448
[ 5300.514556] ff80: 20000013 ffffffff 00000000 c04f6f68 c0535140 00000=
000 c078b140 80004059
[ 5300.523162] ffa0: c04effbc c04effb0 c03753b4 c000f40c c04efff4 c04ef=
fc0 c04b179c c0375358
[ 5300.531768] ffc0: 00000000 00000000 c04b12e0 00000000 00000000 c04d5=
194 10c5387d c04f608c
[ 5300.540344] ffe0: c04d5190 c04fa1b4 00000000 c04efff8 80008040 c04b1=
55c 00000000 00000000
[ 5300.548950] Backtrace:=20
[ 5300.551544] [<c00c3a24>] (check_slabp+0x0/0xf4) from [<c037e398>] (c=
ache_alloc_refill+0x160/0x754)
[ 5300.560974]=C2=A0 r8:cf816440 r7:cecb905c r6:0000000c r5:00000004 r4=
:cee4a000
[ 5300.568054] [<c037e238>] (cache_alloc_refill+0x0/0x754) from [<c00c4=
784>] (kmem_cache_alloc+0x154/0x164)
[ 5300.578033] [<c00c4630>] (kmem_cache_alloc+0x0/0x164) from [<c02eb48=
4>] (__alloc_skb+0x3c/0xfc)
[ 5300.587188] [<c02eb448>] (__alloc_skb+0x0/0xfc) from [<c02eba04>] (_=
_netdev_alloc_skb+0x2c/0x54)
[ 5300.596435] [<c02eb9d8>] (__netdev_alloc_skb+0x0/0x54) from [<c0285c=
74>] (emac_rx_alloc+0x28/0x64)
[ 5300.605865]=C2=A0 r4:cfa52800 r3:cfa52c80
[ 5300.609619] [<c0285c4c>] (emac_rx_alloc+0x0/0x64) from [<c0286b74>] =
(emac_rx_handler+0x74/0x11c)
[ 5300.618865]=C2=A0 r4:cfa52800 r3:019caec5
[ 5300.622619] [<c0286b00>] (emac_rx_handler+0x0/0x11c) from [<c0287e54=
>] (__cpdma_chan_free+0xb0/0xbc)
[ 5300.632232]=C2=A0 r6:cfa74f40 r5:60000113 r4:cfa4ff40
[ 5300.637115] [<c0287da4>] (__cpdma_chan_free+0x0/0xbc) from [<c0287f2=
c>] (__cpdma_chan_process+0xcc/0x104)
[ 5300.647186] [<c0287e60>] (__cpdma_chan_process+0x0/0x104) from [<c02=
88a98>] (cpdma_chan_process+0x4c/0x64)
[ 5300.657318]=C2=A0 r7:00000040 r6:00000040 r5:cfa74f40 r4:00000000
[ 5300.663299] [<c0288a4c>] (cpdma_chan_process+0x0/0x64) from [<c02870=
48>] (emac_poll+0x9c/0x208)
[ 5300.672424]=C2=A0 r6:00000001 r5:00000001 r4:cfa52c8c r3:00000001
[ 5300.678405] [<c0286fac>] (emac_poll+0x0/0x208) from [<c02f5694>] (ne=
t_rx_action+0xb0/0x1a8)
[ 5300.687194]=C2=A0 r8:c0509978 r7:0000012c r6:00000040 r5:00000001 r4=
:cfa52c8c
[ 5300.694061] r3:c0286fac
[ 5300.696838] [<c02f55e4>] (net_rx_action+0x0/0x1a8) from [<c0034d1c>]=
 (__do_softirq+0xb0/0x1d8)
[ 5300.705902] [<c0034c6c>] (__do_softirq+0x0/0x1d8) from [<c0035220>] =
(irq_exit+0x8c/0x94)
[ 5300.714416] [<c0035194>] (irq_exit+0x0/0x94) from [<c000f0d0>] (hand=
le_IRQ+0x44/0x94)
[ 5300.722656]=C2=A0 r4:c0522b6c r3:c007633c
[ 5300.726409] [<c000f08c>] (handle_IRQ+0x0/0x94) from [<c00085cc>] (om=
ap3_intc_handle_irq+0x74/0x84)
[ 5300.735839]=C2=A0 r6:c0535aa0 r5:c04eff40 r4:fa200000 r3:00000044
[ 5300.741821] [<c0008558>] (omap3_intc_handle_irq+0x0/0x84) from [<c00=
0e3c0>] (__irq_svc+0x40/0x60)
[ 5300.751129] Exception stack(0xc04eff40 to 0xc04eff88)
[ 5300.756439] ff40: 00000000 00000000 00000000 00000001 c04ee000 c04ee=
000 c05351c8 c04ee000
[ 5300.765045] ff60: c04fa1c0 411fc087 00000000 c04effac c04eff30 c04ef=
f88 c00794c8 c000f448
[ 5300.773651] ff80: 20000013 ffffffff
[ 5300.777313]=C2=A0 r7:c04eff74 r6:ffffffff r5:20000013 r4:c000f448
[ 5300.783294] [<c000f400>] (cpu_idle+0x0/0xb8) from [<c03753b4>] (rest=
_init+0x68/0x80)
[ 5300.791412]=C2=A0 r8:80004059 r7:c078b140 r6:00000000 r5:c0535140 r4=
:c04f6f68
[ 5300.798309] r3:00000000
[ 5300.801055] [<c037534c>] (rest_init+0x0/0x80) from [<c04b179c>] (sta=
rt_kernel+0x24c/0x290)
[ 5300.809753] [<c04b1550>] (start_kernel+0x0/0x290) from [<80008040>] =
(0x80008040)
[ 5300.817535] Code: e58d3008 e3a03010 e59f100c eb04f0a3 (e7f001f2)=20
[ 5300.824005] ---[ end trace 018554de1af4a1fb ]---
[ 5300.828887] Kernel panic - not syncing: Fatal exception in interrupt



----- Original Message -----
=46rom: CF Adad <cfadad@rocketmail.com>
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Sent: Tuesday, June 5, 2012 12:29 PM
Subject: Re: Please help!  AM35xx mm/slab.c BUG

Hi Tony,

Thanks so much for the response!=C2=A0 All good suggestions.

#1.) Missing retention/off idle workarounds
I'm highly suspect of this one.=C2=A0 I've seen a lot of patches addres=
sing things in this category come out recently for the Sitara series, a=
nd we've tried to incorporate everything we've seen.=C2=A0 We also reba=
sed our tree off the linux-omap masteras recently as May 17th.=C2=A0 As=
 I mentioned in the first post, I hope to do this again soon, perhaps t=
oday even, to pull in all the good work you folks have done bringing us=
 up to the RCs of 3.5.


Since we discovered the "nohlt" option, we've added it to our default k=
ernel command line and have been using with it.=C2=A0 For a while, I th=
ought maybe that had fixed the glitch, but then yesterday came along...=
=C2=A0 That crash from the first message occured with 'nohlt' enabled.


#2.) Broken Memory
We really hammered this one as well, as TechNexion delivered our boards=
 with 256MB of NANYA NT5TU64M16GG=E2=80=93AC RAM.=C2=A0 Since we were u=
nfamiliar with that part, we rolled up our sleeves and evaluated every =
timing and configuration paramter in x-loader using the EMIF4 settings =
calculator spreadsheet provided by TI.=C2=A0 We also have been running =
cycles of "memtester 200M" calls, and the board seems to hold up fine u=
nder that with both the default, very conservative timings and the more=
 optimized ones we determinded with the TI sheet.

I'll give your suggestion of limiting the memory a shot and see if that=
 makes a difference.=C2=A0 Several of our older captures were run with =
SLAB_DEBUG set, but it seemed at the time that we weren't getting any m=
ore info out of that so we disabled it.=C2=A0 I'll re-enable.

#3.) Software bugs
We're certainly not opposed to the idea that we're doing something wron=
g.=C2=A0 :)=C2=A0 In fact, that would almost seem likely at this point.

A few other things that may be helpful:

* Could these issues be related to our GPMC?
We're using the SMSC LAN9221 on our board, not the slower LAN9220 that =
it seems all the AM35xx dev. kits are using.=C2=A0 Frankly, the fastest=
 we could get with that chip was ~40Mbps with a ~1-2% packet loss.=C2=A0=
 :-(=C2=A0 So, we stepped up to the faster LAN9221 that's used by Gumst=
ix and several others on the OMAP series.=C2=A0 It's running super-well=
 right now (> 80Mbps with 0% loss) with the faster GPMC timings and con=
figuration provided with the Gumstix source.=C2=A0 Is there perhaps a r=
eason all the AM35xx boards were using the LAN9220 instead?=C2=A0 We as=
sumed the AM35xx GPMC was essentially as capable as the OMAP's.=C2=A0 W=
as that a faulty assumption?

Speaking of GPMC, our NAND that Technexion is delivering requires a 4-b=
it ECC.=C2=A0 As support for that seems spotty at the moment in the var=
ious bootloader and kernel configurations, we finally punted and simply=
 used Micron's on-die engine to do it.=C2=A0 It appears stable, and we'=
ve done various filesystem burn-in tests to stress it.=C2=A0 At little =
while back we also rigged a combination nandtest + iperf across the SMS=
C to really stress the GPMC.=C2=A0 This too ran fine for several iterat=
ions.

*DaVinci EMAC?:
Perhaps it's just my latest thought-of-the-day, but since I saw so many=
 of these things yesterday while focusing on Ethernet work, after seein=
g none for the past several days doing other work, I can't help but thi=
nk it may be related to the networks somehow.=C2=A0 Some of our TAM3517=
's do not have the SMSC hooked up to them.=C2=A0 They are just using th=
eir EMAC adapters, but they have exhibited these SLAB crashes too.=C2=A0=
 So, maybe it's the EMAC?


We've noticed that when we run bandwdith tests between a pair of EMACs =
using iperf, we get a pretty reduced data rate, maybe 60Mbps.=C2=A0 The=
re is also the occasional dropped packet.=C2=A0 When we connect and EMA=
C to another port, say a laptop or a Gumstix SMSC, we get blazing perfo=
rmance.=C2=A0 That seems very odd.=C2=A0 It's like the driver is more t=
han capable of producing those high-class speeds, but when two of them =
get together they agree to dog it.=C2=A0 Could this maybe be related???


Thanks again for you time and help!




----- Original Message -----
=46rom: Tony Lindgren <tony@atomide.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Sent: Tuesday, June 5, 2012 3:08 AM
Subject: Re: Please help!=C2=A0 AM35xx mm/slab.c BUG

* CF Adad <cfadad@rocketmail.com> [120604 23:47]:
> All,
>=20
> I'm **really** hoping someone out there can help us with this.
>=20
> My team has been working with the AM3517 for several months now, and =
we seem to be plagued every so often by what we have termed the "slab b=
ug".=C2=A0 In short, it looks something like the pasted bootlog below.=C2=
=A0 This has been an *incredibly* hard bug to figure out.=C2=A0 We have=
 a couple of different AM3517-based platforms at our disposal, but the =
one we see the issue on almost exclusively is a custom, prototype baseb=
oard designed around the TechNexion TAM3157.=C2=A0 Over the last severa=
l months, we have tried several versions of the Linux off the linux-oma=
p tree, with loads of different configurations, and even different boot=
loader versions and combinations.=C2=A0 We've spent most of our time wi=
th a linux-omap snapshot that was a 3.2-rc6, and more recently a 3.4-rc=
6 from late a week or two back.=C2=A0 (Tomorrow I anticipate pulling th=
e latest 3.5 now that I see it's out.)=C2=A0 In all cases, since we swi=
tched to 3.0+, we've seen these errors.
>=20
> They are *very* inconsistent in when they occur, but they happen ofte=
n enough to be very frustrating.=C2=A0 Consequently, our team has had a=
n incredibly difficult time tracking what's causing them.=C2=A0 They se=
em to occur at random, perhaps on average once every handful of days.=C2=
=A0 We've messed with everything we can think of from tweaking kernel o=
ptions (like enabling/disabling preemption), to disabling various drive=
rs and userspace components, to reviewing every single line in any of o=
ur board files.=C2=A0 We have tried different versions and combinations=
 of the OS and both bootloaders (x-loader & u-boot), and even went so f=
ar as to do a full analysis of the RAM timings in the EMIF4.=C2=A0 Unfo=
rtunately, nothing so far has worked.=C2=A0 The error occurs when opera=
ting off both the SD/MMC and the NAND devices, with or without the Ethe=
rnets (LAN9221 & EMAC) up and/or running, with or without PREEMPT, unde=
r heavy load and sometimes just idling, ...=C2=A0 There is simply nothi=
ng
>=C2=A0 consistent about it.=C2=A0 After probably 2 weeks without seein=
g one, I saw 3 today.
>=20
> Though the error's occurence is inconistent, the error itself is.=C2=A0=
 It always throws an internal OOPs at the following section of code in =
mm/slab.c:
> ---
> /*
> * The slab was either on partial or free list so
> * there must be at least one object available for
> * allocation.
> */
> BUG_ON(slabp->inuse >=3D cachep->num);
> ---
> (It appears this was patched in eons ago: https://lkml.org/lkml/2007/=
2/19/20.=C2=A0=C2=A0So it's nothing new.)

I can think of at least three issues causing errors like this:

1. Missing retention/off idle workarounds

=C2=A0=C2=A0 You can test this one by booting with nohlt cmdline option=
 and
=C2=A0=C2=A0 seeing if that helps.

2. Broken memory

=C2=A0=C2=A0 I've seen at least one case of this where things would wor=
k
=C2=A0=C2=A0 fine if only half of the memory was in use and devices wou=
ld
=C2=A0=C2=A0 oops at random point within a week. To test for this you c=
an
=C2=A0=C2=A0 pass cmdline options to artifically partition the memory a=
nd
=C2=A0=C2=A0 leave out some chunks to see if that helps. Or boot with
=C2=A0=C2=A0 mem=3DxxxM set to half of the physical memory. And run you=
r tests
=C2=A0=C2=A0 with SLAB_DEBUG set.

3. Software bugs

=C2=A0=C2=A0 My experience is that things are behaving very reliably re=
garding
=C2=A0=C2=A0 cache and highmem, so I would check #1 and #2 fist.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
