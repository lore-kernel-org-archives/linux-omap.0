From: Greg Knight <g.knight@symetrica.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 13:17:02 -0400
Message-ID: <1426785422.13824.12.camel@symus-gk-mint>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com>
	 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
	 <550AF442.5040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:32886 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbbCSRRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 13:17:05 -0400
Received: by qcbjx9 with SMTP id jx9so33386771qcb.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 10:17:04 -0700 (PDT)
In-Reply-To: <550AF442.5040203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2015-03-19 at 18:07 +0200, Peter Ujfalusi wrote:
> Another issue this hack has is: what happens if for some reason the
> SGTL5000
> driver loads first? McASP will not enable the AHCLKX so the codec
> driver will
> fail reading the CHIP_ID and fails to load. You need to provide a
> dummy clock
> node to the codec, so that will not fail, but you will not have the
> MCLK.

Fair enough. The second patch, providing the codec binding to the
AM3359, may still be applicable, but I couldn't submit it in good
conscience without rewiring the clock as per your recommendations and
re-testing. Don't have the time for this in the near future, sadly.
Sounds like I'll have to come up with a new fix whenever we get around
to updating kernel on this platform.

I'm not familiar with the kernel clock management - any advice for
reading material on that? Not clear on what a 'dummy clock' is, etc.

Thanks,
Greg

