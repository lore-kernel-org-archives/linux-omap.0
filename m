From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Tue, 12 Jul 2011 22:35:53 +0300
Message-ID: <4479173.gaSts1MLKP@barack>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com> <2323058.DqPoNzVktU@barack> <20110709010808.GC18860@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43299 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755102Ab1GLTgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jul 2011 15:36:06 -0400
In-Reply-To: <20110709010808.GC18860@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Saturday 09 July 2011 03:08:10 Mark Brown wrote:
> I've got a few ideas but nothing comprehensive right now; the main th=
ing
> I can think we're missing at the minute is more fine grained hooks
> around stream start in order to allow things to clock off the audio
> stream.  Equally well none of the systems I've had to deal with have =
had
> a particularly pressing problem here.

Yeah, this is the first system if this kind I've seen as well. Anyway, =
we have=20
these constraints, and these might come back in other designs in the fu=
ture.
We will be looking for better/cleaner way to handle this.

> If the machine driver controls the system integration (as we're doing
> for everything else) it's at least clear what's going on for this
> particular system.  My main concern here is making the code actually =
say
> what's going on.

=46air enough.

> Could we split the rewrite out from the delay thing so we can review =
it
> separately?  This'd also be good from the point of view of documentat=
ion
> of what's going on as the changelogs would provide a bit more details=
=2E

Just to avoid confusion (in my part): if I split this patch to one big =
+=20
several small incremental patches, which eventually lead to the current=
=20
situation is what you were asking for?
With the patches I can document the reasoning behind the non standard=20
workarounds. Probably if we see them spread out, we might be able to fi=
nd=20
better ways for them...

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
