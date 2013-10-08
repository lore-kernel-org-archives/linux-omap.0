From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7: realtime_counter: Add ratio registers for
 20MHZ sys-clk frequency
Date: Tue, 8 Oct 2013 14:27:18 -0700
Message-ID: <20131008212718.GS8313@atomide.com>
References: <1379503211-26229-1-git-send-email-r.sricharan@ti.com>
 <5239A98E.3060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39783 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab3JHV1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 17:27:22 -0400
Content-Disposition: inline
In-Reply-To: <5239A98E.3060908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Sricharan R <r.sricharan@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rnayak@ti.com

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130918 06:32]:
> On Wednesday 18 September 2013 07:20 AM, Sricharan R wrote:
> > The real time counter also called master counter, is a free-running
> > counter. It produces the count used by the CPU local timer peripherals
> > in the MPU cluster. The timer counts at a rate of 6.144 MHz.
> > 
> > The ratio registers are missing for a sys-clk of 20MHZ which is used
> > by DRA7 socs. So because of this, the counter was getting wrongly
> > programmed for a sys-clk of 38.4Mhz(default). So adding the ratio
> > registers for 20MHZ sys-clk.
> > 
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Applying into omap-for-v3.13/soc thanks.

Tony
