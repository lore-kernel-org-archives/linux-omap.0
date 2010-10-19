From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
Date: Tue, 19 Oct 2010 11:06:14 +0200
Message-ID: <20101019090613.GA2736@sortiz-mobl>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
 <1286315819-5906-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31347 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757893Ab0JSJG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:06:27 -0400
Content-Disposition: inline
In-Reply-To: <1286315819-5906-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Hi Manjunath,

On Wed, Oct 06, 2010 at 03:26:59AM +0530, G, Manjunath Kondaiah wrote:
> Fixes following sparse warnings for twl4030 and twl6030 irq files.
> 
> drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq' was not declared. Should it be static?
> drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq' was not declared. Should it be static?
> drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip_irq' was not declared. Should it be static?
> 
> drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq' was not declared. Should it be static?
> drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq' was not declared. Should it be static?
>
Patch applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
