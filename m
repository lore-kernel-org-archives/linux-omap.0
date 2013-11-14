From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V4 0/3] ARM: DTS: DRA7: Updates for adding crossbar device
Date: Thu, 14 Nov 2013 09:23:36 -0500
Message-ID: <5284DCE8.9080800@ti.com>
References: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38742 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab3KNOY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Nov 2013 09:24:26 -0500
In-Reply-To: <1384431928-2328-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, rob.herring@calxeda.com, nm@ti.com, bcousson@baylibre.com

On Thursday 14 November 2013 07:25 AM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the interrupt
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt controllers are preceded by an
> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
> requests to the controller inputs.
> 
> The driver support for the same was added here.
> 	http://marc.info/?l=linux-omap&m=138443167321614&w=2
> 
> The dts file update to support the crossbar device and convert
> peripheral irq numbers to crossbar number are added here.
> This series was originally a part of the series [1] and now split
> to keep the DTS updates separately as per comments from
> Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Applied this series on top of
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
>   for_3.13/dts
> 
> [1] http://www.kernelhub.org/?msg=356470&p=2
> 
> Sricharan R (3):
>   ARM: DTS: DRA: Add crossbar device binding
>   ARM: DTS: DRA: Replace peripheral interrupt numbers with crossbar
>     inputs
>   ARM: DTS: DRA7: Add routable-irqs property for gic node
> 
For entire series,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

