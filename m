From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V4 05/12] ARM: OMAP2+: HWMOD: Correct timer device
 attributes
Date: Wed, 13 Jun 2012 17:53:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206131752280.30212@utopia.booyaka.com>
References: <1338917700-29174-1-git-send-email-jon-hunter@ti.com> <1338917700-29174-6-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53518 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028Ab2FMXxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 19:53:17 -0400
In-Reply-To: <1338917700-29174-6-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Tue, 5 Jun 2012, Jon Hunter wrote:

> Fix the following issues with the timer device attributes for OMAP2+ devices:
> 
> 1. For OMAP24xx devices, timers 2-8 have the ALWAYS-ON attribute indicating
>    that these timers are in an ALWAYS-ON power domain. This is not the case
>    only timer1 is in an ALWAYS-ON power domain.
> 2. For OMAP3xxx devices, timers 2-7 have the ALWAYS-ON attribute indicating
>    that these timers are in an ALWAYS-ON power domain. This is not the case
>    only timer1 and timer12 are in an ALWAYS-ON power domain.
> 3. For OMAP3xxx devices, timer12 does not have the ALWAYS-ON attribute but
>    is in an always-on power domain.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks Jon.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
