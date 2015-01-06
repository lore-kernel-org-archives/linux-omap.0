From: Felipe Balbi <balbi@ti.com>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Mon, 5 Jan 2015 20:01:22 -0600
Message-ID: <20150106020122.GA24980@saruman>
References: <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
 <20150105231620.GC30544@fuloong-minipc.musicnaut.iki.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbbAFCCX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Jan 2015 21:02:23 -0500
Content-Disposition: inline
In-Reply-To: <20150105231620.GC30544@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 06, 2015 at 01:16:21AM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> On Mon, Jan 05, 2015 at 09:43:13AM -0600, Felipe Balbi wrote:
> > On Sat, Jan 03, 2015 at 02:16:22PM +0200, Aaro Koskinen wrote:
> > > > > > > > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.19-=
rc2
> > > > > > > > >>>I see a "In-band ERROR" warning which wasn't present in =
3.18.1.
> > > > > > > > >>>Could it be that I missed some DT updates?
> > > > > > > > >>
> > > > > > > > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > > > > > > > >>>[    0.366912] ------------[ cut here ]------------
> > > > > > > > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/oma=
p_l3_smx.c:166 omap3_l3_app_irq+0x100/0x134()
> > > > > > > > >>
> > > > > > > > >>This appears also on N900/N950/N9...
> > > > > > > > >
> > > > > > > > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > > > > > > > >regression related to CONFIG_PREEMPT that started happening
> > > > > > > > >with the merge window?
> > > > > > > >=20
> > > > > > > > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
> > > > > > >=20
> > > > > > > Yeah, disabling CONFIG_PREEMPT helps here too. Is there some =
e-mail
> > > > > > > thread / patch set for this already; or should we try to bise=
ct this?
> > > > > >=20
> > > > > > AFAIK I'm not aware of other threads, I noticied it with the
> > > > > > "OMAP 4430 SDP: rather sick with recent kernels" thread, but
> > > > > > never got anywhere with it.
> > > > > >=20
> > > > > > Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
> > > > > > that too should be verified. Sounds like running git bisect on
> > > > > > this one is needed.
> > > > >=20
> > > > > I tried to bisect this on N950, and it resulted in:
> > > > >=20
> > > > > aa25729cfd9709156661bea0f9293deb7729f57a is the first bad commit
> > > > > commit aa25729cfd9709156661bea0f9293deb7729f57a
> > > > > Author: Tony Lindgren <tony@atomide.com>
> > > > > Date:   Wed Nov 5 09:21:23 2014 -0800
> > > > >=20
> > > > >     ARM: OMAP3: Fix errors for omap_l3_smx when booted with devic=
e tree
> > > > >=20
> > > > > But when I tried to revert this from 3.19-rc2, my board won't boo=
t at
> > > > > all...
> > > >=20
> > > > Hmm OK that commit just fixed the omap_l3_smx so we now see
> > > > warnings about the unclocked register access.
> > > >=20
> > > > It seems that probably the CONFIG_PREEMPT issue has been lurking
> > > > around for longer but we have not seen any errors because
> > > > omap_l3_smx just recently started exposing them.
> > > >=20
> > > > Does v3.18 + commit aa25729cfd9 manually applied also produce
> > > > the CONFIG_PREEMPT errors?
> > >=20
> > > Yes it does, so I made another bisection between 3.17 and 3.18
> > > using the above patch to trigger the issue, and I got:
> > >=20
> > > 55601c9f24670ba926ebdd4d712ac3b177232330 is the first bad commit
> > > commit 55601c9f24670ba926ebdd4d712ac3b177232330
> > > Author: Felipe Balbi <balbi@ti.com>
> > > Date:   Mon Sep 8 17:54:58 2014 -0700
> > >=20
> > >     arm: omap: intc: switch over to linear irq domain
> >=20
> > Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
> > Perhaps this is something related to another OMAP3-only driver ? Perhaps
> > HSI/SSI ?
>=20
> I did some debugging and it seems the "In-band Error"
> occurs when omap_system_dma_probe() is being run, specifically when
> the interrupt is enabled. I believe the "DMA" interrupt it's trying
> set up is completely wrong:
>=20
>  28:          0      GPIO   2  DMA
>=20
> GPIO 2?! Where is that coming from?

heh, it's probably the linux number used ended up mapping to another irq
domain. Can you add this debugging patch and report dmesg ?

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 24770e5..b3f6dcd 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1380,6 +1380,8 @@ static int omap_system_dma_probe(struct platform_devi=
ce *pdev)
 	if (dma_omap2plus() && !(d->dev_caps & DMA_ENGINE_HANDLE_IRQ)) {
 		strcpy(irq_name, "0");
 		dma_irq =3D platform_get_irq_byname(pdev, irq_name);
+		dev_info(&pdev->dev, "legacy DMA IRQ %d\n", dma_irq);
+
 		if (dma_irq < 0) {
 			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
 			ret =3D dma_irq;
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index c0016a6..98fe2d2 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1155,6 +1155,8 @@ static int omap_dma_probe(struct platform_device *pde=
v)
 	}
=20
 	irq =3D platform_get_irq(pdev, 1);
+
+	dev_info(&pdev->dev, "dmaengine IRQ %d\n", irq);
 	if (irq <=3D 0) {
 		dev_info(&pdev->dev, "failed to get L1 IRQ: %d\n", irq);
 		od->legacy =3D true;

Note that I need one log post commit and another log pre commit. If any
of the IRQ numbers change, if means that irq_domain_add_linear() ended
up changing IRQ start and we would need some trick to grab the correct
IRQ number again.

cheers

--=20
balbi

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUq0HyAAoJEIaOsuA1yqRESEIP/R/q0kknACO3i7rBY1CE+RyO
QCpVivQwQ5enSIXgxVuf+fgD78MnaNyX9cqVucWVBdldAYskXmdp5iROKfaeW2oh
npdrxCQlOXXJ9wDX/wxGFz24L6i7oorwrT+oo5YzlO3CFVEHfCRRhrHRprcvzOs0
mU6DQN3aLrOVbyzKA77hsSjRfmc+49keecz+iDsTlcWZw7jScOEnQ3Rmsn/HoNS8
2yhhNsVOWhYyw8BiGSqrg4tmtLN712NlCEN2lwOQGlXuRhw59uSNVh7pYe03KpSg
ttF2kEdU+Zt03dttsOP2QgfS2qTDS9SvJAwktJqkYImTb7m9f2+rDwYWaQq8avAi
ns9Wbvd1zPSFSjBdrjHNgejZWG3TvxYLx5a6k78hxe069mjgjgYLRohVI7dJ4X25
zemBZBe1TAt4CAy4iaLztRq3EDytk4jlvNgGt1pyuRtd36ow4IfOR3RoPJCTpLcj
e8lQQR8Fs6pO8OEFBc90lrbxHOTgVJk0jCIxmx7PxCb0sXVuGzTnRUaV9nMDBDvX
R4YrP2njwOlfh1lkbQyILNhtuFarjBteN4A0r8wqda0xrx1ne+yKSeeMEiVJKkx9
6upKF0Vc/ZmhM0Vtio0uXiLH9NdjURVsJRD3MhOQZ/s/WAQHSn31IsPVBQGQiu1y
l/ThlSk96OsPV/TugezE
=l/mA
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
