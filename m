From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: omapfb: Add early framebuffer memory allocator
Date: Mon, 11 Jan 2016 20:34:31 +0200
Message-ID: <5693F5B7.8040608@ti.com>
References: <52A062A0.3070005@ti.com>
 <1388013159-3036-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011301.27415@pali> <568A5970.2000201@ti.com>
 <568A6DD1.5050700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3gX3iCsIVF0kC0ULNCFcmhjwxbsUsMVJ5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568A6DD1.5050700@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

--3gX3iCsIVF0kC0ULNCFcmhjwxbsUsMVJ5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 04/01/16 15:04, Ivaylo Dimitrov wrote:
> Hi Tomi,
>=20
> On  4.01.2016 13:37, Tomi Valkeinen wrote:
>>
>> We probably need exactly the same for omapdrm, as omapfb is on the way=

>> to being deprecated. And sounds to me that we probably need similar fo=
r
>> other devices which try to do large allocations (camera? video
>> decoders?).
>>
>=20
> Re omapdrm - I guess it wouldn't be hard for omapdrm to use the same
> preallocated memory, when/if it is needed. Though I know nothing about
> omapdrm, so can't really tell.
>=20
> If not mistaken, camera driver uses sg lists. DSP needs such a memory,
> but anyway it(driver) was removed from mainline, with no signs/hope to
> be returned anytime soon.

I don't know about omap3 (if that's what you're talking about), but
generally, I think it depends very much on the IPs used. I don't think
all capture IPs support sg.

>> So I really think this should be somehow be a general option for any
>> device.
>>
>=20
> Then maybe add the relevant people in CC, so we to start some kind of
> discussion. But until such a general option exists, I think it makes
> sense to apply the $subject patch, we can easily fix it to use whatever=

> general purpose API might the discussion come up with. As it is now,
> omapfb simply cannot be used to play any video with sane resolution
> (without preallocated memory that is), unless this is the only thing th=
e
> device does. And even then it is not assured.

The patch itself looks fine to me, and I have no problem adding
temporary code to help solve use cases. Except when they add new
userspace APIs, which is what's done here. I've been bitten too many
times by an userspace API that I need to maintain forever, making new
development difficult. That's the reason I'm (maybe overly) cautious here=
=2E

I also want to point out that the patch was posted two years ago. And
now there's a ping for the first time. It cannot be a huge problem to a
lot of people.

Adding to that is the fact that omapfb is now in maintenance mode, and
all new development is done for omapdrm.

So, I'm not very enthusiastic about adding this feature as an omapfb
specific boot parameter.

 Tomi


--3gX3iCsIVF0kC0ULNCFcmhjwxbsUsMVJ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk/W3AAoJEPo9qoy8lh715jQP/iLmQc8TP7wFfyOfn+OL6LVM
bGxhLzMVxo/UXqemPsntmYyXo09cutaT31VvgbR6wkJhrWjcHYBJoWo7Y2Nnt/GW
bSwqXVeahVyRHR4YzzID9/iGLzcrKLcbKZEMZYHnHDp67tkWA2mGysrV+Oy8ks+W
Q+nKezguxgs7PhSq3PDS9gR7Qjj+yGCPy9aPYJPmYlHQBEkKXlUvykxfKy4reBcC
5QW+feaGBiU9/s1kFfbonzKlf5KdXaVpCjmbkedkW+03TtaafCaQyG9933fruTu/
YTk4W+VCJ23GWxyxpcpVX6zVcP2uPW6od6kJ8vtsQtSwaLieGJKhyR//QXcOowJl
Y/42JHujSxgbcg0a/EDbTExc5l7GiBbc4fsgc9f83p2gKgOx5Qvc4FSB6P8RMAwz
Im2fNNul57S6fVA8x9qzfwFmubtqzubuKXjUKaKG0KpauhQL1dIXXoGyij8KWEWT
km8bSVocqpNJyMoHVMp3G0D3u2/rpSDrEZH5sOoyqwTYhGDS2uMV4+JL40N5FoqP
5H/944PKAr7P54f6Wrh8BkRACCRnTRKJHvv1PO6Zby63RjcmyIS2iMx0ZNbBTdpQ
eFzDt3azCplWP+GZOx/5UNBPOZvDMNKVEvarNSGJeyH4Xw1oWWgWzlTJPdUl414b
pDclG0U/nQw2EDZpr6U/
=S15E
-----END PGP SIGNATURE-----

--3gX3iCsIVF0kC0ULNCFcmhjwxbsUsMVJ5--
