From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: add omapdss_version
Date: Fri, 28 Sep 2012 14:07:47 +0300
Message-ID: <1348830467.2437.10.camel@deskari>
References: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
	 <1348828527-13309-2-git-send-email-tomi.valkeinen@ti.com>
	 <50658345.5050403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-I2uyT/f10EC9C6OOax5B"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56060 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756255Ab2I1LHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:07:52 -0400
Received: by lagh6 with SMTP id h6so980936lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 04:07:50 -0700 (PDT)
In-Reply-To: <50658345.5050403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>


--=-I2uyT/f10EC9C6OOax5B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-28 at 16:30 +0530, Archit Taneja wrote:
> On Friday 28 September 2012 04:05 PM, Tomi Valkeinen wrote:
> > Add new enum, omapdss_version, that is used to tell which DSS hardware
> > version the SoC has. This enum is initialized during platform init, and
> > passed in the platform data to omapdss driver.
> >
> > Note that the versions are not "continuous", that is, you cannot check
> > if the version is less or greater than something, but you need to check
> > for exact version match. In other words, this is invalid:
> >
> > /* test if DSS is 3630 or earlier */
> > if (ver <=3D OMAPDSS_VER_OMAP3630)
> > 	...
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/display.c |   38 ++++++++++++++++++++++++++++++++=
++++++
> >   include/video/omapdss.h       |   14 ++++++++++++++
> >   2 files changed, 52 insertions(+)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> > index ee40739..33555da 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -284,6 +284,35 @@ err:
> >   	return ERR_PTR(r);
> >   }
> >
> > +static enum omapdss_version omap_display_get_version(void)
>=20
> We could add a __init for this function?

Good point, thanks.

 Tomi


--=-I2uyT/f10EC9C6OOax5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZYUEAAoJEPo9qoy8lh718h8P/RdbL9OU7VqRc5WFcldICLep
5GFrSI5G76zhszYh8U2b0oXKfizrg8vhq1ylXd3rm6lUpXQqUu0PH90v5ydXof5V
eqcZkS7RQBw32S+rAJGORVyYoOtRTMU7lNeevzXE0CZI0DZQIF4NFf3RKgXSfAn8
hY6zq5MCJxneyAX3N8kbNwsMU6UANz8cDTDY4XCEK8O2pfwcUNPY0eB9sfSSOZcd
7JyE+cgozaiQcQJJRthGcNMpYb6ch5CWTJ7w0K+ilLMHLiCeyvzajvJus9lkDHVU
6oHM4niL3p/8IdhGvJkUAo3md9iUBi7S2teCSXOsykhxtQtKpgzQOpRmiEpLwUcR
m6PQCyA3vzTWkV2imWR31l31vA+TX7h5HhmvDIuTJljbxq4hrZ89kieP7vwoQ64B
1xHohrdJ1Fr13xre9IBH4sg1wi4AXdFqaHjJXegFlyrisDcOK0drJKTaFBB65I6n
d6YQabWCRkeNqDNRDdDey5/np3jGMvNhQIwP4IsLTa/0dNncTWX5qNWOw7OqlnfW
xD59eOxoKxx7HghU4SznBQCIWSi9nxmwb46+MHvQuh2f/uhRqpDSWNin/XpMnG4u
FW6r8hL69Qq7nmayfTxPnlbmRqziogrcASJdcvS701R68g+ktYXAGBVjDh8YNkYj
adqTmXDN/tLDR1KwjyoU
=qCSh
-----END PGP SIGNATURE-----

--=-I2uyT/f10EC9C6OOax5B--

