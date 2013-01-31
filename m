From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: omap4: clock data: Add missing clkdm association
 for dpll_usb
Date: Thu, 31 Jan 2013 16:19:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301311619180.32145@utopia.booyaka.com>
References: <1359632112-9808-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52654 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3AaQTg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 11:19:36 -0500
In-Reply-To: <1359632112-9808-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 31 Jan 2013, Rajendra Nayak wrote:

> dpll_usb needs the clkdm association so the clkdm can be
> turned on before a relock. All other dplls for omap4 belong
> to the ALWON (always on) domain.
> 
> The association was present as part of the older data file
> (clock44xx_data.c) but looks like got accidently dropped with
> the common clk convertion.
> 
> More details of the patch which fixed this up in the older
> data file can be dound here..
> http://www.spinics.net/lists/linux-omap/msg63076.html
> 
> Adding the .clkdm_name as part of the clk_hw_omap struct also
> means a new .init needs to be part of the clk_ops for dpll_usb
> to initialise the clkdm.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for v3.8-rc in place of v1.


- Paul
