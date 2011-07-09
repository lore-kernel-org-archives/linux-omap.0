From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Sat, 9 Jul 2011 10:08:10 +0900
Message-ID: <20110709010808.GC18860@opensource.wolfsonmicro.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
 <1310068516.3569.22.camel@CNA0741383>
 <20110708083733.GA18860@opensource.wolfsonmicro.com>
 <2323058.DqPoNzVktU@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54181 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751838Ab1GIBIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 21:08:18 -0400
Content-Disposition: inline
In-Reply-To: <2323058.DqPoNzVktU@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, Jul 08, 2011 at 06:02:26PM +0300, P=E9ter Ujfalusi wrote:
> On Friday 08 July 2011 16:28:05 Mark Brown wrote:

> > the clocking dependencies are far
> > from unique, for example, and would normally be managed by the mach=
ine
> > drivers with the current infrastructure.

> Sort of yes, but as soon as we have more devices, we will need either=
 ways in=20
> the core, or some common file to handle the clocking, startup, and ot=
her=20
> dependencies between McPDM and the twl6040 - I'm completely ignoring =
the ABE=20
> here.

Well, clearly the machine driver is the common place to handle the
interdependencies between the two devices.  After all either device
(particularly the OMAP) could potentially be used with different system
designs.  If there are many boards with identical setups then they
probably ought to be using the same machine driver anyway.

> BTW: what infrastructure you are suggesting?

I've got a few ideas but nothing comprehensive right now; the main thin=
g
I can think we're missing at the minute is more fine grained hooks
around stream start in order to allow things to clock off the audio
stream.  Equally well none of the systems I've had to deal with have ha=
d
a particularly pressing problem here.

> > Right now it's all sounding
> > far too fragile due to the lack of any explicit indication of what'=
s
> > going on and the fact that things are going to be spread over a bun=
ch of
> > different drivers.

> Agreed, but... if we handle the McPDM stop start from the outside, wi=
ll it=20
> help? I mean we need to keep on eye what the twl6040 is doing, and do=
 things=20
> accordingly within the McPDM.

If the machine driver controls the system integration (as we're doing
for everything else) it's at least clear what's going on for this
particular system.  My main concern here is making the code actually sa=
y
what's going on.

> Another, not directly related thing is that with this driver in place=
 at least=20
> one can play audio on OMAP4 with upstream kernel (through McPDM, and =
without=20
> ABE).

> This area is still work in progress, but I prefer to start from somet=
hing,=20
> which shows some sign of life.

Could we split the rewrite out from the delay thing so we can review it
separately?  This'd also be good from the point of view of documentatio=
n
of what's going on as the changelogs would provide a bit more details.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
