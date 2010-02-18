From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv4 0/2] McBSP: OMAP3: Add sidetone feature
Date: Thu, 18 Feb 2010 22:22:29 +0200
Message-ID: <20100218222229.0f0eb3a9.jhnikula@gmail.com>
References: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:56718 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758682Ab0BRURJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 15:17:09 -0500
Received: by ewy19 with SMTP id 19so7265208ewy.21
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 12:17:08 -0800 (PST)
In-Reply-To: <1266518549-23809-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@nokia.com, broonie@opensource.wolfsonmicro.com, tony@atomide.com, eduardo.valentin@nokia.com, ext-Eero.Nurkkala@nokia.com

On Thu, 18 Feb 2010 20:42:27 +0200
Ilkka Koskinen <ilkka.koskinen@nokia.com> wrote:

> The first patch implements McBSP sidetone feature on OMAP3 while the second
> one provides ALSA interface for using it.
> 
> The patch set is based on the patch Eduardo Valentin sent to alsa-devel
> mailing list in October 2009. Channel gain control and enabling the sidetone
> have been moved to ALSA interface as suggested in comments. 
> 
> These patches apply on top of Janusz Krzysztofik's McBSP register cache
> patches in linux-omap-2.6.git
> 
> Since the version 3, the buggy channel gain control has been fixed. ASoC part 
> have been simplified resulting in removing a couple unnecessary functions.
> Added a comment to ASoC part explaining McBSP port number vs. index values
> used in OMAP McBSP implementation.
> 
I still have two concern:

1. port number vs. index difference inside driver code is not enough

It's just confusing if a machine driver and internal API (mcbsp.c) has
to use different indexing. See:

omap_mcbsp_st_add_controls(codec, 2);
...
*(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 1; /* McBSP2 */

and mcbsp->id use in mcbsp.c.

2. I cannot change the sidetone level with alsamixer

Is this bug with the alsamixer? With amixer I'm able to set positive
values but not negative

amixer set -D hw:0 'McBSP2 Sidetone Channel 0' 32767

What I'm looking here, is that I can execute a test below with unit
impulse response tap filter, hear the sound and note that the volume is
changing as I'm changing the sidetone volume :-)

arecord -f dat >/dev/null |aplay -f dat /dev/zero


-- 
Jarkko
