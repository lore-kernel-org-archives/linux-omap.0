From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Date: Wed, 15 Oct 2014 18:43:40 +0300
Message-ID: <543E962C.2050505@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com> <543E64EE.4070104@ti.com> <20141015144140.GD10888@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="QeSwm7DQBnTjjvdkodf9iumcHoaidVFJG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48847 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaJOPoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 11:44:11 -0400
In-Reply-To: <20141015144140.GD10888@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--QeSwm7DQBnTjjvdkodf9iumcHoaidVFJG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/10/14 17:41, Felipe Balbi wrote:

>> Interesting. I don't know if I'm doing something funny, but without th=
is
>> patch, I can unbind omapfb, kind of.
>>
>> "echo omapfb > unbind" goes ok, but remove is obviously not called.
>=20
> remove isn't called because it won't exist if it's built-in. Look at th=
e
> definition of __exit_p()

Yes, that's what I meant with "obviously".

>> Somehow omapfb device is still unbound from the driver, as I can then
>> bind it again, causing probe to be called. Which breaks everything.
>>
>> I would've thought that unbinding is not possible if remove is missing=
,
>> but that doesn't seem to be the case. I guess it just means that remov=
e
>> is not called when the driver & device are unbound.
>=20
> if no remove it provided on platform_driver structure, platform bus
> assumes you have nothing to do on your ->remove(), so you end up leakin=
g
> all resources you allocated on ->probe() (unless you *really* don't nee=
d
> to do anything on ->remove).

Yep. That's quite odd, still. grep shows quite many uses of __exit_p(),
and all for remove callback. So, if you have something to release in
remove(), you should set it always, for both module and built-in. And if
you don't have anything to release, you would always just set .release
to NULL.

I mean, what's the use case for __exit_p()? With a quick glance, at
least some of the other users also use __exit_p() the same way omapdss
does (i.e. in the wrong way).

>> We have 18 __exit_p()s in omapdss and related drivers. I guess they ar=
e
>> all broken the same way.
>=20
> yup, I should've grepped.
>=20
>> Note that omapfb unbind & bind does not work even with this patch, but=

>> results in a crash as some old state is left into omapdss. The same
>> happens also with unloading and loading omapfb module (but keeping
>> omapdss module loaded).
>=20
> It worked fine for me. I unbound and bound omapfb multiple times.

Hmm, ok. Odd, the bug was quite clear and I think it should happen every
time. Well, I was using omap4. If you used AM4xx, that's basically omap3
DSS. Maybe there's a diff there.

>> So there seems to be more issues around this.
>=20
> quite a few more, I'd say

Yep, I'll have a look at this.

 Tomi



--QeSwm7DQBnTjjvdkodf9iumcHoaidVFJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPpYsAAoJEPo9qoy8lh71XagP/3+V8v3Aozr1Z/WTC9yD3ri7
6V9iifymnQhyTotuEBqY0kXvtyj4lqFhw4N59D0V+Vwgk+Oxl9t3KY6jsziZbZ5t
iQZx6CBgHc10Fvjv3SKElxJuYfxab7x6o2iy6K4ops/XudWxanZfptao9GWssZRw
MLzht3+1ptBe/Lp3NcLkOhGbbJhip4RVmvNtFsrbs3FQTbW+bF0AY0zcyjbCFqDT
JDODHttjHATdAL7A3gyNicgTR7OyEHf9OtpdxRTzn+qOzocHty6RqjsI/LUwDxvb
YxayrA/h8Qitf5/F8XO+STSQDUXs7dQQ2F17QKwhZWJvwULafsHLtN2pVCDUNzXW
X/XF5Z5CeiuGXpo+/jPl5RZUTlxgXkNOV2ldvT57eheFsGAtVd5L26YKBLWRknVh
ZiMoaqxw3esybv/AEryIwmf0nmR2wJ+4YASJm4RZ1CkGIJ1HKa47AXy118z7JiwV
vvhv14y4gPwPbNNegUCDdUKkh3bb7ycGr3BNOHzdWNJpaO+nwON+pNKRGxSuiUFD
8u4yEkL923TXbaTW5zy/tbzf0GDVBqQsBVbs7SLd8pK+26c01H7evi8CX5nN+CTh
jNFqCFtxCW0J5XXAr6I/fT/zlNfMFI3NEr2D7JvxfpnJ2Wz55IEOAVTzxSggVUcm
NHee8roHraxhcli8INX3
=04LQ
-----END PGP SIGNATURE-----

--QeSwm7DQBnTjjvdkodf9iumcHoaidVFJG--
