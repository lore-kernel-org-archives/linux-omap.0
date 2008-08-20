From: Daniel Stone <daniel.stone@nokia.com>
Subject: Re: [PATCH 1/2] CLK: Introduce virtual clock registration
Date: Wed, 20 Aug 2008 13:04:44 +0300
Message-ID: <20080820100444.GA22373@intune.research.nokia.com>
References: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31521 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYHTKEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 06:04:23 -0400
Content-Disposition: inline
In-Reply-To: <1219225912-347-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, eduardo.valentin@indt.org.br


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2008 at 12:51:51PM +0300, ext Hiroshi DOYU wrote:
> +	struct clk **childs;
> +	int n_childs;

This is a ridiculously pedantic nitpick, but s/childs/children/. :)

Cheers,
Daniel

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkir7DwACgkQ68xJuWtYYdU8zwCfRG/Y/6RSLNRrkbZlBqcMIpAQ
7dAAn0T9hNWWHbeHkQFyfTqF09E2w8bL
=JCST
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
