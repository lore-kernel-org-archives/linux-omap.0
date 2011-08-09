From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib
 implementations
Date: Tue, 9 Aug 2011 10:59:53 -0700
Message-ID: <20110809175953.GA22918@huya.qualcomm.com>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
 <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:6118 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab1HIR7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 13:59:55 -0400
Content-Disposition: inline
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Nicolas Pitre <nico@fluxnic.net>

On Tue, Aug 09, 2011 at 09:08:01AM +0100, Russell King - ARM Linux wrote:
> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-msm/include/mach/gpio.h       |    5 +----

For msm (msm8660):

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
