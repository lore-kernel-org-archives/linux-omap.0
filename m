From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 17:22:38 +0530
Message-ID: <4B56EE86.3070909@ti.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com> <4B56E54D.4070304@ti.com> <20100120115116.GF12231@esdhcp037198.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48960 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120Ab0ATLwu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 06:52:50 -0500
In-Reply-To: <20100120115116.GF12231@esdhcp037198.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>>> ---
>>>  arch/arm/mach-omap2/Makefile          |    5 +
>> NAK.  Your kernel will not boot if you build it without CONFIG_CPU_FREQ.
> 
> I guess you mean without CONFIG_CPU_FREQ and SMART_REFLEX
> 

Just without CONFIG_CPU_FREQ. Did it boot?
