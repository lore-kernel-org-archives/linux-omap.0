From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support
 audio
Date: Tue, 23 Oct 2012 12:37:45 +0300
Message-ID: <50866569.8010409@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com> <1350350839-30408-7-git-send-email-ricardo.neri@ti.com> <5084F85C.9050508@ti.com> <5085E957.6060003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADFB0FC370754792320D5257"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58170 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756956Ab2JWJhs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Oct 2012 05:37:48 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9N9blNi014313
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 04:37:47 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9N9blv7030029
	for <linux-omap@vger.kernel.org>; Tue, 23 Oct 2012 04:37:47 -0500
In-Reply-To: <5085E957.6060003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org

--------------enigADFB0FC370754792320D5257
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-23 03:48, Ricardo Neri wrote:

>>> +#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
>>> +#define HDMI_AUDIO_MEM_RESOURCE 0
>>> +#define HDMI_AUDIO_DMA_RESOURCE 1
>>
>> I don't see much point with these definitions. They are hdmi.c interna=
l,
>> so the audio driver can't use them, and so they aren't really fixed.
>=20
> I just thought it could make the code more readable; but if the
> resources array is going to be local, then they are not helpful.

My point was that if the defines as hdmi.c internal, you need to add the
same defines into the audio code also in order to use them. And then
we'd have the same defines in two places.

Or, if audio code doesn't need them to parse the resources, then they
aren't really relevant here either, as you are just adding two resources
to the array, and their order is not important.

>> So, how will this work? All the audio related functions will be remove=
d
>> from the (video) hdmi driver, and the audio driver will access the
>> registers independently? The audio driver will still need to access th=
e
>> video parts, right?
> That could be a new approach, but the idea here is to continue having a=
n
> omapdss audio interface for audio drivers to use.

Ok. Do you have a git tree with the audio code working with this
approach? Or can you just copy paste a few lines showing how the audio
driver uses this. It'd be easier to understand by seeing that side of
the code also.

The audio uses sDMA for the transfer?

> The root problem that I am trying to address is that the omapdss audio
> interface does not have functionality for DMA transfer of audio samples=

> to the HDMI IP. Also, I am not sure how that could be done without
> duplicating the functionality that ASoC already provides.

Ok. But the audio driver still needs access to the HDMI registers? I'm
not worried about passing the DMA resource. Video side doesn't use that.
But video side uses the registers, and both having the same ioremapped
area could possibly lead both writing to the same register. Or perhaps
not the same register, but still doing conflicting things at the hw
level at the same time.

>> I feel a bit uneasy about giving the same ioremapped register space to=

>> two independent drivers... If we could split the registers to video an=
d
>> audio parts, each driver only ioremapping their respective registers,
>> it'd be much better.
>=20
> Fwiw, the audio drivers (at least my audio drivers) will not ioremap.
> They will just take the DMA request number and port. Maybe spliting the=

> register space into audio and video is not practical as we would endup
> having many tiny address spaces.

Yes, if there's no clear HDMI block division for video and audio, then
it doesn't sound good to split them up if we'd have lots of small
address spaces.

What registers does the audio side need to access? Why are part of the
registers accessed via the hdmi driver API, and some directly? I imagine
it'd be better to do either one of those, but not both.

 Tomi



--------------enigADFB0FC370754792320D5257
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQhmVpAAoJEPo9qoy8lh71LOQP/RrQCQHiErUSCOuun2TzFQw7
FIa6UeyrGf1f02howcTeuGj7AvluoUJ+CJ6DO28mCY8XkmMnA0u291uxwbZDGfJf
qWYAjWqcA+/vr7qcwANDpdt8RzaYitXX/bhlQaDzbB6lmT8y9ilJBm0qFwaNqHxI
5j4QPxjvOSveSrwFbA98PtzRGUtj9ldZ2qp1uTcffoAci08r53PobQLyBXTYSmLD
UINwCzbwl7pWj5QgLqBsavl58ZB7B5iLR/DK2htkDyDNGsHiOOvQ7DJZyfMV8qnK
6zQPUbCWBO4WZubiuuKk2HehnI1BEIMlYlQqTaU2ZBqnUYySQY1ttLExM3jUKB+l
brM5/wbTaci68TyZXbZaTtyJe8njLKlGDvSrAOk6OAi9zuASHn8aSkZde/vHSxcs
JDAzn+ybDUtLOF5ui/rthPvrRpXovRIIncIGfvQfEBVdusvNjzQFUFnIAAvJaqeR
p4BG8Csaod9YLA/odccQvhaUjQKxwsb4U0EUVU2fDGfLBAAbpta2aPaPsfvXwQ5B
pRVK/FVPm7KCtEzRwnPJ1jtkF0RseVYTGJ72SfT6dWJDjc2pZj+mfMThyhlZR0Kh
hD5xaIYTtJ0Ai3E96HzyyAVl4RI1BToWRTgFtR4/IqkJ2pDqZPnh6Ez6a4+AKDMm
Qri2Y3ny+UOKSgPjwJQm
=1bSJ
-----END PGP SIGNATURE-----

--------------enigADFB0FC370754792320D5257--
