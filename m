From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v2] ARM: OMAP4/highbank: Flush L2 cache before disabling
Date: Fri, 4 Oct 2013 18:08:46 -0400
Message-ID: <524F3C6E.4070700@ti.com>
References: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58990 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab3JDWJ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Oct 2013 18:09:26 -0400
In-Reply-To: <1380920277-31622-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Rob Herring <rob.herring@calxeda.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Friday 04 October 2013 04:57 PM, Taras Kondratiuk wrote:
> Kexec disables outer cache before jumping to reboot code, but it doesn't
> flush it explicitly. Flush is done implicitly inside of l2x0_disable().
> But some SoC's override default .disable handler and don't flush cache.
> This may lead to a corrupted memory during Kexec reboot on these platforms.
> 
> This patch adds cache flush inside of OMAP4 and Highbank outer_cache.disable()
> handlers to make it consistent with default l2x0_disable().
> Also it removes redundant outer_flush_all() call just before outer_disable().
> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
> v2: Make the fix specific to platforms that don't use l2x0_disable().
> v1: https://patchwork.kernel.org/patch/2974431/
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

