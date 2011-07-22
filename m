From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] OMAP2+: PM: SR: add suspend/resume handlers
Date: Fri, 22 Jul 2011 12:13:04 +0300
Message-ID: <20110722091303.GK32058@legolas.emea.dhcp.ti.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
 <1311314153-23531-3-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39553 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376Ab1GVJNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 05:13:09 -0400
Received: by fxg9 with SMTP id 9so4933806fxg.0
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 02:13:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311314153-23531-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin <khilman@ti.com>, Colin <ccross@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 22, 2011 at 12:55:53AM -0500, Nishanth Menon wrote:
> Suspend and Resume paths are safe enough to do it in
> the standard LDM suspend/resume handlers where one can
> sleep. Add suspend/resume handlers for SmartReflex.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   87 +++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 87 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smar=
treflex.c
> index 33a027f..fb90bd2 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -39,6 +39,7 @@ struct omap_sr {
>  	int				ip_type;
>  	int				nvalue_count;
>  	bool				autocomp_active;
> +	bool				is_suspended;
>  	u32				clk_length;
>  	u32				err_weight;
>  	u32				err_minlimit;
> @@ -684,6 +685,12 @@ void omap_sr_enable(struct voltagedomain *voltdm)
>  	if (!sr->autocomp_active)
>  		return;
> =20
> +	if (sr->is_suspended) {
> +		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
> +		return;
> +	}

I wonder why you get these called if you're in suspend state. If this is
called by some other driver, then shouldn't you pm_runtime_get_sync();
do_whatever_you_need_to_do(); and pm_runtime_put(); rather then just
returning ?

--=20
balbi

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOKT8fAAoJEAv8Txj19kN1WVMH/Aqppya4IDA+vCWkyrw14d1T
IMFldHi0TPFV55NJi9U/bioCnFnUIXhkWfhX1YXfG5JvvgBkMiJVFOfO0Z9Gh+V0
/AVxIpo/K/sVOdLtXIqPvVXeY2dorQZrEcDK2B/5Cg2BTzr73lSP5vC2HtlYEpXX
jxQaJtg2TrYE62lGvT1NoyFl5yO+aGu2/TR+DVdwxyIKAQ2OcFOKxf+CqTXqHQmv
Zrv1mZHEChDyj1pDESxmpzrwkAMS/EGD89wNB2EC2jFQ8EfBh5inwv0zELFwyj2Y
NsLG7LHnn2mjUEKm+obSvfpIdH+a/5fX5dOq+5/zFgS82mOIhAp5V/hxmZ3vfmw=
=A5um
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
