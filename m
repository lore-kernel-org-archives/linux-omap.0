From: Mark Brown <broonie@kernel.org>
Subject: Re: [REPOST PATCH 1/2] ARM: OMAP3+: TWL: add support for mapping
 platform data via pdata-quirks
Date: Fri, 7 Nov 2014 15:22:01 +0000
Message-ID: <20141107152201.GS8509@sirena.org.uk>
References: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
 <1412949989-20186-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FbCNvfVkhudvi8fu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49326 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbaKGPXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2014 10:23:01 -0500
Content-Disposition: inline
In-Reply-To: <1412949989-20186-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lgirdwood@gmail.com, nm@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org


--FbCNvfVkhudvi8fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2014 at 05:06:28PM +0300, Tero Kristo wrote:

> -	dev->platform_data = &twl_gpio_auxdata;
> +	if (!strcmp("twl4030-gpio", dev_name(dev)))
> +		dev->platform_data = &twl_gpio_auxdata;
> +	else
> +		dev->platform_data = omap_twl_match_regulator(dev);

Looking at this idiom here I'd expect that we'd be adding another string
comparison here?

--FbCNvfVkhudvi8fu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXOOYAAoJECTWi3JdVIfQUxUH/3804ha/Yg/NGXZcqmqsql1I
FR5DJXYjbDeTrpZFzKI66LsIgO6v2mng8v04C7WxCfpjVax+pJ//B/JxY70s88hR
pmvwocqbgAiLSqISJdj3kcnfunR8svHSFSvD3b4C3C+Mvg/K746NssfZgNtVmYIl
8SVpO+tVp65ihqoZjKY0mJehybv+Qq2UW6qTIPDOmp/j9rWq4mSw8BoqM9pbVUIW
anq6+VoWN4qMevyy1CCrrYzdJrcWLzh0WiktDkzb6Pu/a/mvo9neHjGkYk7XlOoM
RPXQ3ifrfPIIlkGTx3SQlI39cJ1Orj1UBCylu33FzJrHGkp/AUTyUpDhB5hTnLY=
=v+wM
-----END PGP SIGNATURE-----

--FbCNvfVkhudvi8fu--
