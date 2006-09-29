From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: H4 with 2.6.9 from TI dev site not booting
Date: Fri, 29 Sep 2006 09:41:52 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507E2E2E3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Richard,

I think you may be attacking this from a less than optimal way.  Is
there any reason you need the 2.6.9 kernel per say?  There was a 2.6.10
one which should work just fine.

I would suspect that your board revision along with u-boot version might
be a lot of your problem.

If you provide a u-boot dump of the board boot up, then some more
information can be clarified.

I can send you a u-boot which should work across boards, assuming your
board is not too old.

If you have a 2420-ES1 chip and you have a DDR part, then you will be in
for a rough ride.  You should use SDRAM in that case.  Many bugs
hardware and software have been fixed between the very first board and
the current boards...

Regards,
Richard W .
> -----Original Message-----
> From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]=20
> Sent: Friday, September 29, 2006 9:05 AM
> To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
>=20
> Hi All, Richard,
>=20
> Thanks for the pointer.
> Grepping through the H4 header files I find that R1 needs to=20
> be set to 510
> before I start the kernel. That brings me to the next failure :-(
>=20
> I'm not that familiar with the kernel start sequence so I'm=20
> looking for some
> guidance here. I have a stack trace up to the point where I=20
> hit a kernel
> panic:
>=20
> -000|panic(fmt =3D 0xC01E8468)
> -001|do_exit(code =3D 11)
> -002|die(str =3D 0xC01E6E9C, regs =3D 0x0B, err =3D -1071050528)
> -003|__do_kernel_fault(mm =3D 0xC02910E0, addr =3D 3223420624,=20
> fsr =3D 11, regs =3D
> 0xC02180C0)
> -004|do_page_fault(addr =3D 0, fsr =3D 5, regs =3D 0xC0217E78)
> -005|do_DataAbort(addr =3D 0, fsr =3D 5, regs =3D 0xC0217E78)
> -006|__dabt_svc(asm)
>  -->|exception
> -007|kmem_cache_alloc(?, ?)
> -008|send_signal(sig =3D 7, info =3D 0x1, t =3D 0xC02180C0, signals=20
> =3D 0xC0218338)
> -009|specific_send_sig_info(sig =3D 7, info =3D 0x1, t =3D 0xC02180C0)
> -010|force_sig_info(sig =3D 7, info =3D 0x1, t =3D 0xC02180C0)
> -011|do_DataAbort(addr =3D 3624919056, fsr =3D 2056, regs =3D =
0xC0217F64)
> -012|__dabt_svc(asm)
>  -->|exception
> -013|omap24xx_init_irq()
> -014|init_IRQ()
> -015|start_kernel()
> -016|__mmap_switched(asm)
>  ---|end of frame
>     |
>=20
> I'm looking for some pointers as to where I should start=20
> searching for the
> problem here. My guess is that's it's somewhere inside the=20
> Kernel page fault
> handler but I don't know enough to get beyond that.
>=20
> TIA,
>=20
> Richard.
>=20
>=20
> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]=20
> Sent: 29 September 2006 14:35
> To: Richard Copeman; linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
>=20
> It is likely your u-boot or kernel might be mis-matched with=20
> respect to
> the mach-type.
>=20
> This is just a simple error hang loop.  If it can't figure=20
> out processor
> variant or mach-type it jumps to a hang. It is likely either=20
> a mismatch
> or memory corruption.
>=20
> Regards,
> Richard W.
> =20
>=20
> > -----Original Message-----
> > From: linux-omap-open-source-bounces@linux.omap.com=20
> > [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> > Behalf Of Richard Copeman
> > Sent: Friday, September 29, 2006 7:52 AM
> > To: linux-omap-open-source@linux.omap.com
> > Subject: H4 with 2.6.9 from TI dev site not booting
> >=20
> > Hi,
> >=20
> > =20
> >=20
> > I wonder if anyone has any experience with LINUX 2.6.9 built=20
> > with gcc 3.4.1
> > for ARM running on TI OMAP2420 H4 board.
> >=20
> > =20
> >=20
> > I download the kernel via JTAG to 0x80000000 and start it=20
> > running. It runs
> > for 35 instructions and then ends up in a tight loop at=20
> > 0x80008118 which
> > contains a nop followed by a branch to 0x80008118.
> >=20
> > =20
> >=20
> > Can someone point me in the right direction please?
> >=20
> > =20
> >=20
> > TIA,
> >=20
> > =20
> >=20
> > Richard.
> >=20
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >=20
>=20
>=20
