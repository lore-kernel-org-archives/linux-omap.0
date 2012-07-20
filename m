From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Fri, 20 Jul 2012 10:59:36 +0100
Message-ID: <20120720095935.GQ4495@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gh4H09KImyIEQ1se"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48969 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab2GTJ7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 05:59:37 -0400
Content-Disposition: inline
In-Reply-To: <1342766789-28148-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--gh4H09KImyIEQ1se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2012 at 12:16:26PM +0530, AnilKumar Ch wrote:

> +		vio_reg: regulator@1 {
> +			reg = <1>;
> +			regulator-compatible = "vio";
> +			regulator-min-microvolt = <1500000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};

Every regulator here has a rather large voltage range specified with no
consumers added.  Are you sure these voltage ranges make sense in your
design and you've not just cut'n'pasted the entire voltage range that
your regulator supports without reference to what your board can do?

--gh4H09KImyIEQ1se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQCSv8AAoJEBus8iNuMP3d+E4P/1DJqPnHmCAKuE8el60q31yX
hmTTGYsgbc2ZrGgMhQpy5aXDsGHkhDuF4Ge9sxfbIcqLr8tzwAOHPjk2koA2Wv87
rt7szQmlPn4P+D5EfpEtrzxSj+ko/n78kJyP5T3hYLb8ncedie41meOHAHGTyd4b
0UaFnL3BDEEbGkb+yUfAxDqj+dF5QuJdTf0eqqOjwexS+rPj0IA0Aig9ahWnumFF
Q7oYRo0kuZ5OWPYoCQbKY2HCRKw50LkRpuXZZen4djvjyQY+UxEtgeSDWyblGpWs
JGSCBTTy+/goPcIVW60m922hhm+EZyOzFQKj0dI1udNIZdvBW6Im7DPFP1v6FfK3
04aGlDKtaB3qzP2yc7vOoUD1nRyDnmP+l3gjJ+htuMdpmC2P3VIjTS+Ndvb4cVE7
AyC4mVIwM35g7+PQ9msT3qOc5jQjF4zjeuedf8qZT1nZ1GJNsMRjnBi8JYWVh8by
7QllSNbjGQhYmHDb5SJoueG74yZyVKm5jGPVEi4b4mYWtD3HrhCGx3PSdR2uiMBv
5X52U0oEauTZ5bSNyVJ4BRSSTn8/id0NyBNlgeNqclQs3cvV1ZG+L82MNl7RRbG6
gJpBQ1uiXTsRrxCRor1J5dvCCvmMVWxCSVpw4e9M2U6sbn+kayLprAHl6v9i861J
kC9qfTUBYzywCE+M5h2Z
=8zZc
-----END PGP SIGNATURE-----

--gh4H09KImyIEQ1se--
