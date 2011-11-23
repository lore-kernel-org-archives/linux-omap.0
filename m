From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Re: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support
 for OMAP DMIC
Date: Wed, 23 Nov 2011 15:28:56 +0000
Message-ID: <20111123152856.GB30049@opensource.wolfsonmicro.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
 <3755917.L7uBQxiu6F@barack>
 <20111123143049.GC20272@opensource.wolfsonmicro.com>
 <2903628.kUHW0DbjnM@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57665 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756431Ab1KWP26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 10:28:58 -0500
Content-Disposition: inline
In-Reply-To: <2903628.kUHW0DbjnM@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Wed, Nov 23, 2011 at 05:24:41PM +0200, P=E9ter Ujfalusi wrote:
> On Wednesday 23 November 2011 14:30:50 Mark Brown wrote:
> > Meh, I guess.  It's hard to love code-wise.

> So you would prefer me to enable the OMAP DMIC's clocks at pcm_trigge=
r:start=20
> time, and disable them on pcm_trigger:stop?

I don't know that that's the best place, but it does feel like we ought
to be able to do better than we are (and obviously if the clocks are
required for writing to the registers that does change things a little)=
=2E
Perhaps there's not actually anything better given the restrictions,
it's just that like I say it's hard to love the code.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
