From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot address/mode
 control
Date: Mon, 11 Oct 2010 15:35:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010111519410.16871@utopia.booyaka.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain> <20101011203710.24425.94685.stgit@twilight.localdomain> <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com> <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
 <20101011211616.GE25462@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39758 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab0JKVf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 17:35:26 -0400
In-Reply-To: <20101011211616.GE25462@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, fernando.lugo@ti.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

On Mon, 11 Oct 2010, Tony Lindgren wrote:

> Would be nice to get the dspbridge into working shape. Sounds we still
> need the following:
> 
> - memblock fixes
> - this series to fix the control module related issues
> - platform data for the boards
> 
> Is that all, or are we also missing something else?

A few other things should be done also.

1. Most of the code in drivers/staging/tidspbridge/code/tiomap3430.c in 
the bridge_brd_monitor(), bridge_brd_start(), and bridge_brd_stop() should 
be moved into a file in arch/arm/mach-omap2.  The DSPBridge driver should 
call those functions (to reset the DSP, start it, etc.) through 
platform_data function pointers.  Once that happens, patch 3 of the 
control module-related series would not be needed, since that code would 
be in arch/arm/mach-omap2 anyway.

2. The direct CM/PRM/RM register access should be removed from that 
arch/arm/mach-omap2 code.  That should be handled directly by the 
clock/hwmod/whatever code.

3. DSPBridge should be converted to use PM runtime, and the 
arch/arm/mach-omap2 portion should use omap_device, omap_hwmod, etc.


- Paul
