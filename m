From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 16:44:59 +0530
Message-ID: <4B56E5B3.8070303@ti.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35745 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab0ATLPM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 06:15:12 -0500
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
NAK also for the following  non-working kernel (smartreflex without cpufreq).
