From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Tue, 25 Nov 2014 11:26:36 +0200
Message-ID: <54744B4C.2030105@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk> <54646648.5030807@ti.com> <546DC9A0.8060700@ti.com> <20141121112317.GQ3815@sirena.org.uk> <546F317B.9030004@ti.com> <20141121161435.GS3815@sirena.org.uk> <5472E9D7.7000908@ti.com> <20141124173920.GL7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9eL0DQpkaKSGrAumvCeus5fPPmaRm7WWb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41096 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbaKYJ0w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2014 04:26:52 -0500
In-Reply-To: <20141124173920.GL7712@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--9eL0DQpkaKSGrAumvCeus5fPPmaRm7WWb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/11/14 19:39, Mark Brown wrote:

> OK...  this is all telling me that I *really* need to scrub this in
> detail.  It's all sounding very vague, it's an area which seems to caus=
e
> lots of problems and I don't want to be sitting here next time around
> trying to figure out if another rewrite makes things better or worse or=

> if another driver should look similar or different.

I was vague as I don't have the details. I don't know much about the
audio side, except from the users side. Jyri can perhaps fill in the
details.

But a proper review for sound/ side would be appreciated.

For what it's worth, I can say from a user's perspective that with this
series the OMAP HDMI audio finally seems to work so that I'm satisfied
with it. While there's still things to improve, it works and I can keep
it enabled in the kernel while developing the video side and it doesn't
get on my way.

>> The whole series is about HDMI audio, not video.
>=20
> You know exactly what I mean - the early patches are in drivers/video,
> don't touch anything outside of that and have no obvious dependencies.

My point was, there's no particular reason to apply those patches
individually. It's an independent series, about HDMI audio, and applying
only some of the earlier patches does not improve the kernel in visible
manner.

>> And in any case, I don't like applying individual patches from a serie=
s.
>> Usually that just complicates things. If I would apply some of the ear=
ly
>> patches to fbdev, then this series would no longer work on plain
>> mainline kernel, and would instead depend on fbdev tree. The situation=

>=20
> But I thought everyone was saying this hardware doesn't work anyway and=

> that you want to apply all these changes to fbdev?

I don't particularly _want_ to apply these via fbdev, but I think it's
the easiest way. Most of the files touched are in drivers/video/, so
hopefully merging via fbdev reduces the chances of conflicts.

And this needs your ack before it can be merged via fbdev tree. Until
you've said that you're fine getting this via fbdev, we don't know how
this will be merged, and I can't create dependencies to fbdev.

> This means we're all then stuck reading reposts of the same enormous
> series over and over again - as a reviewer a really big series that
> appears from the subject lines to be mostly about another system is
> really offputting.  If you're going to do something like this please at=


Well, yes, I see your point. And I agree that patches that the rest of
the series does not depend on should normally be applied individually if
the series starts getting multiple revisions (although even those
patches could cause conflicts if the rest of the patches touch code nearb=
y).

But that's not the case here, as all the patches are needed to get a
working HDMI audio.

> least reply to the messages, that way it's clearer that there's not
> going to be a dependency problem getting the patches applied (which is
> part of what makes things offputting).

Yes, lack of communication was my mistake.

In any case, how do you want to proceed? As I said, I very much would
like to get this into the next merge window and from my point of view
the current versions looks good. If you find something to be fixed in
the sound/ side, and you're fine with merging this via fbdev, I can
start merging the earlier patches in the series so that the next
revision is easier to review.

But the merge window is getting close. If you find something very wrong
with the series, we can skip this merge window. But if there are only
issues that can be easily fixed with follow-up patches, I'd rather merge
this revision than do more full review rounds.

 Tomi



--9eL0DQpkaKSGrAumvCeus5fPPmaRm7WWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdEtQAAoJEPo9qoy8lh71948P/ijNBPT/0dYzyqHPji6j/YWO
BYHQ5gdgrrwPCuztoquixMyMuLzTiAQZz0GprFnDnymkKCdl/SdU/IQ6IFHVaai+
bN3umihTTivc54zXIZNaoT1owCO0xyFyDwXBFXgCDqHC/qmflOk+zynDEBp+jZli
+PdfJzY8LYLyFa8XqL9v6J5LENpYpQFoCJtARQou25leKP248yJ0idxCf99EBOOV
vYzq97Sbyuu1zXf4Ju7kBVeXMROBlMNDOjoep4x19OMTy3gt+PJVyedE6ZKTqe/d
tz7o0b953O3XTpcoyrcCww8e7QgpRaL+6GURptPIEG+BKJMG+EhMDi0KZaidA7VI
osk5N9v/Ys9yZCHjirIudbQ7Ic5KguhfnBi2RlyKIfJGyaAeinqdtvcvm4DFUUCM
rFuJKuOKiW4H2WH9sIySRhmLnIeuUi/emWHd6v3VHjy6pa/znmR9aaEDR02QwwfK
MOIk11Zr9Lfzjhzr2tiwLqrFR2pjiMZQsaCwffoD2bfop1/hohSqoSm88n5djlob
6KnrVRJN3OZgVfq/kQX/0UI4ytV4vcoXa/bYbzZZbBjQordi98iYQk4U8awskBPj
Zd5qNt3Wm49Y1HRMAD4kXo+tz8nYrh2xjmXjwzJ+Q3NiDhRWau4PUewimPnQ6Vtg
lD9JkUNJllPFvWU3SJ2b
=nRm4
-----END PGP SIGNATURE-----

--9eL0DQpkaKSGrAumvCeus5fPPmaRm7WWb--
