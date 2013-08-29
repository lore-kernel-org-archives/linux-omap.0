From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] OMAPDSS: use new display drivers
Date: Thu, 29 Aug 2013 09:58:10 +0300
Message-ID: <521EF102.5020607@ti.com>
References: <521DAC2B.4080100@ti.com> <20130829061923.GM7656@atomide.com> <521EE98D.9070209@ti.com> <20130829063534.GN7656@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XxahVkOcIQlt3Vsoo9o9T3Nka0CupcTfs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33312 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab3H2G6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 02:58:37 -0400
In-Reply-To: <20130829063534.GN7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>

--XxahVkOcIQlt3Vsoo9o9T3Nka0CupcTfs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/08/13 09:35, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 23:33]:
>> On 29/08/13 09:19, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [130828 00:59]:

>>> I suggest you keep this branch immutable in case it need to be merged=
 to arm-soc
>>> tree, and merge it yourself along with the DSS patches. That way you
>>
>> I do feel a bit uneasy with merging lots of arch changes via fbdev tre=
e,
>> but yes, I guess I can do that. Is that an "ack" from you for all the
>> patches? If I do merge it via fbdev, I want to have at least acked-by =
in
>> the commits. If that was an ack, I'll add them, but it means I need to=

>> update the branch.
>=20
> I would not start messing with the patches at this point to add acks
> as then your branch is no longer immutable. If you prefer, then it's
> best that Kevin and Olof merge take this pull request directly.

Well, the branch was just created yesterday anyway, as I rebased on -rc6
as you requested.

I created a new branch with acks, 3.12/linux-omap-acked. I'll keep the
old branch in place.

>>> don't have a dependency to arm-soc for removal of the old drivers.
>>
>> The dependency is run-time dependency, so the removal series does not
>> need to be based on this. As long as this series is merged first, thin=
gs
>> should work.
>=20
> OK, that's good. The only issue is that we're pretty much out of time
> right now for v3.12 merge window.

Yep. Well, maybe it's easier if I try to merge this via fbdev. The
problem there is that the fbdev maintainer has been inactive more or
less for the whole summer, so how the pull requests will be managed is a
bit unclear. But my guess is that I will be handling fbdev, which makes
merging this series via fbdev easier.

 Tomi



--XxahVkOcIQlt3Vsoo9o9T3Nka0CupcTfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHvECAAoJEPo9qoy8lh71fcEP/iwyZ+bM+jxZqnnDnnSnQg38
1uMCtOJt3dmbqyqRfFsC1wRNWIYbKAIybIJEuwqH0dwDgCmpXoVrPfZXevBtyXuS
dsmh4L/IR6aUZnPrvfKzjPZLAG1U867Uy3swviOjpGQUWGc13ODrXo7jovLvm5GO
ZJh7M3mxKLrW3zQbALfQuyHyK09aNYbmnKU8hT8ZiXN1G1r5MxKL6D/5wY9Sze8R
TL1NR5WwE8AtnqkNsfTC3e1m8khKX4MAc4dUWNodkp1+uyXzviHPz0WdIIjK4AVb
/qKutF8HMtpSDn+/ZFy5vi/XesJM/fKcCHPUKZoYdx9I5Kyl+uTkvtoHPUdFrUTq
tUu6agIrP/0ceTLtBQDS/qcAVq5FL0yQAVjT9b7WGyRB9NuOC+PrXLhkA+DPI1Mi
iFQSh3i9RFtWuTCTvI9eopXFrHw8Embbf4abPVCzWn/sNVdSMZWkxi2nDCOlVAAH
1KqksCmCfu8s3cWcwif7dYn2Vm4RPqaDUNln4bzeOKXMNwTvhfYdE+coiDz/KrCc
+4+Kzdmnh0a1wkAyzlTpu9bSoyX1I2TsLh2eo11D2PjD2XRIikxsFAMsrByps5Bs
MB8Y6S8Ba70n8UEhIIFW9G1+S313UlptbHor01pfh/BdCfd/lLhZ0vy8hLO1s+cp
Gc4hCQt3cYTOT20FLnsB
=DJd8
-----END PGP SIGNATURE-----

--XxahVkOcIQlt3Vsoo9o9T3Nka0CupcTfs--
