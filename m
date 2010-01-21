From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Thu, 21 Jan 2010 12:46:09 +0530
Message-ID: <4B57FF39.3040607@ti.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com> <4B56E5B3.8070303@ti.com> <20100120115407.GG12231@esdhcp037198.research.nokia.com> <4B56F045.4040708@ti.com> <20100120124052.GH12231@esdhcp037198.research.nokia.com> <4B56FAAF.2070600@ti.com> <20100120124906.GI12231@esdhcp037198.research.nokia.com> <4B56FD06.6040403@ti.com> <20100120142052.GK12231@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab0AUHQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:16:23 -0500
In-Reply-To: <20100120142052.GK12231@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

> Actually, system boots. It does not break the system. What I've tried is:
> 
> - rx51 board
> - omap3_pm_defconfig without CPU_FREQ
> - linux-omap-pm/pm-wip-opp branch + this patch
> 
> System boots, but smartreflex disables itself:
> 
> ...
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Power Management for TI OMAP3.
> SR: OPP rate tables not defined for platform, not enabling SmartReflex
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
> ,..
> 
> But it does not break booting procedure.
> 
> So, I don't see why this would be a reason for doing this compilation fix
> into two steps. Unless you see another issue.
Ok sorry about the misunderstanding then. Its ok from my side. ACKed.
