From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V3 2/3] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug
 function
Date: Fri, 28 Sep 2012 14:22:38 +0300
Message-ID: <1348831358.2437.14.camel@deskari>
References: <cover.1348636132.git.cmahapatra@ti.com>
	 <cover.1348826106.git.cmahapatra@ti.com>
	 <2fc91980de4af940ac59b26fd49da6498865db8b.1348826106.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ocAyDDylXeLwJfjbvDcM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51308 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404Ab2I1LWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 07:22:43 -0400
Received: by lagh6 with SMTP id h6so987016lag.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Sep 2012 04:22:40 -0700 (PDT)
In-Reply-To: <2fc91980de4af940ac59b26fd49da6498865db8b.1348826106.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-ocAyDDylXeLwJfjbvDcM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-28 at 15:53 +0530, Chandrabhanu Mahapatra wrote:
> The printk in DSSDBG function definition is replaced with dynamic debug e=
nabled
> pr_debug(). The use of dynamic debugging provides more flexibility as eac=
h debug
> statement can be enabled or disabled dynamically on basis of source filen=
ame,
> line number, module name etc. by writing to a control file in debugfs
> filesystem. For better understanding please refer to
> Documentation/dynamic-debug-howto.txt.
>=20
> The DSSDBGF() differs from DSSDBG() by providing function name. However,
> function name, line number, module name and thread ID can be printed thro=
ugh
> dynamic debug by setting appropriate flags 'f','l','m' and 't' in the deb=
ugfs
> control file. So, DSSDBGF instances are replaced with DSSDBG.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |    8 ++++----
>  drivers/video/omap2/dss/dsi.c   |   12 ++++++------
>  drivers/video/omap2/dss/dss.h   |   34 ++++++++-------------------------=
-
>  3 files changed, 18 insertions(+), 36 deletions(-)
>=20

> -	DSSDBGF("%d", channel);
> +	DSSDBG("Initial Config of Virtual Channel %d", channel);

A Bit Too Much Capital Letters here for my taste =3D). Use just one at the
beginning of the print, or none at all.=20

> =20
>  	r =3D dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
> =20
> @@ -2814,7 +2814,7 @@ static int dsi_vc_config_source(struct platform_dev=
ice *dsidev, int channel,
>  	if (dsi->vc[channel].source =3D=3D source)
>  		return 0;
> =20
> -	DSSDBGF("%d", channel);
> +	DSSDBG("Source Config of Virtual Channel %d", channel);

Here also.

> =20
>  	dsi_sync_vc(dsidev, channel);
> =20
> @@ -3572,7 +3572,7 @@ static int dsi_enter_ulps(struct platform_device *d=
sidev)
>  	int r, i;
>  	unsigned mask;
> =20
> -	DSSDBGF();
> +	DSSDBG("Entering ULPS");
> =20
>  	WARN_ON(!dsi_bus_is_locked(dsidev));
> =20
> @@ -4276,7 +4276,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *=
dssdev,
>  	unsigned long pck;
>  	int r;
> =20
> -	DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> +	DSSDBG("Setting DSI clocks: ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
> =20
>  	mutex_lock(&dsi->lock);
> =20
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.=
h
> index ffbba7e..5ef4e17 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -25,38 +25,20 @@
> =20
>  #ifdef DEBUG
>  extern bool dss_debug;
> -#ifdef DSS_SUBSYS_NAME
> -#define DSSDBG(format, ...) \
> -	if (dss_debug) \
> -		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME ": " format, \
> -		## __VA_ARGS__)
> -#else
> -#define DSSDBG(format, ...) \
> -	if (dss_debug) \
> -		printk(KERN_DEBUG "omapdss: " format, ## __VA_ARGS__)
>  #endif
> =20
> -#ifdef DSS_SUBSYS_NAME
> -#define DSSDBGF(format, ...) \
> -	if (dss_debug) \
> -		printk(KERN_DEBUG "omapdss " DSS_SUBSYS_NAME \
> -				": %s(" format ")\n", \
> -				__func__, \
> -				## __VA_ARGS__)
> -#else
> -#define DSSDBGF(format, ...) \
> -	if (dss_debug) \
> -		printk(KERN_DEBUG "omapdss: " \
> -				": %s(" format ")\n", \
> -				__func__, \
> -				## __VA_ARGS__)
> +#ifdef pr_fmt
> +#undef pr_fmt
>  #endif
> =20
> -#else /* DEBUG */
> -#define DSSDBG(format, ...)
> -#define DSSDBGF(format, ...)
> +#ifdef DSS_SUBSYS_NAME
> +#define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
> +#else
> +#define pr_fmt(fmt) fmt
>  #endif

I think you could just do:

#ifdef DSS_SUBSYS_NAME
#ifdef pr_fmt
#undef pr_fmt
#endif
#define pr_fmt(fmt) DSS_SUBSYS_NAME ": " fmt
#endif=20

For the case where there's no DSS_SUBSYS_NAME, there's no need to undef
pr_fmt, only to redefine it again back to the original.

 Tomi


--=-ocAyDDylXeLwJfjbvDcM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQZYh+AAoJEPo9qoy8lh71bv0P/2+DhGjE0S04DnYEv6zu6qyC
pVHXaSYou68blGo/yhAzCrcT8SDpcwe3+kSFAJY7hbGRwERE1hgc3PRDFDwRC8BT
bkbn4QcMZ2Kxr8wAmTGOBYDKhzGTHqozDrP81JWaT4Aq4x/1vrC1/f8LVgJC9l1d
ICL76bJ0XVEtbo6ZCsoz+2i/CiWSl+eOPCA7te19hxlyZIGtSA6tV3e5Kvr3LSFS
TzbNFWgFHqDLgDlBf+Thgd7Izp7BuFLaPgPr7YxtGMG6siBg41vRyRUQlhbagYAB
27n4ujBDgTd9tLOUN9To26a/Ty0/mXLgSQh8dzuePh4fvOEuNHE56gmUo0/UZB9W
nfdyqRvcBxfxKWBN+Myg1oDshnM/sii7PGw8TvPgFXpm3JaKsbt8kUqgW7Xwe5SJ
X9JlsvBCbzJwDb8yOsHPU2YAKVEB9of3HNdFOMjLzi4d2PpAzP24GkRJtGb5PfUY
WZbqKNmhSWlz5RuD39B313qQDWVgZT48GHbdZlAykqt9nMkceVXs9QokMzQMneK9
9gH7uCh6k3ebPyEuzt6rItKCREgXpAsFDK4NEg1yChxkpdw5WR3Mn1lxDXBRgrmm
aW5Q7oY0iLLTgP+Lru77OqC/6J00h71G60Owmk9hP1eJsr1HW1LdLU4ESH1f2aZS
u7xY1+VD+c0Q+Otz4Gq1
=gM4a
-----END PGP SIGNATURE-----

--=-ocAyDDylXeLwJfjbvDcM--

