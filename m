From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/25] OMAPDSS: create custom pdevs for DSS omap_devices
Date: Fri, 04 May 2012 11:37:10 +0300
Message-ID: <1336120630.2701.6.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <1336053481-25433-12-git-send-email-tomi.valkeinen@ti.com>
	 <4FA37139.9020501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-dkxOHL9IHSW4uWMAhW3Z"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:39957 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928Ab2EDIhP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 04:37:15 -0400
Received: by lbok6 with SMTP id k6so2268628lbo.4
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 01:37:13 -0700 (PDT)
In-Reply-To: <4FA37139.9020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-dkxOHL9IHSW4uWMAhW3Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 11:33 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:
> > Instead of using omap_device_build() to create the omap_devices for DSS
> > hwmods, create them with a custom function. This will allow us to creat=
e
> > a parent-child hierarchy for the devices so that the omapdss_core devic=
e
> > is parent for the rest of the dss hwmod devices.
> >
> > Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> > ---
> >   arch/arm/mach-omap2/display.c |   88 ++++++++++++++++++++++++++++++++=
++-------
> >   1 file changed, 74 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/displa=
y.c
> > index 07232fd..46d2a98 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -185,13 +185,71 @@ static int omap_dss_set_min_bus_tput(struct devic=
e *dev, unsigned long tput)
> >   	return omap_pm_set_min_bus_tput(dev, OCP_INITIATOR_AGENT, tput);
> >   }
> >
> > +static struct platform_device *create_dss_pdev(const char *pdev_name,
> > +		int pdev_id, const char *oh_name, void *pdata, int pdata_len,
> > +		struct platform_device *parent)
>=20
> This function looks quite generic, it's like omap_device_build() but=20
> with a parent associated. omap_device_build() seems to be a special case=
=20
> of this function with parent passed as null. Won't this
> function be needed by other devices too?
>=20
> Maybe we could modify omap_device_build_ss() to take a parent argument,=
=20
> and make a function called omap_device_build_parent(), where both=20
> omap_device_build() and omap_device_build_parent() call=20
> omap_device_build_ss()?

Yes, that sounds good to me.

Paul, Kevin, what do you think, could the omap_device functions be
extended to allow setting a parent device?

 Tomi


--=-dkxOHL9IHSW4uWMAhW3Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo5U2AAoJEPo9qoy8lh71qiEQAJn2RX7TRjKX9E88BVwWOA6u
JyIsChQwsPjBJ4r5VNeYQIMyW0oTtgJb4qWm7ykPbGTMcalLDRpMzngx9iGWG8QV
Po7Rqee5VczUShhRLEMq0a9/xEq9Q5DrbztCJNchcT652PZkaH+DeJN14leJOCCG
jKdR7QRiSL2DKotk54QYaCv8Rw0uVG00JDYM821XobnN26Ylx1/oNkVdq6JO72sr
I4ZtRKPXx2lQEQN3MZ8n3P2awOFViUNuMr4TK4Qnf6qSekFUQsu9kKmLq/AhvXNP
S2NJrbMNanT14X1w7XeQ7dkm4pBbfb/FgZyiOm+lv4TIvjFK70kZ9RBOz3bpU/sc
fy0loFlLWVVAk8saJ1GBecs6J3ECiTW38DKbaZt+oiIViTtwj5qS4ydLUkuBTHqz
Ja6u97wfUcDpYp004Gmt35DekTN1ZbOhRlOcfM20DH/udEAa1YwV3JkPJNN6HMyU
WeeIU9lVJkVd+BX9m9m92UWuLMoBOmlddFMs+IpYOzF9r7nNjoSwPYY6+d+qVK1O
QEkguBBuFfDUSU1Qmi4zqVUuPmrO+cs/5DuNxyJhwrpTOfMu/AjOgz6Mrmd/a/8M
zbODMt1EbOz3FgE52K0xDprs7vnAB6vDf/ZJo1B+co9CiyhxVEgmBYnRYrmPulub
4iW5Al2PufOiPDxvXfbA
=mv88
-----END PGP SIGNATURE-----

--=-dkxOHL9IHSW4uWMAhW3Z--

