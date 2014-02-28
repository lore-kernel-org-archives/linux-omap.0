From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/8] clk: divider: fix rate calculation for fractional
 rates
Date: Fri, 28 Feb 2014 10:49:26 +0200
Message-ID: <53104D96.5040704@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-2-git-send-email-tomi.valkeinen@ti.com> <52FE1DF2.2040707@ti.com> <20140227022524.12081.32368@quantum>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kGQNgDN8If3dN42Nw83VID57b1dicf9jJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbaB1Itw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 03:49:52 -0500
In-Reply-To: <20140227022524.12081.32368@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--kGQNgDN8If3dN42Nw83VID57b1dicf9jJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/02/14 04:25, Mike Turquette wrote:

>> Basically the patch looks good to me, but it might be good to have a=20
>> testing round of sort with this. It can potentially cause regressions =
on=20
>> multiple boards if the drivers happen to rely on the "broken" clock=20
>> rates. Same for patch #2 which is a copy paste of this one, but only=20
>> impacts TI boards.
>=20
> Agreed. I've taken patches #1 & #2 into clk-next. Let's let them stew i=
n
> -next for a while and see if anyone's board catches on fire.

Thanks. I understand there's a possibility this could break some other
driver. I still wish we could get this to 3.14, as this would fix OMAP
display subsystem.

 Tomi



--kGQNgDN8If3dN42Nw83VID57b1dicf9jJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEE2WAAoJEPo9qoy8lh71IS8P/0GK8wXHxtQN+xwzl+dV7kj8
jaHrI7HZ+BAy6P6Ehg8xVMn15CeYT+NPCfw0Juuv4C4F+mW+NXU9znrfNR/pee0Y
MI2fH23NARUT8CB/fP80Wz8gOBiQpjemNJxR3iKNSr1VJyNeV1tpP/8hOdV6UrRF
KQKANmsKRJUdTSV7w67re3DmF6USK/gbpxUoyQY61IgtaAwdrNO4CnmvtnngFG+p
Exwy7BkVPDKP4lC6c/fUhlgVJ6cMpvpC93wVE9whcQkUM1qUmwDmDVrTQyzBod8p
YvbqJjn+3nyP3GcRjq9GGOyoDVPjZ/aRYv1ENm3aj5dJOFi0CwGKn+Zr/binM+VL
dRRvGOYwvA9iZkI7OokXQrafNkXR9hpxl6VRMdZ5R5K5I1YRkRWfwpdgsNGSWVFt
aHMSdrOAeKsiUvW4JzXpncocHxcZEXT5RS2p6bR5pcLkwdsMuH7dZIajhlyb3PJk
hcJxcCR0lNs4eDF/oMPzCOQja1drjmVRGNtmv8PbBqktFj3kp5X9AeOIKXO/cAaW
rGMtgIBFmSWy+cuqKn087PUQLDoAmh2jFuQk9TXFU4FjJqD8q6HKlHMU0qc1TcoV
Y+U0G+BB5+G/UOSO+qppey9snP48a9+nDnxAjyDjpzjktIDfgwgwiKG7Um/sb4m7
5LH9zyTacMHZLCYyRDtf
=NqPr
-----END PGP SIGNATURE-----

--kGQNgDN8If3dN42Nw83VID57b1dicf9jJ--
