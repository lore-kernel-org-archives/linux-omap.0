From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: dra7: Add crossbar dt support
Date: Tue, 3 Jun 2014 14:45:49 +0530
Message-ID: <538D9245.2070004@ti.com>
References: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33671 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbaFCJR6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Jun 2014 05:17:58 -0400
In-Reply-To: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, tglx@linutronix.de, linux@arm.linux.org.uk

Hi,

On Tuesday 03 June 2014 02:40 PM, Sricharan R wrote:
> This series introduces DT support for crossbar device and
> changes dra7 peripherals to use crossbar number instead of irq.
>
> This depends on below driver fixes and DMA cleanup series.
Sorry, i meant to say crossbar driver fixes and cleanup series.

Regards,
 Sricharan
> 	http://www.spinics.net/lists/arm-kernel/msg336594.html
>
> R Sricharan (2):
>   ARM: dts: DRA7: Add routable-irqs property for gic node
>   ARM: dts: DRA7: Add crossbar device binding
>
>  arch/arm/boot/dts/dra7.dtsi |  134 ++++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 58 deletions(-)
>

