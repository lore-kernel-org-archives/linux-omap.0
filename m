From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAPDSS: use new display drivers
Date: Thu, 29 Aug 2013 09:26:21 +0300
Message-ID: <521EE98D.9070209@ti.com>
References: <521DAC2B.4080100@ti.com> <20130829061923.GM7656@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SIIHqQpu3OeUnurbFnc0aUqf66tjgk6be"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3H2G0s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 02:26:48 -0400
In-Reply-To: <20130829061923.GM7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>

--SIIHqQpu3OeUnurbFnc0aUqf66tjgk6be
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/08/13 09:19, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 00:59]:
>> Hi,
>>
>> Here's a pull request for the board file changes to take the new displ=
ay
>> drivers into use.
>=20
> OK great.
> =20
>> If there's an "early" pull request going to Linus during the merge win=
dow, it'd
>> be nice to have these in that request. That would give me time to send=
 a pull
>> request to Linus containing removal of the old, no longer used, driver=
s.
>=20
> Nice to see that this is not conflicting with anything in linux next :)=


Did you add the series to your for-next branch?

> I suggest you keep this branch immutable in case it need to be merged t=
o arm-soc
> tree, and merge it yourself along with the DSS patches. That way you

I do feel a bit uneasy with merging lots of arch changes via fbdev tree,
but yes, I guess I can do that. Is that an "ack" from you for all the
patches? If I do merge it via fbdev, I want to have at least acked-by in
the commits. If that was an ack, I'll add them, but it means I need to
update the branch.

> don't have a dependency to arm-soc for removal of the old drivers.

The dependency is run-time dependency, so the removal series does not
need to be based on this. As long as this series is merged first, things
should work.

 Tomi



--SIIHqQpu3OeUnurbFnc0aUqf66tjgk6be
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHumNAAoJEPo9qoy8lh71kpIP/jxFrnfY3AfP7pXsYX/VESTI
lnccv92DAcdrS/Y0MyuK8m7O+Tggikp5koFOxJWeCvieAHCiplRKMXsFCu0NMnD8
XpIFln3fg8djDQVeZ7L0IoHLmmukp1AEHUgnjaTqjVSOl4u3/fl6DdO7dQEuutna
0BeKzRdjJX8F+nnuhYxSR2VRO+43PZ2PeT0/6Z1AUthF+WLYHvYimSWQp0Z3mrze
iyvxmD63GIu9rX95eb2HfeQvGri4TeQTcIeKAnuEOFRcMxl6xlCibacYCHLcYnoM
3fGWQz6YiqNeEsWN/Doa4s5xotxMjHMKrOYXx0No08XWK5VMbT2okAQjYLVI1X4P
UzERh56HGyfL7/5/rGWt422iOY4rlzlcHoEQV6o2uOzSBDD2+aTaM195wpys19rq
ddReXuAv2Rhgkuyk0HIG60LO+RgopGxH5Ky/kxqAxTppDvLIcWrNVg+BC19OlzMj
+9e26SzY+6JRYh+tLh6lC4ohzMpaZSeG0dMG9IiljjGdozzLyEnMMxtcQ5NNs6Yv
9ut1yKYF1FrGAFGZX/lP77DZg211yiGP4POfH/qSgawAW/J/UzUU1bxr/ig2v7tn
XJZFegNS228kMtNto35pBgM8wMu0TwcRIjSE6MyVJ3s/JOmR/R3HIejPT+oeJZ1L
VAQjA7v7JtzrA2IBq4x9
=YF59
-----END PGP SIGNATURE-----

--SIIHqQpu3OeUnurbFnc0aUqf66tjgk6be--
