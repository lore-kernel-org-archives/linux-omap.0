From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 13:54:07 +0200
Message-ID: <20100120115407.GG12231@esdhcp037198.research.nokia.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
 <4B56E5B3.8070303@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34315 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab0ATLyS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 06:54:18 -0500
Content-Disposition: inline
In-Reply-To: <4B56E5B3.8070303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Romit Dasgupta <romit@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Wed, Jan 20, 2010 at 12:14:59PM +0100, ext Romit Dasgupta wrote:
> 
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.
> > 
> > With this patch, omap opp layer now has its compilation flags
> > bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.
> > 
> > A new file has been created to contain cpu freq code related to
> > OMAP3: cpufreq34xx.c.
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> NAK also for the following  non-working kernel (smartreflex without cpufreq).

Then this is a problem of dependency with smartreflex and cpufreq. In this case
better to solve this other problem with another patch. This patch is to rip off
cpufreq code from pm34xx, as stated in the above description.

And sorry, I didn't get your boot log (if you intended to put it, as you said
"following non-working kernel"

BR,

-- 
Eduardo Valentin
