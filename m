From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: gpmc: Print error message in set_gpmc_timing_reg()
Date: Wed, 29 Oct 2014 10:50:21 +0200
Message-ID: <5450AA4D.9040708@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com> <1413895309-9152-2-git-send-email-rogerq@ti.com> <20141028222349.GV2542@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58871 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630AbaJ2Iuc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2014 04:50:32 -0400
In-Reply-To: <20141028222349.GV2542@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

On 10/29/2014 12:23 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141021 05:43]:
>> Simplify set_gpmc_timing_reg() and always print error message
>> if the requested timing cannot be achieved due to a too fast
>> GPMC functional clock, irrespective if whether DEBUG is defined
>> or not. This should help us debug timing configuration issues,
>> which were otherwise simply not being displayed in the kernel log.
> 
> I think some newer versions of GPMC have a divider in the
> GPMC_CONFIG regs somewhere but we're not currently using it.
> Probably does not affect this patch, just FYI.

Right, we don't use it. In the future it could be a possibility that the GPMC
driver scales the clock as necessary by using the GPMC_FCLK divider
to accommodate slower devices. But then again, who needs slower devices? ;)

cheers,
-roger
