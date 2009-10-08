From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: tpa6130a2: Control vdd using regulator
	framework
Date: Thu, 8 Oct 2009 15:41:40 +0100
Message-ID: <20091008144139.GA7830@opensource.wolfsonmicro.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com> <1255003137-1034-9-git-send-email-eduardo.valentin@nokia.com> <20091008134332.GI29176@rakim.wolfsonmicro.main> <20091008135628.GA6616@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:49782 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757499AbZJHOmR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 10:42:17 -0400
Content-Disposition: inline
In-Reply-To: <20091008135628.GA6616@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 04:56:28PM +0300, Eduardo Valentin wrote:
> On Thu, Oct 08, 2009 at 03:43:33PM +0200, Mark Brown wrote:

> > Similar comments to the previous patch apply to this driver - regulator
> > usage should be unconditional, error messages should not be split over
> > multiple lines and you should represent all the supplies separately (it
> > looks like there's both VDD and CPVSS required here, for example) to
> > avoid future surprises.

> Yeah. The idea here was to keep driver running even if regulators
> are not properly set in board files. Maybe those in which the regulator
> is always on. That's why I wrote it with "nicely" message.

The issue is that this doesn't actually end up increasing the system
robustness since in some systems the regulator control will be required
and the failures can be non-obvious, such as having a shared regulator
powered off at run time due to other system activity.  A misconfigured
regulator supply that stops probe is relatively easy to diagnose and fix
compared to potential silent interactions with other subsystems.

It's simple enough to set up a fixed voltage regulator in the board for
any supplies that don't have soft regulators.
