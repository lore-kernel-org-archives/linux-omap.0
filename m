From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 13:51:16 +0200
Message-ID: <20100120115116.GF12231@esdhcp037198.research.nokia.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
 <4B56E54D.4070304@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:33666 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0ATLvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 06:51:39 -0500
Content-Disposition: inline
In-Reply-To: <4B56E54D.4070304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Romit Dasgupta <romit@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Wed, Jan 20, 2010 at 12:13:17PM +0100, ext Romit Dasgupta wrote:
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
> > ---
> >  arch/arm/mach-omap2/Makefile          |    5 +
> NAK.  Your kernel will not boot if you build it without CONFIG_CPU_FREQ.

I guess you mean without CONFIG_CPU_FREQ and SMART_REFLEX

-- 
Eduardo Valentin
