From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and AIC34b_dummy
 driver
Date: Fri, 9 Oct 2009 08:44:00 +0300
Message-ID: <20091009084400.34df690a.jhnikula@gmail.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
	<20091008131116.GB29176@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:45845 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZJIFoF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 01:44:05 -0400
In-Reply-To: <20091008131116.GB29176@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, 8 Oct 2009 14:11:16 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> What is an "AIC34b_dummy (block B)"?  You probably want to split it out
> into a separate patch.
> 
I think this is the reason why Eduardo mentioned my name in the commit
log :-)

Yep, dummy driver is for block B of AIC34 which is basically dual AIC33
in a same package.

> > + * TODO:
> > + * - Get rid of this driver, at least when ASoC v2 is merged and when
> > + *   we can support multiple codec instances in tlv320aic3x.c driver.
> > + *   This driver is hacked only for Nokia RX51 HW.
> 
> Could you please explain what the issue here is?  A description of the
> hardware would go a long way here.
> 
Eduardo, please correct me if I remember wrong  but block B of AIC34 is
not used as an codec as such but more like an amplifier and analogic
mixer with digital parts unused. So with this dummy driver the HW
features were easier to support than to develop multiple intance
support for codec drivers.


-- 
Jarkko
