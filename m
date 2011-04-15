From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 18:04:56 +0200
Message-ID: <4DA86CA8.7090104@atmel.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA85B49.60209@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:18833 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1DOQFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 12:05:23 -0400
In-Reply-To: <4DA85B49.60209@vollmann.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Detlef Vollmann <dv@vollmann.ch>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Le 15/04/2011 16:50, Detlef Vollmann :
> On 04/15/11 15:06, Russell King - ARM Linux wrote:
>> This is work in progress.
> Thanks, very useful.

[..]

>> Another question is whether we should allow multiple SRAM pools or not -
>> this code does allow multiple pools, but so far we only have one pool
>> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
> Having the option to partition the SRAM is probably useful.
> What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
> of SRAM, and you might want to combine them into a single pool.

In fact on at91sam9g20 (and some other at91) you can use the mirroring
of the SRAM until next bank... so you end up with a single pool.

Base @ sram1 base - sram0 size
size = sram 0 size + sram 1 size

Best regards,
-- 
Nicolas Ferre

