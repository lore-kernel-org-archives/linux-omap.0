From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of regulator
 framework to control avdd_dac
Date: Thu, 8 Oct 2009 14:40:46 +0100
Message-ID: <20091008134046.GH29176@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
 <1255004227.30157.159.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33520 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758423AbZJHNlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 09:41:24 -0400
Content-Disposition: inline
In-Reply-To: <1255004227.30157.159.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 03:17:07PM +0300, Eero Nurkkala wrote:

> Will this ever be revisited =) ? If so, I think there's going to be a
> jungle in finding the right spots - you need to remember the bypass
> paths also (bias is not on necessarily).

The bias is always on when any path through the chip is on, this was
fixed in either .31 or .30.

>                                          Also, this is regulator thing
> is highly platform dependent, not aic3x related really at all, so is
> this the correct place... Just a thought, dont take it too seriously ;) 

I'm not sure what you mean by this?
