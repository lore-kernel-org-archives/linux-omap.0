From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and
 G121X1-L01 LCD displays
Date: Fri, 24 Aug 2012 11:38:29 +0300
Message-ID: <1345797509.2614.10.camel@deskari>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>
	  <1345023063.3494.20.camel@deskari> <502BBFBB.6090303@8d.com>
	 <1345546189.4085.52.camel@deskari> <50339B3A.3020005@8d.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-hvcGPIof9pYo9kxqJrnP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:57838 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757098Ab2HXIih (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 04:38:37 -0400
Received: by lbok6 with SMTP id k6so913621lbo.9
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 01:38:34 -0700 (PDT)
In-Reply-To: <50339B3A.3020005@8d.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Cc: linux-omap@vger.kernel.org


--=-hvcGPIof9pYo9kxqJrnP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 10:29 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
> On 21/08/12 06:49 AM, Tomi Valkeinen wrote:
> > On Wed, 2012-08-15 at 11:26 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
> >=20
> >>> +
> >>> +	/* ChiMei G121S1-L01 */
> >>> +	{
> >>> +		{
> >>
> >> ...
> >>
> >>> +			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> >>> +			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> >>> +			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
> >>> +			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
> >>> +			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
> >>
> >> Actually those 3 panels only use the DE signal. The hsync/vsync signal=
s
> >> are not used and on our system we mux them out to make sure they are
> >> kept low as recommended in the panel datasheets.
> >>
> >> Since vsync/hsync are not used, I think the vsync_level, hsync_level a=
nd
> >> sync_pclk_edge entries could be removed. Otherwise the updated patch
> >> works fine as is.
> >=20
> > Okay. How do panels like that work? How can they know where a new frame
> > starts?
>=20
> By DE being inactive for a different number of pixel clock cycles during
> the vertical and horizontal blanking periods.

Ok. Interesting architecture. I wonder what's the reason for a design
like that...

> > Actually, I now googled for those panels, and they are all LVDS panels,
> > not DPI panels. So the patch doesn't look correct at all.
> >=20
> > Do you have a DPI-to-LVDS converter chip on your board?
>=20
> Yes, we do. Depending on the board, we use a SN75LVDS83B or a SN65LVDS84.
>=20
> The reason for using this approach was that the panels covered by
> this patch seemed not to be compatible with Flatlink 3G, which meant
> driving them directly from the AM35xx SDI serial interface was not possib=
le.
> We unfortunately do not get to select which LVDS deserializer is
> used at the panel side..

Ok. I'm a bit reluctant to add the panels to panel-generic-dpi.c, as
they are not DPI panels at all. Also, you should have drivers for the
DPI-to-LVDS converters. However, this cannot be done properly with the
current DSS driver model, so I'm not sure what to do with your patch.

If you had just one panel and DPI-to-LVDS chip, I'd suggest to create a
combined driver which handles both the chip and the panel. But you have
two chips and three panels...

I'm hoping the common panel framework which is being discussed on the
mailinglists will help here. For the moment, I think it's best if you
keep the panel patches in your kernel tree, and see later how to add
them to common panel framework.

 Tomi


--=-hvcGPIof9pYo9kxqJrnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQNz2FAAoJEPo9qoy8lh71dKAQAK7F1D0l3lIgOqJKe2KypJar
20gCF04n4yxCB1iXOp1vnNAmgnGoFyyvXQFT7AyTXeAvy0sQyNFs1WYkG0Ai8if+
1s8IAa5Dhx/F1NKnDAptJ+TOGcJo3AhslARBhfJoIoO1yY2vr7e4/yjaiSzOzoNe
zbTOdQcZ9i2mLTChQj/hRXHQtzTIsCP/P8Zh4HkxS0VBd6qzZZsWZf7HJ3Qmp+1E
KJ8L/QIQmGhUE7jtYbGG0hIZKfcS5GAX7jj1iqo6wiguF/pqP0QjLGLI4ngyTwBd
YTtMTppO0xFZFLpQatD48Up98ZOwDUFh8ptOtRw2MiPFine0pi1KcUmMazNDx4bz
q+0tBgj5ziJz5AvU7wrLRwX1tQlTedVqRjbCXTH03e7SRgCTM783vz/hhLT4915X
QR3aHlFCVuSKax/k+lpgh0HcH8KrOqIzWX5Lhhr6jn2RqAn4hlm4Q7z+/zKP1w0z
nlLdFm1BX1am6iOYKMQ5q6PXAyeXrv7T4TtmPb1NRqGduhK2+bdbX+Ep+WerC3qq
ej0LIPPVi6AVQrgG2d//dYhn0X/wU0nsrVMihwSh9r9BYKKK3e8lcWf3RlUXZpra
Z/RGc6+3XNx+QBAy2U3Ff931rPMZDKnuTD65EbEgqwWl4B8Nl9HcQrHzHc9P8W7j
HNXZnMSGdd6fZNRt/kNa
=2s7/
-----END PGP SIGNATURE-----

--=-hvcGPIof9pYo9kxqJrnP--

