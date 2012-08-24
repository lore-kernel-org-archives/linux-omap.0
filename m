From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/8] OMAPDSS: HDMI: use vdda_hdmi_dac
Date: Fri, 24 Aug 2012 09:41:20 +0300
Message-ID: <1345790480.9287.14.camel@lappyti>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
	 <1345729514-2441-5-git-send-email-tomi.valkeinen@ti.com>
	 <50371D27.1010707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-TkqYNtxIpnsiawpO4iwq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51007 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753243Ab2HXGl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 02:41:26 -0400
Received: by lahl5 with SMTP id l5so768153lah.15
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 23:41:23 -0700 (PDT)
In-Reply-To: <50371D27.1010707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-TkqYNtxIpnsiawpO4iwq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-24 at 11:50 +0530, Archit Taneja wrote:
> On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> > The HDMI driver requires vdda_hdmi_dac power for operation, but does no=
t
> > enable it. This has worked because the regulator has been always
> > enabled.
> >
> > But this may not always be the case, as I encountered when implementing
> > HDMI device tree support.
> >
> > This patch changes the HDMI driver to use the vdda_hdmi_dac.
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >   drivers/video/omap2/dss/hdmi.c |   23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/h=
dmi.c
> > index 96a6e29..ccfc677 100644
> > --- a/drivers/video/omap2/dss/hdmi.c
> > +++ b/drivers/video/omap2/dss/hdmi.c
> > @@ -33,6 +33,7 @@
> >   #include <linux/pm_runtime.h>
> >   #include <linux/clk.h>
> >   #include <linux/gpio.h>
> > +#include <linux/regulator/consumer.h>
> >   #include <video/omapdss.h>
> >
> >   #include "ti_hdmi.h"
> > @@ -62,6 +63,7 @@ static struct {
> >   	struct hdmi_ip_data ip_data;
> >
> >   	struct clk *sys_clk;
> > +	struct regulator *vdda_hdmi_dac_reg;
> >
> >   	int ct_cp_hpd_gpio;
> >   	int ls_oe_gpio;
> > @@ -331,6 +333,19 @@ static int __init hdmi_init_display(struct omap_ds=
s_device *dssdev)
> >
> >   	dss_init_hdmi_ip_ops(&hdmi.ip_data);
> >
> > +	if (hdmi.vdda_hdmi_dac_reg =3D=3D NULL) {
> > +		struct regulator *reg;
> > +
> > +		reg =3D devm_regulator_get(&hdmi.pdev->dev, "vdda_hdmi_dac");
>=20
> There is no corresponding devm_regulator_put() call here, I guess that's=
=20
> what devm_* calls are supposed to help us with. But the only place I saw=
=20
> the usage of dev_regulator_get() is here:
>=20
> sound/soc/ux500/ux500_msp_dai.c
>=20
> And here, they are doing devm_regulator_put() calls to, so I was=20
> wondering what the deal is.

No idea. But there are other places also: sound/soc/codecs/wm5100.c,
sound/soc/codecs/wm8996.c, sound/soc/soc-dapm.c, and those don't use
put().

Anyway, I think it's quite clear how devm_* functions are used, so the
put call in ux500_msp_dai.c is probably just a mistake.

I also want to mention that doing the regulator_get in
hdmi_init_display() is somewhat strange, but the point is to do the
regulator_get only if a hdmi display has been defined in the board file.
If we did it unconditionally in hdmi's probe, we'd try to get the
regulator always, and it could be that there's no regulator if the hdmi
is not used on a particular board. This is again something that feels
hackish, and I'd like to find a cleaner solution to it.

 Tomi


--=-TkqYNtxIpnsiawpO4iwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQNyIQAAoJEPo9qoy8lh71Sl0P+gNBv0NnRxQLe1OzfvB+CmMY
OtDFCHCYTH7DBgeR/ILKj3NV6/RAmZYuovo5VDKtahHGMaiCHM0rBLBn84vmV08N
ZngWDae43vLhDqS3RlkmauQ/JjiKKpUWRPxxxssFP556ZtfVFFBGOrKew+5ETEko
AT9D6n0BfBIvQbUFC89gIrrahkUYxruo42+7wldOwOmjvK74jTQFhWv1IvW2KtRx
OzRNNme6/o6Ix9WhpWbhRwTrzrzCV1rqVzETepcB/hEQQYVZF/dzmoC70Q12jBO9
YGr7Mok4wHz+spb1rGtvZxGE2u5mTdx0zYj+6tiLIzABV1P5oqItQqyp0sYwXimc
oEdocXD+WZ19gju1fXDsj/1PT32TVePdQGuBaH+KbP2+lxL1bXOVFCwqCyTbWLrc
j5PGeKcxs17P7d8MrNxNkLh2RVCSsnH7tWi6/VW1Za2AUSEyGPfnB8739UMW86ja
Lb/hGUBQ2XFd+cMjgTkecZZzRCaoiTyBgHWWGIOU/DAxs7Fnyg2ZUJA2WYyjJ0Ah
j9wz0uFnRZP8fRjY2tAV+f01Igce2A0jgk7gxn18wkCWBtbBcaLyrO2V7WBZydeU
rOeChM+bSmKH4D20ekaTAezxVDSqK1fOIOYYAs9S1Kn8NRZ6MnoYGQhMj6/428wU
q13pDMRBTepxlFaKahXJ
=wrPq
-----END PGP SIGNATURE-----

--=-TkqYNtxIpnsiawpO4iwq--

