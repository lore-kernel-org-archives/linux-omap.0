From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Thu, 15 May 2014 12:23:58 +0300
Message-ID: <537487AE.3060906@ti.com>
References: <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com> <53709706.10501@ti.com> <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com> <20140512142646.GA31772@atomide.com> <5370E0C9.8050201@ti.com> <20140512155132.GH31772@atomide.com> <5371F923.80000@ti.com> <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com> <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com> <20140514160216.GD18463@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PMVBEuheJBIBRlbb23kpdXwqKm8jUxJpt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43908 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaEOJYZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2014 05:24:25 -0400
In-Reply-To: <20140514160216.GD18463@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--PMVBEuheJBIBRlbb23kpdXwqKm8jUxJpt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/05/14 19:02, Tony Lindgren wrote:

>> The video paths of the panels and encoders are connected using the v4l=
2
>> style ports/endpoints. We can use those to see what display controller=
 a
>> panel is connected to, but only after the panel driver has already
>> probed. We don't have control for the actual probing, as that happens
>> with whatever the control bus is for the display component.
>=20
> OK. So with generic panels, you can just let the panels probe with
> the right compatible flag then and let the ports/endpoints registration=

> to figure out if the panel is usable for the display controller in
> question.

I'm not sure what you mean here.

Do you mean with the future common display framework? There's no need to
figure out anything there, as supposedly the .dts has been written
correctly and the panel and the display controller work together.

If you mean with the current kernel, there's still nothing to figure
out. We can have only single driver with a particular compatible string.
And as our current drivers are omap specific, it makes sense to have
their compatible string be something omap-ish. And if the .dts file
connects the display controller and the panel, then they must be usable
together.

>>> Well it seems at least the reset and enable pin standard from that
>>> binding can be kept.
>>
>> Only enable gpio there. But even that's vague. Do you turn on the powe=
r
>> before or after setting the enable gpio? How long delay should be
>> between the power and the gpio? Different panels have different rules
>> for the power-up.
>=20
> Sure, it's a complex problem. But for the enable gpio..
>=20
> Maybe the enable GPIO should be treated as a regulator? That would allo=
w
> specifying first the source regulator startup delay, and then the
> panel has it's own startup delay.

Well... I don't know. Sounds rather hacky to me. We have the option to
have a specific driver for this panel, and that driver can handle all
the delays and power-up sequences just right in a clean manner.

>>>>> But I'm not really familiar with using extending current bindings, =
and
>>>>> making new bindings compatible with old ones. Can you explain why i=
t'd
>>>>> be good to have the sharp panel bindings compatible with simple-pan=
el?
>>>>> In what kind of scenario would it be used?
>>>
>>> Ideally the panel binding just describes the panel and it should not
>>> matter which display controller it is a child of.
>>
>> Yes, but that means the panel bindings need to have enough information=

>> so that all display controllers can use it. Simple-panel bindings do n=
ot
>> have enough information. The simple-panel bindings do not have
>> information about the video bus input, and it doesn't even have
>> information about the resolution or bitdepth of the panel.
>=20
> Some of that you can hide into the panel driver based on the compatible=

> flag. So why not already do something like this in the .dts files
> instead of the remapping:
>=20
> compatible =3D "sharp,ls037v7dw01-omap-dss", "sharp,ls037v7dw01";=20
>=20
> And drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
> would only claim to be compatible with "sharp,ls037v7dw01-omap-dss".
>=20
> Then when the common panel framework is available, you can stop
> parsing sharp,ls037v7dw01-omap-dss but the .dts files don't need
> to be changed and it's fine to keep "sharp,ls037v7dw01-omap-dss"
> in the .dts files.

Hmm, I don't see how this relates to the simple-panel bindings.

But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is an
alternative for the compatible-string conversion we do now. I guess it's
a matter of taste, but I rather hide it inside the kernel, in an
internal omapdss file, than pollute the .dts files with those compatible
strings.

>> So I'm still asking, if we create sharp bindings that use the same
>> properties as the simple-panel bindings, and define that sharp panel i=
s
>> compatible with simple-panel, what kind of scenario in practice would =
it
>> be used in?
>=20
> Well with the above example, just by dss with "sharp,ls037v7dw01-omap-d=
ss"
> until some other SoC notices it can use the GPIO parts of the panel
> code at least :)
> =20
>> Would the scenario be some other OS, that doesn't have a driver for th=
e
>> sharp panel, but has a driver for the simple-panel? That would only wo=
rk
>> if the sharp panel hardware is setup so that only the enable gpio is
>> needed, so that quite a narrow definition of "compatible".
>=20
> That's where we can use the compatible flags and just avoid parsing
> the generic compatible flag unless some common framework is available.

Hmm, sorry, I don't follow. My question was about the simple-panel
bindings, not common display framework.

You were saying that the sharp bindings should be compatible with
simple-panel bindings. I'm still trying to understand what benefit does
that give us.

As I see it, the sharp panel could be used with the simple-panel
bindings only in certain special case, where all the mode pins and the
reset are hardwired in the board hardware, and they are hardwired in a
certain state (all hardwired low, probably), which matches what the
simple-panel driver expects.

 Tomi



--PMVBEuheJBIBRlbb23kpdXwqKm8jUxJpt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdIeuAAoJEPo9qoy8lh71KLcQAKbxzjGQ5DE5v3x2aupQKged
nAaoDCvg8Xlu5qn21UcLqLMEM5pVEl+RxWCDgr6TOfRGnQMx/JyE7FKWnKFfzlnH
yNTWCQhiI2rqfZQKkA4ptaS3ZREWN/eyRhoM7N7GDy+7QkvO2wjDlH91XBCn3cha
K7SAxyUkYDczUqFSKOQTE4mDdLq8tcJ2X/HuBCgIG1jYybFCETHbm8UHiBOtXiKG
+wLfYzjiAlUBT+lWTxuQ483AP+fHQxglBokZpAuI0tnVXtc8f3C33tN1taSfGYcb
WseFCMM+kJZXKbgBxeYAS/konpc3PkLB/IBvVOei0xIB0RQbt1rM9FWcc3BmToif
2ks7ATco8mkiTeXbConolIxYt7XkCb9QEflZ4FopwgmTMbtjnWMJBOGfDqTRYWQt
rryEgVdKH/oBonbLd6N1imzzw4fJhuy1GZNtF30jYu/k4NkuSAomtkgbC9R9o5Di
g6opxbEZaDhRjFYG71krrODVuGEDvNxSHgZ1wsCx/Or0Zdq7F31IdgWJvhvkspBe
lZqQS4PJcuY/M0OI4IBS6Kf+Gyifup4GBNzK53sKIcf31z6LQVCrzQQwMZUPyehI
k43tsmucVkJ5+qQBfx5KvtMvVVDALrCd8iy1Zj11xuJOZ68nd0Hk5kw81CLVMX7Q
EEme3aRFLbU1kvif4SLm
=wyNh
-----END PGP SIGNATURE-----

--PMVBEuheJBIBRlbb23kpdXwqKm8jUxJpt--
