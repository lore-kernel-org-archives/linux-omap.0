From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP4/Panda: u-boot upgrade v2012.04.01 -> v2012.10 breaks RTC
 wakeups
Date: Tue, 6 Nov 2012 18:53:15 -0600
Message-ID: <5099B0FB.3060203@ti.com>
References: <87obja9r3x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35581 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320Ab2KGAxW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 19:53:22 -0500
In-Reply-To: <87obja9r3x.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: u-boot@lists.denx.de, linux-omap <linux-omap@vger.kernel.org>, trini@ti.com, R Sricharan <r.sricharan@ti.com>

+ Sricharan,

On Tuesday 06 November 2012 06:46 PM, Kevin Hilman wrote:
> Hello,
>
> I just noticed that the kernel wakeup from suspend using RTC is broken
> after I upgraded u-boot from v2012.04.01 to v2012.10 on my
> OMAP4430/Panda and OMAP4460/Panda-ES.
>
> I haven't isolated the cause yet, but am hoping someone might have a
> pointer about where to start digging.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

