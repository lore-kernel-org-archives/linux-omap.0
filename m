From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 16:43:17 +0530
Message-ID: <4B56E54D.4070304@ti.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47766 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab0ATLNa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 06:13:30 -0500
In-Reply-To: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "\"Keski-Saari Juha.1 (EXT-Teleca/Helsinki)\"" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.
> 
> With this patch, omap opp layer now has its compilation flags
> bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.
> 
> A new file has been created to contain cpu freq code related to
> OMAP3: cpufreq34xx.c.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/mach-omap2/Makefile          |    5 +
NAK.  Your kernel will not boot if you build it without CONFIG_CPU_FREQ.
