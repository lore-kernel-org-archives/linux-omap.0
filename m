From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Tue, 2 Apr 2013 11:01:29 +0300
Message-ID: <515A9059.4020203@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <51546259.3000704@compulab.co.il> <51547462.3070803@ti.com> <5157F625.5070509@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDAC5C5675602BECF43089694"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757655Ab3DBIBi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 04:01:38 -0400
In-Reply-To: <5157F625.5070509@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

--------------enigDAC5C5675602BECF43089694
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-31 11:39, Igor Grinberg wrote:
> On 03/28/13 18:48, Tomi Valkeinen wrote:
>> On 2013-03-28 17:31, Igor Grinberg wrote:
>>> On 03/28/13 14:48, Tomi Valkeinen wrote:
>>>> So here are the DSS related board file changes for 3.10.
>>>>
>>>> First there are a bunch of patches adding the Kconfig options so tha=
t only one
>>>> display device is created for a single video bus. Only Overo had mor=
e than two
>>>> displays on the same bus, but unfortunately there were multiple boar=
ds with a
>>>> setup that puts an LCD and DVI output on the same video bus.
>>>
>>> Hmmm, so basically, if one could switch the display at runtime...
>>> This cannot be done anymore...
>>> This sounds like feature removal, no?
>>> I know several of our clients who used this feature
>>> (at least for evaluation purposes).
>=20
>> At some point in time it was possible to have multiple displays for th=
e
>> same bus, and switch them at runtime.
>=20
>> Sometime later it was changed so that the board file adds all the
>> displays, but only one (per bus) is actually added to the list of
>> panels, but you could still set the default display in the kernel args=
,
>> and thus you could select which display gets added.
>=20
> Yeah, I remember we had to hack this to have the functionality back...

Ok. You could've informed me so that I knew it's needed =3D). I've
received no complaints about it, so I thought nobody is even using it.

>> The reason why the multiple-displays-per-bus is problematic is that th=
e
>> video bus cannot be shared, and if we have multiple devices on the sam=
e
>> bus, the drivers need extra trickery, delaying initializations, etc, t=
o
>> handle this. And it still doesn't work right, as it's easy to get two
>> displays enabled at the same time, configuring the same video bus,
>> creating a mess.
>=20
> Yep, looks like additional display manager framework is needed.
> Which will manage the displays on per bus basis?
>=20
>=20
>> Quite often the case is that the other displays are not even present
>> physically. But it is true that some boards have gpio switches that ca=
n
>> be used to change the display during runtime.
>=20
> I don't think the runtime switch requirement will ever go away, so we'd=

> better prepare for it wisely.
>=20
>=20
>>> Is there any strong pros you obtain while removing this feature?
>=20
>> For an user, only indirectly. The change will make things sane on the
>> display side, and will thus make it much easier to proceed towards DT
>> adaptation, and Common Display Framework. While I can't say it's a
>> strict must to remove this feature, I can say that it's been a constan=
t
>> headache for me for, well, ever. And I presume CDF would not have this=

>> feature anyway, as it's rather bad design.
>=20
> Well, I don't know about the CDF, but the runtime switch was there
> for ages... Think of a DVI or an HDMI... they have the EDID stuff
> to make the switch work as expected and it really brings multiple
> displays to the same video bus.
> I see this is only a meter of how we represent things.
> Instead of real EDID (or in addition), that comes with the display,
> currently we have the panel info already in the kernel and
> panel driver with board specific callbacks to make it work.
> So abstracting the above (in the long run) to CDF or some other
> framework, should suit everybody's needs.
> Probably, we will need board specific drivers, but that never
> was a problem...

Comparing desktop DVI/HDMI to our case is not a very good comparison.
For desktop DVI/HDMI there are no panel devices or such, so it's trivial
to manage multiple outputs in the display driver.

We need panel device hotplug/unplug support to make this work properly,
and as there's no generic way to do that, we need board specific drivers
to handle the hotplug/unplug.

And we probably need some way to show the information about possible
displays to the userspace. I mean, with a case like DVI/Panel on the
board, it would make sense to show the userspace that there are those
two options, even if the other device is not even present.

 Tomi


--------------enigDAC5C5675602BECF43089694
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWpBZAAoJEPo9qoy8lh71cXwP/1z73m2PQMPdU0mcAwYEMb0u
0LD0U8ie0G7VPehlsejCxuUEsqhIJ8oyylryJiMRf2wEiwOru7h+ajaRmHLqlj4J
iOyyK8letkEqCI3pyDuRJ5YQsIc+3JwUN7/a01HGNg7NrwQpj+BHyaAmq1o1BgdK
w8ihhxsIy0zoaKo5VHfMXJy1Oun/RKBLAa08Bl2Uf6NWkudjRNHk5Dh8Izz6p6by
epwZfRl0gXN8RTyjVnURtR+DtiRl0oZrAOnBPWYg7U4aiRII7St3PQaCJDba7zQC
rk4LYZJ3heiAi15KdG5xfBjcOSCkCwfGnt8Ei7GmlTALXb1Lw64VIUJOLMVdWNdx
B0z22KRqRrDs/lm10Hsmp3A/xkKkG4LU04nL/qGYn5BVUt5lb2X6e6yGIz3unaAa
zLr063YngUF8/jja9UNfUpkCT07CDWz2EzLfVK7va08cNC3y5LT/8db2oYdVbC/q
B01DIZK2XIFA2LWjaC/cY5Jb74HF6FtDzMSyY5V6QBbjYYFOuiXLGuxGITau9TPT
MLadrKWsIiExmf4KhAlj8zBZXzD+qY+hKAixkQJbMGju89sBokjTXsMjAcHyDWEV
2LEM1Hoz7kitQQtGk6SmXsekvREqtTcHrGBXQYNdhQwpGf41LwrLJGiFTKxadXac
gGDVPc6dcHQiYKIRtqv7
=AJBp
-----END PGP SIGNATURE-----

--------------enigDAC5C5675602BECF43089694--
