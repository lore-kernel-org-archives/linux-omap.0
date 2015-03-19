From: Greg Knight <g.knight@symetrica.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Thu, 19 Mar 2015 10:34:14 -0400
Message-ID: <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>
References: <1426741659.10003.9.camel@midgaarde>
	<550AC783.8040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:40903 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbbCSOeS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 10:34:18 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:53097)
	by relay12.mail.eu.clara.net (relay.clara.net [81.171.239.32]:10587)
	with esmtpsa (authdaemon_plain:sendmail@symetrica.com) (TLS-1.0:RSA_ARCFOUR_SHA1:16)
	id 1YYbWZ-0004DK-8t  for linux-omap@vger.kernel.org
	(return-path <g.knight@symetrica.com>); Thu, 19 Mar 2015 14:34:15 +0000
Received: by mail-vc0-f176.google.com with SMTP id kv19so8721565vcb.7
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 07:34:14 -0700 (PDT)
In-Reply-To: <550AC783.8040304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Greg Knight <g.knight@symetrica.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> SO is it so that the codec's MCLK is coming from McASP AHCLKX (or R) and this
> clock need to be present all the time? W/o the MCLK the registers are not
> accessible?

Correct, the SGTL5000's I2C registers are not accessible without MCLK.

>From my testing, the clock need only be present when the audio chip is
in use. When not in use, the chip appears perfectly happy to not be
clocked.

Is there a better place to pull a ~12MHz clock signal for use as a
master clock from an AM335X?

> This will not work in mainline kernel. The McASP is turned off when it is not
> in use (no audio activity) so the AHCLKX/R is not going to be there on the
> ball output.

The clock-to-talk hack in the patch enables the AHCLKX line during
codec initialization. From my testing, we don't seem to spend much
time communicating with the device when we're not using it. Disabling
the clock when it's not used should not be a problem.

> How do you configure the frequency of the AHCLKX/R, this hack only enables it,
> so you are going to have _some_ clock going out.

The frequency is the 12 MHz (I think) I get out from AHCLKX without
any further configuration; I have not investigated changing that
frequency as it suited my needs. But I can look into doing
set_clkdiv/set_sysclk during the clock-to-talk enable if that's more
appropriate?

> You should be using set_clkdiv and set_sysclk calls from the machine driver to
> configure the AHCLKX (we do not have AHCLKR supported in the driver ATM).

So, ehm, the SGTL5000 component logic (is this the machine driver?)
should adjust the McASP's clocks? Am I misunderstanding? Would this
not impact binding the SGTL5000 to devices that are *not* McASPs/break
abstraction?

TBH I'm not clear on how the SGTL5000 bindings to other hardware work.
Is it safe to assume set_sysclk is always going to adjust the I2S MCLK
speed? Please pardon my crude questions, I'm not deeply familiar with
the structure of ALSA.

I'll reformat the patches and try from a mainline kernel when I get
some spare time.

Regards,
Greg
