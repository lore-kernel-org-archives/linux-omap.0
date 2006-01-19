From: Tony Lindgren <tony@atomide.com>
Subject: Re: Help me. Oops: 805 [#1]err using kernel.2.6.10.omap1patch with
	NFS(RFS)
Date: Wed, 18 Jan 2006 23:30:41 -0800
Message-ID: <20060119073041.GG4425@atomide.com>
References: <43CF3264.000001.03809@nhn427>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CF3264.000001.03809@nhn427>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: =?utf-8?B?IuyehOq3vOyLnSI=?= <invain@naver.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* "=EC=9E=84=EA=B7=BC=EC=8B=9D" <invain@naver.com> [060118 22:37]:
> It seems that my email system  problem. so i changed email address.
>=20
>=20
> Subject - Oops: 805 [#1] problem using kernel.2.6.10.omap1patch with NF=
S(RFS)=20
> -----------------------------------------=20
>=20
> I finished compiling and porting ousing kernel.2.6.10 of kernel.org and=
 patch.2.6.10.omap1. But, When I try booting with compiled zImage on omap=
5912osk board, I meet below error message. For reference, When I use Ramd=
isk(root file system), kerenl is booted successfully. Only When I use NFS=
 Root file system , error happened like belows. Please. What's reason? . =
Tell me how to solve this problem.=20
> (P.S: When I tryed "ping target.board.ip.address" command on host pc(RH=
9.0), I receviced TTL reply. )=20
>=20
> * Test Envirionment.=20
> -board : TI omap5912.osk board=20
> -Ethernet : SMC91C94 Ethernet card=20
> -kernel.org :kernel.2.6.10.tar.gz (www.kernel.org )=20
> -compiler :montavista _arm_v5=20
> -omap patch :http://www.muru.com/linux/omap/patches/patch-2.6.10-omap1.=
bz2=20
> -Rootfilesystem: NFS Root file system=20
>=20
>=20
> * When I boot kernel.2.6.10.omap1 with nfsroot , I meet "Oops: 805 [#1]=
:" mesasge like belows. ............... upper omission...................=
..=20
> eth0: link up=20
> IP-Config: Complete:=20
> device=3Deth0, addr=3D192.168.0.10, mask=3D255.255.255.0, gw=3D192.168.=
0.2,=20
> host=3D192.168.0.10, domain=3D, nis-domain=3D(none),=20
> bootserver=3D192.168.0.2, rootserver=3D192.168.0.2, rootpath=3D Looking=
 up port of RPC 100003/2 on 192.168.0.2 Looking up port of RPC 100005/1 o=
n 192.168.0.2=20
> VFS: Mounted root (nfs filesystem).=20
> Freeing init memory: 104K=20
> <------------------- Ref: After 10 minutes, Belows message appeared on =
console. Unable to handle kernel paging request at virtual address c20000=
00 pgd =3D c0010000 [c2000000] *pgd=3D00000000 Internal error: Oops: 805 =
[#1] Modules linked in:=20
> CPU: 0=20
> PC is at .insw_8_lp+0x30/0x44=20
> LR is at 0x4341=20
> pc : [] lr : [<00004341>] Not tainted=20
> sp : c0299e44 ip : 43414341 fp : c0299e98=20
> r10: c0339000 r9 : c2852000 r8 : 00000000=20
> r7 : c0339220 r6 : fffffffa r5 : 43414341 r4 : 43414341=20
> r3 : 43414341 r2 : 7fe11855 r1 : c1fffff4 r0 : c2852008=20
> Flags: nzCv IRQs on FIQs on Mode SVC_32 Segment user=20
> Control: 5717F Table: 10010000 DAC: 00000015=20
> Process init (pid: 1, stack limit =3D 0xc0298190)=20
> Stack: (0xc0299e44 to 0xc029a000)=20
> 9e40: c03f74e0 c2852000 c012de94 c1c230b2 00004030 00000007 00000033=20
> 9e60: c0339220 c033ea20 000000a0 00000000 c033ea20 00000000 00000000 00=
0000a0=20
> 9e80: c0299f40 c0299f40 fefbe418 c0299ebc c0299e9c c00232f8 c012dc14 c0=
210540=20
> 9ea0: 000000a0 c033ea20 c0299f40 c01d584c c0299edc c0299ec0 c0023454 c0=
0232bc=20
> 9ec0: 000000a1 00001e00 00000001 c0210570 c0299f08 c0299ee0 c002e7d8 c0=
0233b4=20
> 9ee0: c0299f74 fefecb00 c0298000 c0028d4c 20000013 c020e740 c0299f40 c0=
299f3c=20
> 9f00: c0299f0c c00235dc c002e744 0000001e c0299fb0 c0299f74 fefecb00 ff=
ffffff=20
> 9f20: c0028d4c 20000013 ffffffff 40127000 c0299fac c0299f40 c00223e0 c0=
02359c=20
> 9f40: c0013ff8 c0007ff8 00000000 10002401 ffff1000 c0010000 10002001 00=
000000=20
> 9f60: c0299fb0 00000000 40127000 c0299fac 00003ff8 c0299f88 c0298000 c0=
028d4c=20
> 9f80: 20000013 ffffffff fefecb00 c01d2fa0 ffff1000 60000010 00057177 c0=
299fec=20
> 9fa0: 00000000 c0299fb0 c0022718 c0028cd8 00000000 00000001 401282b8 ff=
ff0fff=20
> 9fc0: 00000000 00000000 401282b8 000012b8 00000000 00000000 40127000 00=
000000=20
> 9fe0: beffff3c befffdd8 40049b94 ffff1000 60000010 ffffffff e5903084 e3=
530001=20
> Backtrace:=20
> [] (smc_interrupt+0x0/0x6d0) from [] (__do_irq+0x4c/0x88) [] (__do_irq+=
0x0/0x88) from [] (do_edge_IRQ+0xb0/0x12c) r8 =3D C01D584C r7 =3D C0299F4=
0 r6 =3D C033EA20 r5 =3D 000000A0 r4 =3D C0210540 [] (do_edge_IRQ+0x0/0x1=
2c) from [] (gpio_irq_handler+0xa4/0xb8) r7 =3D C0210570 r6 =3D 00000001 =
r5 =3D 00001E00 r4 =3D 000000A1 [] (gpio_irq_handler+0x0/0xb8) from [] (a=
sm_do_IRQ+0x50/0x150) [] (asm_do_IRQ+0x0/0x150) from [] (__irq_svc+0x20/0=
x80) [] (do_translation_fault+0x0/0xac) from [] (ret_from_exception+0x0/0=
x10) r8 =3D C0299FEC r7 =3D 00057177 r6 =3D 60000010 r5 =3D FFFF1000 r4 =3D=
 C01D2FA0=20
> Code: e185580c e1d0c0b0 e1d0e0b0 e18cc80e (e8a11038)=20
> <0>Kernel panic - not syncing: Aiee, killing interrupt handler!=20
>=20
> end of Line.=20

This sounds like the old wrong-flash-memory-bus-timings problem with
smc91x. Try a more recent kernel and it should go away.

Tony
