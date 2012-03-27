From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] OMAPDSS: HDMI: support for interrupt enabling
Date: Tue, 27 Mar 2012 13:29:58 +0300
Message-ID: <1332844198.1867.110.camel@deskari>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
	 <1332249307-26875-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-rQ75XHb8f/fCC4Hu1/2v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52757 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751641Ab2C0Kbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:31:55 -0400
Received: by mail-lb0-f172.google.com with SMTP id l12so5142301lbo.31
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:31:46 -0700 (PDT)
In-Reply-To: <1332249307-26875-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-rQ75XHb8f/fCC4Hu1/2v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-20 at 18:45 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add function to enable or clear interrupts in the HDMI wrapper.
>=20
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/ti_hdmi.h         |   16 ++++++++++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   45 +++++++++++++++++++++++=
++++++
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    1 +
>  3 files changed, 62 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/=
ti_hdmi.h
> index 1f58b84..6d65b3b 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -80,6 +80,22 @@ struct hdmi_pll_info {
>  	enum hdmi_clk_refsel refsel;
>  };
> =20
> +struct hdmi_irq_vector {
> +	u8	pll_recal;
> +	u8	pll_unlock;
> +	u8	pll_lock;
> +	u8	phy_disconnect;
> +	u8	phy_connect;
> +	u8	phy_short_5v;
> +	u8	video_end_fr;
> +	u8	video_vsync;
> +	u8	fifo_sample_req;
> +	u8	fifo_overflow;
> +	u8	fifo_underflow;
> +	u8	ocp_timeout;
> +	u8	core;
> +};

This feels like a very complex way to do a simple thing... Why is this
in ti_hdmi.h anyway? These are omap4 HDMI interrupts, right?

Why don't you just define the interrupts the same way dispc/dsi do:

#define HDMI_IRQ_RECAL (1 << 31)

Then you could have simple functions like hdmi_enable_irq(u32 irqmask)
and call it like:

hdmi_enable_irq(HDMI_IRQ_RECAL | HDMI_IRQ_SOMETHING);

 Tomi


--=-rQ75XHb8f/fCC4Hu1/2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZamAAoJEPo9qoy8lh71o5kP/Rybtdno+TnYB10IWAekAkWd
wbBN+uHO2YVkRKd0INrTJ7J0uFJ6WMSpsu8t8iW+23eVGbyXSleaU+yadmkEMQU6
2DqBohNUXYhREplCG9Z/tvEjE+O/Qy7qqRSDGkxE5mjnH2zt02G66Yt8wQsd6BJ2
nnDYmHgAO+8oX1dnr8BTgjwMh2TGxen7jPBP904PZS1jNWXhc2gs23mbtaQASLYu
3NM/kGkPiz1+JNmaP+E7UFv6sfrVuaCmvKPvH1TPufkW3HibAtKidYA6ev4sw8pn
BMKsSW7o1MPI3eQq8uTqnOsViajY/+sG8H9kmxvDAzmoIjt+I8gwpN1tetZJNS1+
Mh+YDwLlZYEb/JRtY37DPUZSwkfFL+NDq/Rp4KKL9vlOhaLoT7Xy45xGe+0cvUtJ
djujZ0WNJv2lCa6ashwrNqYRZ/5G7M0ZabOM11/cnqS75GRl1HpZNN84NYYslvC2
ZlA5moNJ9Tb8XFcvnbOXra/1gB1/JzPNuuvVwe1Zw/LhZtge2LVI49oZg+//cC4K
eo0UZngp8xFb0gDSS3HOLvKngslkYmoMjxGuuymKjDKeVFwEZt2yYL5/hkLbmpXk
KzRiz9WCG5FsNcGHqT3eo5zD3kvXVMKtk5aNZUqIG8UXLxfhy24QDFolgj9BxfKY
Z0mrId/pN9f7P/Y4kpgO
=H44g
-----END PGP SIGNATURE-----

--=-rQ75XHb8f/fCC4Hu1/2v--

