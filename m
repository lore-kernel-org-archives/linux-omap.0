From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Fri, 19 Feb 2010 10:34:32 +0200
Message-ID: <201002191034.32391.peter.ujfalusi@nokia.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com> <20100218222229.0f0eb3a9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34695 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0BSIfI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 03:35:08 -0500
In-Reply-To: <20100218222229.0f0eb3a9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>

On Thursday 18 February 2010 22:22:29 ext Jarkko Nikula wrote:
>=20
> I still have two concern:
>=20
> 1. port number vs. index difference inside driver code is not enough
>=20
> It's just confusing if a machine driver and internal API (mcbsp.c) ha=
s
> to use different indexing. See:
>=20
> omap_mcbsp_st_add_controls(codec, 2);
> ...
> *(unsigned int *)omap3beagle_dai.cpu_dai->private_data =3D 1; /* McBS=
P2 */

Agreed.

=20
> and mcbsp->id use in mcbsp.c.

It has always bothered me, I'll take a look and check if there is a rea=
son why=20
it is like that, and if possible I'll change the mcbsp->id to be 0 base=
d (thus=20
harmonizing the internal and external interface).
=20
> 2. I cannot change the sidetone level with alsamixer
>=20
> Is this bug with the alsamixer? With amixer I'm able to set positive
> values but not negative
>=20
> amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32767
>=20
> What I'm looking here, is that I can execute a test below with unit
> impulse response tap filter, hear the sound and note that the volume =
is
> changing as I'm changing the sidetone volume :-)

I'm not sure, but you might need to configure the taps as well to have =
the=20
correct sidetone.
Also I have a recollection, that the McBSP sidetone requires DSP mode (=
TDM) in=20
order to operate correctly, so on Beagle you might need to set up 4 cha=
nnel=20
mode. And how the channel mapping in 4 channel mode works in McBSP side=
tone is=20
another matter...

>=20
> arecord -f dat >/dev/null |aplay -f dat /dev/zero

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
