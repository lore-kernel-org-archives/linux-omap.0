From: "Anna, Suman" <s-anna@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP2: fix interrupt number for rng
Date: Wed, 8 Jan 2014 11:31:42 -0600
Message-ID: <52CD8B7E.8000709@ti.com>
References: <1387839579-58292-1-git-send-email-s-anna@ti.com> <20140108002843.GI5074@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35121 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbaAHRbu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jan 2014 12:31:50 -0500
In-Reply-To: <20140108002843.GI5074@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk

Tony,

On 01/07/2014 06:28 PM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [131223 15:01]:
>> The irq data for rng module defined in hwmod data previously
>> missed the OMAP_INTC_START relative offset, so the interrupt
>> number is probably misconfigured during the DT node addition
>> adjusting for this OMAP_INTC_START. Interrupt #36 is associated
>> with a watchdog timer, so fix the rng module's interrupt to the
>> appropriate interrupt #52.
>
> Hmm indeed as the .dtsi files were generated from the hwmod
> data. Are the other interrupts fixed earlier OK?

GPMC DT nodes are already configured properly, the ISP MMU one needs 
fixing. I left it out to be fixed as part of Florian's patch that 
corrects the ISP MMU DT node. There is no IVA MMU DT node yet, and will 
add the correct number when we add the DT node.

regards
Suman


