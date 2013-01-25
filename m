From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap4: clock data: Add missing clkdm association
 for dpll_usb
Date: Fri, 25 Jan 2013 08:10:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301250810090.471@utopia.booyaka.com>
References: <1359095795-9538-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41376 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab3AYIKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 03:10:24 -0500
In-Reply-To: <1359095795-9538-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 25 Jan 2013, Rajendra Nayak wrote:

> dpll_usb needs the clkdm association so the clkdm can be
> turned on before a relock. All other dplls for omap4 belong
> to the ALWON (always on) domain.
> 
> The association was present as part of the older data file
> (clock44xx_data.c) but looks like was accidently dropped with
> the common clk convertion.

Thanks, queued for v3.8-rc fixes.

- Paul

