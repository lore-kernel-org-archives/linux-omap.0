From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: downscaling YUV fails
Date: Wed, 19 Dec 2012 13:59:17 +0200
Message-ID: <50D1AC15.90407@ti.com>
References: <alpine.DEB.2.01.1212191025480.16226@pmeerw.net> <50D193FD.4070401@ti.com> <alpine.DEB.2.01.1212191132250.16226@pmeerw.net> <50D1A2BC.4040605@ti.com> <50D1A34B.8030308@ti.com> <50D1AA85.1000207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3E8A993876FEFE1A874BD70"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48960 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2LSL7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 06:59:21 -0500
In-Reply-To: <50D1AA85.1000207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-omap@vger.kernel.org

--------------enigE3E8A993876FEFE1A874BD70
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 13:52, Archit Taneja wrote:
> On Wednesday 19 December 2012 04:51 PM, Tomi Valkeinen wrote:
>> On 2012-12-19 13:19, Tomi Valkeinen wrote:
>>> On 2012-12-19 12:51, Peter Meerwald wrote:
>>>> Hello,
>>>>
>>>>> In the case we set it to 4, the DISPC_FCLK is fast enough to do the=

>>>>> required
>>>>> downscaling, but in the case when it's set to 0, it might need to
>>>>> pre decimate
>>>>> rather than try to scale.
>>>>
>>>> this is my understanding as well
>>>>
>>>>>> I think there is a bug downscaling YUV data when resorting to
>>>>>> pre-decimation; setting CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK is a
>>>>>> workaround
>>>>>> -- any ideas how this can be fixed?
>>>>
>>>>> Pre-decimation should work for YUV formats also. Could you share
>>>>> DISPC reg
>>>>> dumps when this happens:
>>>>>
>>>>> mount -t debugfs debugfs /sys/kernel/debug
>>>>> cat /sys/kernel/debug/omapdss/dispc
>>>>
>>>> please find the files http://pmeerw.net/ok.dispc (with
>>>> FCK_PER_PCK=3D4) and
>>>> http://pmeerw.net/fail.dispc (FCK_PER_PCK=3D0)
>>>
>>> Something funny is going on here. I can reproduce on omap3 with a few=

>>> hacks that reduce the clocks. The PICTURE_SIZE's width field is
>>> different for working and non-working cases, but I think it should be=

>>> the same for both.
>>
>> Ah, never mind. Of course the picture_size needs to be modified if
>> predecimation is used...
>=20
> You said that you see the issue with RGB too. Did you mean the
> picture_size, or visually also?

Visually. I see skewed image for both RGB and YUV modes on omap3.

It was a bit difficult to reproduce, but I first forced the clocks down,
and then I was able to get predecimation for RGB, but not YUV. The
reason was this:

		if (color_mode =3D=3D OMAP_DSS_COLOR_RGB24U)
			core_clk <<=3D 1;

So for some reason, the core_clk requirement for RGB24U is x2 than for
others. I have _no_ idea why that is, the line has been there from the
start...

After I removed the if, so that the core_clk requirement is x2 always, I
also got predecimation for YUV, and I see the same skew.

> One thing I'm guessing is that DMA fetching with predecimation isn't
> really optimised for omap3, if the pixel clock in Peter's setup is high=
,
> the DISPC DMA might not be able to fetch pixels fast enough in
> predecimation case. That sort of supports the possibility of a skewed
> image seen.

The image I get is stable, and clearly something that happens when, say,
row_inc is one pixel too much, or similar.

 Tomi



--------------enigE3E8A993876FEFE1A874BD70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0awVAAoJEPo9qoy8lh71VPQQAKO16/FJXgNCHT/1YTpe+l/U
hx2FHHeT273fVXaVWAVr0hWB7fY6eSEdWxlQO2yvszVQiWhKxXkVlrtxlhT954j0
C340JaCDapwaNWy1F1u5CRiFhNtaqVy28fKB9C2FN4Hltsj9E/XySEnA4F3cz+eP
PuS++KHR/8KhaENhmjT3+0qSdGAmxGIsp1ZRfOrIy25bnkk8iv5HBo5GYPBjFAWE
kGSqPeMjKmhqZGZLESsVWXAfkhUX2a1wzg+3KhdZW7ot8Rdo7Jg3foCMvPlb1jku
bXEl1RuJ4BY+GhsRrI6ZZRpJHBg6Rcmk3EGmXSsHxf9Ewgh0m73a+/wYOyQAF0+I
vFae2uK4ZrzjHPwU+uCNaewRlgN8TH5S/29bUli2akXllFS8O4606QpdOyLq9IUS
LUT5uVEhSD5aT7rGen7fVRFrzJgoYzXVJ4ZpKNy2N1ZyyLTUyv73Lqp9gUafgkHI
AK4yD5iPtX461/J46ieXUB76goxfbJfdQA45DnL+qbMs0NcHLfkggtgM0DX8vTfA
dY9NhOmn0n3gkcTN0PC7RtePJSN/3TdeeCTvg9haplzKJb4ZTe3sMMYHRQcFXCZA
Mba2+w1VZ3CJleAB7mJ6ov1h7YcSMrovjNZ+qeFVPnWBXXQgRsTNBfUS0+glcSHR
z6MrZmP9StsNq9NhE2ok
=SUgC
-----END PGP SIGNATURE-----

--------------enigE3E8A993876FEFE1A874BD70--
