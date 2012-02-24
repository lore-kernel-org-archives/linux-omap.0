From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
Date: Fri, 24 Feb 2012 14:34:15 +0000
Message-ID: <20120224143415.GL5450@opensource.wolfsonmicro.com>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
 <20120224140109.GG5450@opensource.wolfsonmicro.com>
 <1330093512.4102.552.camel@sokoban>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4e5ZDkbgLEOfWmLx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58687 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab2BXOeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 09:34:18 -0500
Content-Disposition: inline
In-Reply-To: <1330093512.4102.552.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>


--4e5ZDkbgLEOfWmLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2012 at 04:25:12PM +0200, Tero Kristo wrote:

> Still, setting selector in this case does nothing, as it is immediately
> overwritten by the regulator core by -1. This looks like a perfectly
> acceptable way to implement a regulator, as everything checks for the
> presence of list_voltage anyway.

Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
that.

--4e5ZDkbgLEOfWmLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR5/eAAoJEBus8iNuMP3dIyQQAJmEZqhUnCe5w0+ha45hqIzQ
dJB6cflInNfB7rneqViWs0gN1FZSRQB6EvJc3WZWCWuIz/8DlsZQ9pXNRTf3KDYE
7GWLqqQUrf3p7SSMt9i85NledzJxXsxnMoI+4qWcKHrdYCfh4qhTWCmqmKp63zpl
ukVRf28YDbKXEiMqNNdrbRBavjAEQwjWXKa7HzWQh4y/wuJr/WDzk0iPVupWuHL3
6lKrndE+6cKDTfB8wyGeHuo6KlWhylBAGnl9oD1thXGeQOeijKY4BTvVi/eaw4zL
rkCu3rnFNydHHOKxwm4VUanZAoraX1aHTtZlyIIJWIj4JFPUzE5woXxRI78mm93K
nU0iNYdPxPvRh7juPhxaNF+QPoOdyy7Q7mlWi6SsBar+m83WXkg51OAno24DGh7w
iuBEVXzfWMx/7iS7orcYQWqIMx54SdaVw4Az0FYXDfFCgarG6Gjrg/+30rwdgo8e
sStlH7uf6ypBF6gkr+KxWXCHlLRLJNcXQlc3neGnt+CJ7XbohrPXi0F3HTuBZl34
tQvg0Stp4NBqu80gjPPkfg0gfxKjEvN+78ZppMKDy680dbDhiuvH4RCTlOS381j1
4lp/wUJ1rS+oBA96UGyXh4wIIGNn8U4h5CGhjIEUa3NIWaDQx7aqCPKu62i89erM
ykaTjXVgLo/pHhNzHzwo
=lYQD
-----END PGP SIGNATURE-----

--4e5ZDkbgLEOfWmLx--
