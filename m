From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v6 04/11] usb: otg: nop: add support for multiple
 tranceiver
Date: Wed, 1 Aug 2012 13:26:04 +0300
Message-ID: <20120801102603.GF12869@arwen.pp.htv.fi>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
 <1343377927-7850-4-git-send-email-ravibabu@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58167 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752359Ab2HAK33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 06:29:29 -0400
Received: by lagv3 with SMTP id v3so5955485lag.17
        for <linux-omap@vger.kernel.org>; Wed, 01 Aug 2012 03:29:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343377927-7850-4-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ravi B <ravibabu@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, ajayguptaj@gmail.com, Ajay Kumar Gupta <ajay.gupta@ti.com>


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2012 at 02:02:00PM +0530, Ravi B wrote:
> +static void nop_put_id(int id)
> +{
> +
> +	pr_info("removing id %d\n", id);

not pr_info. I guess pr_vdebug() is better. We don't want to know about
every new nop ID requested.

--=20
balbi

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQGQQ7AAoJEIaOsuA1yqRE1SsQALEEWa4WhL2yrfSsvyRKE4et
svHm7Mi3q52zjbx4AARDSjOquLjG+XvCNRJjZFbo8R04Vn/vZ0XIwu3XLIKobTJz
P6l/RsHsOzAGcP595geRMtEX50wUj2D2NvaTLZvQcKl9Nc8kz8wfdY6FZofqywgQ
e3mKdwl/OzZw3FJQDpFIkx1w8OOk3Q5OOq9xiV+uUu9qlt/FiflrLYoC8HFzVe0Y
5v77p6zRqYOOBtu9hLxvj6kgRlF5YSqDPbKo0xXvwHuJixgqh0MkuA/jMnLtGnTU
mTYmCpYP8QPt2ddvj7CtWVcjZHA7uanQv7FfO2cFjV4I+WwWC1SgO9NdhNCOOjwW
870xDeiN2z1MXm7tAVosfx+wZiHFvpjf2mMNQ2g4gudtNoNJaB0RR3YkaXKHmoRX
0zdvaAUyUdASWkRaolbH/HaH9yS4+V+HQm9decM/jMMFDVYp49R4Et2sGDiSL40m
efWibfVWG6g1LzQDWUKcCah4SSogFNHgDrgTLTdHZSEHKM7RfXZiFnLpy9IKm7dc
ZADXv3bgHuI+TEUfwFkC5ejCpvhlWHMz0u+g7gccGMAtkvrAqREFaiVW4H0pW4UH
Wmuf2PaCis6SDQIdhY1MOGW9bapE925EoqRah2TPDu8cwqNJ/TpEql4roA9NFI3z
pO9j11U3uKFh6419wdOg
=w6vp
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
