From: "Johnson, Steve-OMAP" <stevej@ti.com>
Subject: RE: H4 with 2.6.9 from TI dev site not booting
Date: Mon, 2 Oct 2006 06:10:39 -0500
Message-ID: <8C5B35906ACE4C48ACB3E1FAC65DB5B6B986E2@dlee08.ent.ti.com>
References: <006201c6e602$fb6fd090$642aa8c0@Buffy>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <006201c6e602$fb6fd090$642aa8c0@Buffy>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

http://linux.omap.com/pub/kernel/h4/source/linux-2.6.10-omap2420-omap243
0.tgz

Regards,

Steve
=20

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Richard Copeman
> Sent: Monday, October 02, 2006 4:13 AM
> To: Woodruff, Richard
> Cc: linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
>=20
> Hi Richard,
>=20
> Do you have a link for 2.6.10
>=20
> Linux.omap.com only gives the option of 2.6.9 for 2420.
>=20
> Thanks,
>=20
> Richard
>=20
> -----Original Message-----
> From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> Sent: 29 September 2006 16:22
> To: Richard Copeman; linux-omap-open-source@linux.omap.com
> Subject: RE: H4 with 2.6.9 from TI dev site not booting
>=20
> Richard,
>=20
> Using a cmm file alone prior to booting the kernel may not=20
> work well, unless your CMM file is very complete in the way=20
> it sets up DDR.  There are some bits about using lock/unlock=20
> mode which can cause issues. I don't expect you have that.
>=20
> Generally, I just use a CMM file to burn in u-boot, and I=20
> know the u-boot sets up the memory properly.
>=20
> A recent H4 board could also cause some trouble=20
> unfortunately.  The H4 variants in the past have been=20
> populated by something like 6 different memory components. =20
> Recently, someone had informed me that they switched the=20
> component again as the previous part was end of lifed.  I've=20
> don't have that version of the board so I have not tried it. =20
> I suspect your CMM file could be even more wrong then it was=20
> before on that board.
>=20
> I'll send you a recent u-boot build and you can try it on your board.
> If it doesn't work, then yet another memory part needs to be=20
> added to the probe sequence... Or you might be able to get=20
> away with updating your CMM file.
>=20
> The 2430 download area had a 2.6.10 which worked for both=20
> 2420 and 2430.
> That image was much better than the 2.6.9 one.  We have some=20
> programs requiring a couple newer kernel versions which are=20
> underway, but those are at fairly early stages and may not=20
> have undergone h4 testing.
>=20
> Regards,
> Richard W.
>=20
> > -----Original Message-----
> > From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]
> > Sent: Friday, September 29, 2006 9:53 AM
> > To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> >=20
> > Hi Richard,
> >=20
> > The 2.6.9 I downloaded from linux.ti.com as the latest supported=20
> > version.
> > I have 2.6.15 running on my 5912OSK but it didn't have the=20
> defconfig=20
> > for the
> > H4 as part of the package that I got.
> > There is no reason why I am sticking with 2.6.9 except that=20
> it built=20
> > and it's early days yet. I am happy to change if you can=20
> point me in=20
> > the right direction...
> >=20
> > I am not using U-boot but downloading vmlinux via JTAG to=20
> the target.=20
> > I have the debugger doing most of the board setup to the=20
> point where I=20
> > have external memory and the WD is disabled.
> >=20
> > My Device is OMAP X2420CZVL 550667VL YB. How do I tell=20
> which memory it=20
> > has on it? AFAIK, it's a fairly recent board; acquired from=20
> TI about 8=20
> > weeks ago.
> >=20
> > I have managed to trap at the panic function and the buf=20
> contains the=20
> > string "Attempted to kill the idle task!" I'm guessing this=20
> is not a=20
> > good thing, right :-)
> >=20
> > If a later version is more stable or more likely to bring=20
> me success=20
> > I'm happy to migrate.
> >=20
> > Thanks.
> >=20
> > Richard.
> >=20
> > -----Original Message-----
> > From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> > Sent: 29 September 2006 15:42
> > To: Richard Copeman; linux-omap-open-source@linux.omap.com
> > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> >=20
> > Richard,
> >=20
> > I think you may be attacking this from a less than optimal way.  Is=20
> > there any reason you need the 2.6.9 kernel per say?  There was a=20
> > 2.6.10 one which should work just fine.
> >=20
> > I would suspect that your board revision along with u-boot version=20
> > might be a lot of your problem.
> >=20
> > If you provide a u-boot dump of the board boot up, then some more=20
> > information can be clarified.
> >=20
> > I can send you a u-boot which should work across boards,=20
> assuming your=20
> > board is not too old.
> >=20
> > If you have a 2420-ES1 chip and you have a DDR part, then=20
> you will be=20
> > in for a rough ride.  You should use SDRAM in that case.  Many bugs=20
> > hardware and software have been fixed between the very=20
> first board and=20
> > the current boards...
> >=20
> > Regards,
> > Richard W .
> > > -----Original Message-----
> > > From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]
> > > Sent: Friday, September 29, 2006 9:05 AM
> > > To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
> > > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> > >=20
> > > Hi All, Richard,
> > >=20
> > > Thanks for the pointer.
> > > Grepping through the H4 header files I find that R1 needs=20
> to be set=20
> > > to 510 before I start the kernel. That brings me to the=20
> next failure=20
> > > :-(
> > >=20
> > > I'm not that familiar with the kernel start sequence so=20
> I'm looking=20
> > > for some guidance here. I have a stack trace up to the=20
> point where I=20
> > > hit a kernel
> > > panic:
> > >=20
> > > -000|panic(fmt =3D 0xC01E8468)
> > > -001|do_exit(code =3D 11)
> > > -002|die(str =3D 0xC01E6E9C, regs =3D 0x0B, err =3D -1071050528)
> > > -003|__do_kernel_fault(mm =3D 0xC02910E0, addr =3D 3223420624,
> > > fsr =3D 11, regs =3D
> > > 0xC02180C0)
> > > -004|do_page_fault(addr =3D 0, fsr =3D 5, regs =3D 0xC0217E78)
> > > -005|do_DataAbort(addr =3D 0, fsr =3D 5, regs =3D 0xC0217E78)
> > > -006|__dabt_svc(asm)
> > >  -->|exception
> > > -007|kmem_cache_alloc(?, ?)
> > > -008|send_signal(sig =3D 7, info =3D 0x1, t =3D 0xC02180C0, =
signals
> > > =3D 0xC0218338)
> > > -009|specific_send_sig_info(sig =3D 7, info =3D 0x1, t =3D =
0xC02180C0)
> > > -010|force_sig_info(sig =3D 7, info =3D 0x1, t =3D 0xC02180C0)
> > > -011|do_DataAbort(addr =3D 3624919056, fsr =3D 2056, regs =3D=20
> 0xC0217F64)
> > > -012|__dabt_svc(asm)
> > >  -->|exception
> > > -013|omap24xx_init_irq()
> > > -014|init_IRQ()
> > > -015|start_kernel()
> > > -016|__mmap_switched(asm)
> > >  ---|end of frame
> > >     |
> > >=20
> > > I'm looking for some pointers as to where I should start=20
> searching=20
> > > for the problem here. My guess is that's it's somewhere=20
> inside the=20
> > > Kernel page fault handler but I don't know enough to get beyond=20
> > > that.
> > >=20
> > > TIA,
> > >=20
> > > Richard.
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
> > > Sent: 29 September 2006 14:35
> > > To: Richard Copeman; linux-omap-open-source@linux.omap.com
> > > Subject: RE: H4 with 2.6.9 from TI dev site not booting
> > >=20
> > > It is likely your u-boot or kernel might be mis-matched=20
> with respect=20
> > > to the mach-type.
> > >=20
> > > This is just a simple error hang loop.  If it can't figure out=20
> > > processor variant or mach-type it jumps to a hang. It is likely=20
> > > either a mismatch or memory corruption.
> > >=20
> > > Regards,
> > > Richard W.
> > > =20
> > >=20
> > > > -----Original Message-----
> > > > From: linux-omap-open-source-bounces@linux.omap.com
> > > > [mailto:linux-omap-open-source-bounces@linux.omap.com]=20
> On Behalf=20
> > > > Of Richard Copeman
> > > > Sent: Friday, September 29, 2006 7:52 AM
> > > > To: linux-omap-open-source@linux.omap.com
> > > > Subject: H4 with 2.6.9 from TI dev site not booting
> > > >=20
> > > > Hi,
> > > >=20
> > > > =20
> > > >=20
> > > > I wonder if anyone has any experience with LINUX 2.6.9=20
> built with=20
> > > > gcc 3.4.1 for ARM running on TI OMAP2420 H4 board.
> > > >=20
> > > > =20
> > > >=20
> > > > I download the kernel via JTAG to 0x80000000 and start=20
> it running.=20
> > > > It runs for 35 instructions and then ends up in a tight loop at
> > > > 0x80008118 which
> > > > contains a nop followed by a branch to 0x80008118.
> > > >=20
> > > > =20
> > > >=20
> > > > Can someone point me in the right direction please?
> > > >=20
> > > > =20
> > > >=20
> > > > TIA,
> > > >=20
> > > > =20
> > > >=20
> > > > Richard.
> > > >=20
> > > > _______________________________________________
> > > > Linux-omap-open-source mailing list=20
> > > > Linux-omap-open-source@linux.omap.com
> > > > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> > > >=20
> > >=20
> > >=20
> >=20
> >=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
