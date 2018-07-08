From: Pavel Machek <pavel@ucw.cz>
Subject: Re: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
Date: Sun, 8 Jul 2018 21:37:21 +0200
Message-ID: <20180708193720.GA13262@amd>
References: <20180708174939.GA10002@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1240961297423925052=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180708174939.GA10002@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============1240961297423925052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> grep in /sys produces a nasty oops:
>=20
> I guess next step is trying to find out which file that is..

Let me see...

openat(6, "suspend",
O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
fstat64(4, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
read(4, 0x4d2000, 32768)                =3D -1 EINVAL (Invalid argument)
write(2, "grep: ", 6grep: )                   =3D 6
write(2, "/sys/kernel/debug/pm_debug/cefus"...,
47/sys/kernel/debug/pm_debug/cefuse_pwrdm/suspend) =3D 47
write(2, ": Invalid argument", 18: Invalid argument)      =3D 18
write(2, "\n", 1
)                       =3D 1
close(4)                                =3D 0
close(6)                                =3D 0
openat(5, "time", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW)
=3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
read(4, "cefuse_pwrdm (OFF),OFF:641441757"..., 32768) =3D 849
read(4, "", 28672)                      =3D 0
close(4)                                =3D 0
openat(5, "count",
O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) =3D 4
Connection to usb closed by remote host.
Connection to usb closed.
pavel@half:~$

Ok, so it seems to be:

user@devuan:~$ cat /sys/kernel/debug/pm_debug/count
(oops).

The file seems to be world-readable.

user@devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
-r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count

But on PC, that file does not exist.

Any ideas?
								Pavel


> [69642.787567] power_supply battery: driver failed to report `power_now' =
property: -22
> [69645.052368] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [69660.053009] Unhandled fault: imprecise external abort (0x1406) at 0x00=
44d038
> [69660.053039] ------------[ cut here ]------------
> [69660.053070] WARNING: CPU: 0 PID: 23862 at drivers/bus/omap_l3_noc.c:14=
7 l3_interrupt_handler+0x23c/0x380
> [69660.060150] pgd =3D 228114b5
> [69660.064788] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Re=
ad): Data Access in User mode during Functional access
> [69660.074279] [0044d038] *pgd=3Dbe500831
> [69660.076995] Modules linked in:
> [69660.094940] CPU: 0 PID: 23862 Comm: bash Tainted: G        W         4=
=2E18.0-rc3-88788-g528947b #758
> [69660.094940] Internal error: : 1406 [#1] SMP ARM
> [69660.108581] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [69660.114624] [<c010f6cc>] (unwind_backtrace) from [<c010ba50>] (show_st=
ack+0x10/0x14)
> [69660.122436] [<c010ba50>] (show_stack) from [<c086d8cc>] (dump_stack+0x=
8c/0xac)
> [69660.129699] [<c086d8cc>] (dump_stack) from [<c012d364>] (__warn+0xe8/0=
x114)
> [69660.136718] [<c012d364>] (__warn) from [<c012d458>] (warn_slowpath_fmt=
+0x38/0x48)
> [69660.144256] [<c012d458>] (warn_slowpath_fmt) from [<c03a0bdc>] (l3_int=
errupt_handler+0x23c/0x380)
> [69660.153167] [<c03a0bdc>] (l3_interrupt_handler) from [<c0176ccc>] (__h=
andle_irq_event_percpu+0x58/0x140)
> [69660.162719] [<c0176ccc>] (__handle_irq_event_percpu) from [<c0176dd0>]=
 (handle_irq_event_percpu+0x1c/0x58)
> [69660.172424] [<c0176dd0>] (handle_irq_event_percpu) from [<c0176e44>] (=
handle_irq_event+0x38/0x5c)
> [69660.181335] [<c0176e44>] (handle_irq_event) from [<c017a56c>] (handle_=
fasteoi_irq+0x94/0x124)
> [69660.189910] [<c017a56c>] (handle_fasteoi_irq) from [<c0176550>] (gener=
ic_handle_irq+0x18/0x28)
> [69660.198577] [<c0176550>] (generic_handle_irq) from [<c017664c>] (__han=
dle_domain_irq+0x54/0xb4)
> [69660.207336] [<c017664c>] (__handle_domain_irq) from [<c039fa2c>] (gic_=
handle_irq+0x4c/0xa0)
> [69660.215728] [<c039fa2c>] (gic_handle_irq) from [<c0101a2c>] (__irq_svc=
+0x6c/0x90)
> [69660.223236] Exception stack(0xecb67d40 to 0xecb67d88)
> [69660.228332] 7d40: ef7b4a64 00000000 00000001 effdeabc effdeaa0 0000000=
4 00000000 00000000
> [69660.236541] 7d60: ef7b4a64 20070013 00000006 ef7b4a74 c0e62bd8 ecb67d9=
0 c01c844c c01c813c
> [69660.244750] 7d80: 60070013 ffffffff
> [69660.248291] [<c0101a2c>] (__irq_svc) from [<c01c813c>] (release_pages+=
0x64/0x2fc)
> [69660.255798] [<c01c813c>] (release_pages) from [<c01c844c>] (pagevec_lr=
u_move_fn+0x78/0x94)
> [69660.264129] [<c01c844c>] (pagevec_lru_move_fn) from [<c01c94d4>] (lru_=
add_drain_cpu+0xc4/0xf0)
> [69660.272796] [<c01c94d4>] (lru_add_drain_cpu) from [<c01c970c>] (lru_ad=
d_drain+0x18/0x1c)
> [69660.280914] [<c01c970c>] (lru_add_drain) from [<c01e7da4>] (exit_mmap+=
0x78/0x164)
> [69660.288452] [<c01e7da4>] (exit_mmap) from [<c012aa68>] (mmput+0x44/0xf=
0)
> [69660.295196] [<c012aa68>] (mmput) from [<c020a044>] (flush_old_exec+0x3=
04/0x62c)
> [69660.302551] [<c020a044>] (flush_old_exec) from [<c0250658>] (load_elf_=
binary+0x2b4/0x13ac)
> [69660.310882] [<c0250658>] (load_elf_binary) from [<c0209c18>] (search_b=
inary_handler+0x84/0x1ac)
> [69660.319641] [<c0209c18>] (search_binary_handler) from [<c020ae24>] (__=
do_execve_file+0x508/0x684)
> [69660.328552] [<c020ae24>] (__do_execve_file) from [<c020b000>] (do_exec=
ve+0x30/0x38)
> [69660.336242] [<c020b000>] (do_execve) from [<c0101000>] (ret_fast_sysca=
ll+0x0/0x54)
> [69660.343872] Exception stack(0xecb67fa8 to 0xecb67ff0)
> [69660.348937] 7fa0:                   000d0000 000d0000 0010c8c8 0010e88=
8 000f8008 e5d25300
> [69660.357147] 7fc0: 000d0000 000d0000 0010c8c8 0000000b 0010c8c8 0010e88=
8 000f8008 b6fc6ce8
> [69660.365386] 7fe0: b6ed1711 bed367cc 0003c469 b6ed1716
> [69660.370452] ---[ end trace 03c17ec6355a559d ]---
> [69680.043853] Modules linked in:
> [69680.046936] CPU: 1 PID: 23819 Comm: grep Tainted: G        W         4=
=2E18.0-rc3-88788-g528947b #758
> [69680.056030] Hardware name: Generic OMAP4 (Flattened Device Tree)
> [69680.062103] PC is at seq_printf+0x4/0x30
> [69680.066040] LR is at __dregs_dump+0x5c/0x98
> [69680.070251] pc : [<c0226898>]    lr : [<c0120ca0>]    psr: a0000013
> [69680.076538] sp : ecb07e6c  ip : c0ae3a58  fp : 00000001
> [69680.081787] r10: 00000001  r9 : ecb02100  r8 : ecb020d0
> [69680.087036] r7 : ecb07f80  r6 : ecb020d0  r5 : 00000000  r4 : c0e10b54
> [69680.093597] r3 : 48005020  r2 : 00000000  r1 : c0ae3a2c  r0 : ecb020d0
> [69680.100158] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [69680.107330] Control: 10c5387d  Table: acb3804a  DAC: 00000051
> [69680.113128] Process grep (pid: 23819, stack limit =3D 0x5ef1c469)
> [69680.119079] Stack: (0xecb07e6c to 0xecb08000)
> [69680.123443] 7e60:                            c0ae3a2c 00000000 4800502=
0 fa005020 c0ae3a58
> [69680.131683] 7e80: ecb020d0 00008000 eca30b00 c0120d24 ecb07ea0 c0226e7=
4 00440000 00000000
> [69680.139892] 7ea0: 00000000 00000000 00000000 00000000 00000000 eca30b0=
0 ee00b5f0 00000000
> [69680.148101] 7ec0: ecb07f80 00008000 ecb06000 00440000 0043a0c8 c031a66=
8 ecb07f80 ecc15400
> [69680.156341] 7ee0: 00440000 eca30b00 ecb07f80 00008000 00440000 c0203e2=
4 00000000 00000000
> [69680.164550] 7f00: 000000c5 c0101204 00000001 eca30b08 00000000 0000000=
0 00000000 00000000
> [69680.172790] 7f20: 00000001 ee03f1c0 eca30b08 00020000 eca30b00 ecb07f8=
0 ecb06000 00440000
> [69680.180999] 7f40: 0043a0c8 00008000 eca30b00 00440000 00000000 ecb07f8=
0 00440000 c0203fb0
> [69680.189208] 7f60: 2160ec00 c0887b68 00000000 00000000 eca30b00 eca30b0=
0 00008000 c0204448
> [69680.197448] 7f80: 00000000 00000000 00000000 00008000 7fffe000 0044000=
0 00000003 c0101204
> [69680.205657] 7fa0: 00000003 c0101000 00008000 7fffe000 00000004 0044000=
0 00008000 00008000
> [69680.213897] 7fc0: 00008000 7fffe000 00440000 00000003 00000004 0043a0c=
8 00000004 0043a0c8
> [69680.222106] 7fe0: 00000000 be90013c 00421175 b6eafa76 20000030 0000000=
4 00000000 00000000
> [69680.230346] [<c0226898>] (seq_printf) from [<48005020>] (0x48005020)
> [69680.236724] Code: 3584000c 2584100c e8bd8038 e92d000e (e52de004)=20
> [69680.242858] ---[ end trace 03c17ec6355a559e ]---
> [69680.259582] cpcap_adc cpcap_adc.0: error reading ADC: -512
> [69680.265258] cpcap_battery cpcap_battery.0: cpcap_charger_battery_tempe=
rature failed: -512
> [69680.265258] power_supply battery: driver failed to report `voltage_now=
' property: -512
> [69680.287841] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltCZ/AACgkQMOfwapXb+vIqFwCfdIeY/gjrtpCV8Iw6x+c602j9
j4UAn165SadsMOgzaFSYESYj+aAESmPc
=nsX1
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


--===============1240961297423925052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1240961297423925052==--
