From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/32] OMAPDSS: Implement display (dis)connect support
Date: Fri, 7 Jun 2013 11:31:59 +0300
Message-ID: <51B19A7F.3010300@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-13-git-send-email-tomi.valkeinen@ti.com> <51B181AC.3070400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2GFNNUBILEKKTTXPLRGLK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48134 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab3FGIcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 04:32:04 -0400
In-Reply-To: <51B181AC.3070400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

------enig2GFNNUBILEKKTTXPLRGLK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 09:46, Archit Taneja wrote:

>> @@ -384,6 +424,10 @@ int omap_dss_register_driver(struct
>> omap_dss_driver *dssdriver)
>>               omapdss_default_get_recommended_bpp;
>>       if (dssdriver->get_timings =3D=3D NULL)
>>           dssdriver->get_timings =3D omapdss_default_get_timings;
>> +    if (dssdriver->connect =3D=3D NULL)
>> +        dssdriver->connect =3D omapdss_default_connect;
>> +    if (dssdriver->disconnect =3D=3D NULL)
>> +        dssdriver->disconnect =3D omapdss_default_disconnect;
>=20
> I was wondering if these should be apis rather than driver ops. One
> advantage of having them as functions used by omapfb/omapdrm would be
> that a panel driver wouldn't override the default_connect/disconnect op=
s.
>=20
> Even though they are named omapdss_default_connect/disconnect, I don't
> think there is another option by which a panel driver may chose to
> connect to omapdss outputs, right?

Those "default" functions are used only for the old panel drivers, and
are removed when the old drivers are not needed anymore. They allow us
to add the connect support without modifying the old drivers.

The new drivers may do other stuff in connect/disconnect. For example,
see panel-dsicm.c.

 Tomi



------enig2GFNNUBILEKKTTXPLRGLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsZqCAAoJEPo9qoy8lh7144IP/RPtGj2yckvPnHPA3P9Xb7Qh
quFCvdCxe49YxkHzXKc/WXnBbNJTDj1vsw4Fkt7Z88OZ0zxxAXPxtDUs6VjFX5HY
TCAGKaPD9Du7DAAEaaD6BaLwHH9Y5qIUTihfIrRDMu5BxUgyFV8hRtKf8WxLNHN6
lc4OBAPM8odERsZHApfLhczZ3Z0nH17KGTYFL7xHFoVtGHlimkG8CivFROC5S887
agNS+dXAVoL9IKkcwpMn3X7+pWt2LV8V+QF86vrh2dUIcyDIQipkONlfCuKXBw8C
e/3L9FYhr2ZRXcFa8hz6hoD4eEk8KsI8hE99zgbmvDylF+uHm4VMXj3no+G6WR06
TfbfvwDaxAQ4mk/5aHhHRmrmv5rOMHHNSMQZzJ7fDlm4gzW70WdrF8VfMSfO9e7i
HIflIJHDvcRRqmVdwlVs+CTzYQ5AjEnTOPG33MqWl0Smb01OgPYwf3lVAa5YsLg9
Lbwelwhu6ulWmz8Hu9PZbglSbexP/Gutv3M6iuJEKq8Q8e9RTXY6fr6FlQEAQ/Vn
1OfkJg4iZaMsyXcDH5st0j93+QKs8i8xWrxKNDvEo54pA9gidWNnzml6jEQLxJqA
mTS+4emRHwIihL4gd9315BZWuRqYxtXN99TO3Qe/Sdn61c3lH6ihy4QFl5mGVoE7
vQ5wfv2Xqi+g+lRonA7e
=UgJP
-----END PGP SIGNATURE-----

------enig2GFNNUBILEKKTTXPLRGLK--
