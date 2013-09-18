From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: DRA7: realtime_counter: Add ratio registers for
 20MHZ sys-clk frequency
Date: Wed, 18 Sep 2013 09:24:30 -0400
Message-ID: <5239A98E.3060908@ti.com>
References: <1379503211-26229-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35663 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab3IRNYy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Sep 2013 09:24:54 -0400
In-Reply-To: <1379503211-26229-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rnayak@ti.com, tony@atomide.com

On Wednesday 18 September 2013 07:20 AM, Sricharan R wrote:
> The real time counter also called master counter, is a free-running
> counter. It produces the count used by the CPU local timer peripherals
> in the MPU cluster. The timer counts at a rate of 6.144 MHz.
> 
> The ratio registers are missing for a sys-clk of 20MHZ which is used
> by DRA7 socs. So because of this, the counter was getting wrongly
> programmed for a sys-clk of 38.4Mhz(default). So adding the ratio
> registers for 20MHZ sys-clk.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>



