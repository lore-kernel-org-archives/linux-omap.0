From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 03/15] twl4030_charger: use devres for
 power_supply_register and kzalloc.
Date: Sat, 7 Mar 2015 21:25:57 +0100
Message-ID: <20150307202557.GI5233@earth>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043350.4243.6164.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56825 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbbCGU0O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 7 Mar 2015 15:26:14 -0500
Content-Disposition: inline
In-Reply-To: <20150224043350.4243.6164.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 24, 2015 at 03:33:50PM +1100, NeilBrown wrote:
> [...]
> @@ -667,13 +667,6 @@ static int __init twl4030_bci_probe(struct platform_=
device *pdev)
>  	return 0;
> =20
>  fail:
> -	power_supply_unregister(&bci->usb);
> -fail_register_usb:
> -	power_supply_unregister(&bci->ac);
> -fail_register_ac:
> -fail_no_battery:
> -	kfree(bci);
> -
>  	return ret;
>  }

Please replace "goto fail" with "return ret", goto is no
longer needed.

-- Sebastian

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+17VAAoJENju1/PIO/qagJkQAINDjL3fKbDbLMNHoxXczD3x
m36EFZ0bEbUW5VF9Kz6i06cR5PQZ3KJFtGdlH2kanI01MQNQQxyYG4ttSZjdOqWj
Hy9gjilvW8XJDveREds8rTF93QElo5N6eSV5F4m+90s7CmL3gLt6Nn2huv7trsh4
63kHuuTkUNbU4PoOE4TwOAfRuHm8NbA8PwrHRIX5xzXvCfOWTj1m8F/yywgu/Inp
EsYo7zFSMPT0cN5s66bBsHY4hKeou62SdgN/TM03Z2yLgUGbbtENLAUn4OjF+f1p
D9BhF3zFMWwSSbLJPN1SJ5nP2lxyWxi3MZd7i9yLtuDhu5aTCOIEIDp5Rrw0QXMA
n5adEyPcu54v8aOBNbCwbk2IJRdqs3t48KOoVryDO+BvM8/b4npikYn2vMLeVf2+
yTgF9bBQS3gqln48tt+YIZlnHeuQmK7pTl1ABvICAOey/HaiXrlXe7nUebedZmPz
6kaVgmM5wIpuIobqoAGgGpGKD8hkTK+XKVB2irlZxF/ci3Y6QVIeYNQIdwwmjy2D
fA1RqRZS48IGBfcyE3URI6LaAtL4/x5Q0RpkpSXPqVmoITpw+nQbGBDE7cc9qDyy
J18VmHc7PfVMzdJRgG3G/fr8DSk+6MHpav8duSfSsIXENGHGQ5iyxjHCZ3JD46S0
DTT6HMYzu8YEdgEA81iC
=HPaH
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
