From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add pm_runtime_get/put functions call
 for McBSP.
Date: Fri, 1 Jun 2012 21:24:50 +0100
Message-ID: <20120601202449.GA4258@opensource.wolfsonmicro.com>
References: <1338581572-11047-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37954 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759247Ab2FAUYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 16:24:54 -0400
Content-Disposition: inline
In-Reply-To: <1338581572-11047-1-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 10:12:52PM +0200, Sebastien Guiriec wrote:
> pm_runtime_get_sync() and put_sync() are not called by McBSP driver.
> This is introducing a problem with PM and Audio Backend due to
> missing get/put for McBSP IP.

They are called by the core.  Probably you're just pointing your struct
device at some virtual device instead of the physical device, either
enabling runtime PM for the virtual device (assuming it's a child of the
physical device) or changing the pointer to the physical device (which
might make for better dev_ logging potentially) should resolve the
issue.

> +       pm_runtime_put_sync(mcbsp->dev);

No need for this, anyway - just use regular _put().  We don't care if
the device is actually suspended before we return, the PM core can do
that at it's leisure.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPySUDAAoJEBus8iNuMP3d96sP+gPMTEdzhwmEsH1gwXuA6RB4
ZS9Rheo5lGyEs1wL2/3R7gshDi2mC5L66tuajrvhjymis4uOiJquysoYF+vNo7/R
xqhk1jQSM0lsyVnBEKTiz6DkeF84TjrR8YwYzD4fYt+HN7d0BtFDQr+/7WlEmKgc
k6zn61CLFFjyJmBGbB7zGgncfEp2WA3ag7RCJn6nYybB17YTj+LD6gmRz+2ealDj
FPTNSakDahs0xbxiRZgyiGA8MqaSbBAzDCH1U3Wpm6BidB3WNlfvfwf2CExCaAH/
K1Asn+yIadhnzfoy7iGhEQsoo7IBw2qsoKSTkAW+OplzP7nMdGsXBZwz2XvQT/KV
ftSurJ3J5Cn8jyE1UdBE1Ho2rjQEvfeXZfAAdnoJWXQGQJI3Tgiv3DxAVSBLWjHk
t/kHj1R6exniNTqZpS0oa2oD3CmhIgQJPXay9f3lHYOaC1DkEppZGUiCILOqyduA
9s1UGFiRYL7exxHHchW3He9SjTDoypkZrSg65AnAeVeGtJyapCO3bgPlfAw78VNh
CAkDSNktlI0qAjMNA9EQeAG6GDm/ZCt/XTwpfg3Y2SVna3MZkzBToMGOZNPBY1XD
Z7dLxxh2wxUauwvEFtdkGFhE6YG3ndHa3YktdaUT+9Q7yhfKkPvcQGk2M0CPuVja
/I+u6nD4OmwTKsdqk9eD
=s2RQ
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
