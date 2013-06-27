From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for
 omap54xx
Date: Thu, 27 Jun 2013 11:44:34 +0300
Message-ID: <20130627084434.GT15455@arwen.pp.htv.fi>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
 <1372322299-25046-3-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JHjDRUnf1JOMxzko"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36043 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab3F0IpJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 04:45:09 -0400
Content-Disposition: inline
In-Reply-To: <1372322299-25046-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

--JHjDRUnf1JOMxzko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
> +	rc =3D clk_set_parent(abe_dpll_ref, sys_32k_ck);
> +	abe_dpll =3D clk_get_sys(NULL, "dpll_abe_ck");

should these two lines be swaped ?

> +	if (!rc)
> +		rc =3D clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> +
> +	return 0;

so even if (rc) you still return 0 ? Shouldn't you return rc instead ?

--=20
balbi

--JHjDRUnf1JOMxzko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRy/tyAAoJEIaOsuA1yqREtqQP/0K8P3A7caoOlrE5gq44TBVE
5XTFBc1I+8PAgiP/ivsY7wjoW0p1XtWqdJ49lUSJkDebnjJ9YDtODsl7ppSqOvCZ
T3duaJrtfY5/EEu0QYMU+HSM5yG8nni7GN1sZXLkT92fmDRA5h4gX9aRqS/iYY34
PfzUSjrY5vGgEJw+iVcS4m6aES0+4p8r4SDeSZuNI1wo2rqeo8pamrgPtdww1XbH
9QzZawEJo9h6s3Acy/ScIt7giXJ5fngE43cpIJFvj1NQFMFCPizWPZXYZLyT+L7x
ui67icXzyyD3ROBcr8KDCTYzy1EpjL8TBjTkn1gAVPanKr8ZXhgK1nWOx44oD0U/
e+TCapx8m++d4fihEkR9FpLsLhQC309w0sgs2CpzHvbW5sLbpFRMwp/rGwgJ9CCe
cPazOW/pYXwJOWSjUDuVN8a/8Mau+qQoRa8Yfr3ncsUMuhgucPCeb8Q6KtNTOO/R
7bzGqPOQkvymEXvnw2RV7UL80vmwAwORo8IodaxhPKuy6QCt54fOVMXykk0xPoU3
4UM4e15bUnMUSOGdJ2hHdapyYsSRGhdJXQsABEWdpP7i0skApTwRm1OE8pYWMznX
AxOZim8ziO+BAO5MYVAJ9Ay7tKMazvITiox/SiXsUaGFRJNuW/oj5sCfMaKeypvZ
u8eOUOuJggj4jQmScl1K
=7asL
-----END PGP SIGNATURE-----

--JHjDRUnf1JOMxzko--
