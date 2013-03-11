From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 20/20] OMAPDSS: Taal: remove rotate & mirror support
Date: Mon, 11 Mar 2013 08:51:35 +0200
Message-ID: <513D7EF7.8070807@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-21-git-send-email-tomi.valkeinen@ti.com> <513D7807.2010509@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC18C99C94139F92EF3337876"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50685 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3CKGvl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 02:51:41 -0400
In-Reply-To: <513D7807.2010509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigC18C99C94139F92EF3337876
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-11 08:21, Archit Taneja wrote:
> Hi,
>=20
> On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
>> Taal panel driver has support to set rotation and mirroring. However,
>> these features cannot be used without causing tearing, and are never
>> used. The code is just extra bloat, so let's remove it.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> <snip>
>>   static ssize_t taal_num_errors_show(struct device *dev,
>> @@ -1025,10 +973,6 @@ static int taal_power_on(struct omap_dss_device
>> *dssdev)
>>       if (r)
>>           goto err;
>>
>> -    r =3D taal_set_addr_mode(td, td->rotate, td->mirror);
>> -    if (r)
>> -        goto err;
>> -
>=20
> I'm curious if we need to set the address mode(to the default value) at=

> least once. It may not be a requirement for Taal, but if that's the
> case, why did we have a set_addr_mode() call in taal_power_on() in the
> first place? Is it because we can prepare rotation and mirroring before=

> we enable the panel?

The panel resets its registers at HW reset, so in case we have changed
the rotation or mirroring, we need to set the addr more at power_on to
keep the user's rotation and mirroring after resuming from blanking. But
now that the rotation or mirroring is never changed, the default value
is always fine.

 Tomi



--------------enigC18C99C94139F92EF3337876
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPX77AAoJEPo9qoy8lh71rQIP/05rP4gqBhbPyBc38IPSusya
jeOF0Brwt9uYfKl7zubxdgzvGLTZJlQ5VD93yhWaweTRspXtJ6QK6AtryUS9BuCv
wCCsYwYuHpXEmyh3W8t+Ce0uKlZW8UchY488LnXmoxAixTABxqrWfkt6OZd9cERb
ongVVMkoxC3H6S4l2TqoO6jx1giNea8xoCjzHshTiiJpiOjMIMC0eulfufYQpYs3
dUZAeAWvsiGKXqJAFZVqG2WGj1NybogOTiDan3CvU45AB8fAl/J+TjiLmhNf7GY2
PHgnZKBeEhLdwuVampLwy6pHRDYbfn7HkXFOHJr6mzLpbf/p2L991vegr8V6QKtx
vFoEZMpnuiX+rwddtxvGwV1+cTWeA5VCgv3h1KgSuko2QYYRwnq3uOB6x1tG/dQ8
flqz6d9agCWbD/aO/4Gx5lv9J/5I+Bm91tC4AbFvqAAqKvcoIjynXImkz60Md6GC
41mB/kth1CsQEmCO2q3hz7c/ZkaWiqNSnMscqTmDTO/K59MRIaCQqNebJGGuHNoS
IMU+cldQVDslzDkM+eU9d6DsT9DJYq/nWckVje4H74xkOB+8bOMDP7xnNCTpUGt8
77RrO7in4hGTqBDZGrTw1usRHaLjBj3KrO3OD4W4V4FjXpB0IPdjx2ZTGrskXeCs
QwL7fRvJHRihvT6OQ6Q9
=qiVu
-----END PGP SIGNATURE-----

--------------enigC18C99C94139F92EF3337876--
