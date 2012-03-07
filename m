From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 02/13] gpio/omap: fix wakeup_en register update in
 _set_gpio_wakeup()
Date: Wed, 07 Mar 2012 12:59:18 +0100
Message-ID: <4F574D96.5070306@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> <1331118963-26364-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40742 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944Ab2CGL7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 06:59:24 -0500
Received: by ghrr18 with SMTP id r18so2912835ghr.28
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 03:59:22 -0800 (PST)
In-Reply-To: <1331118963-26364-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 07 March 2012 12:15 PM, Tarun Kanti DebBarma wrote:
> There are two ways through which wakeup_en register can be programmed
> using gpiolib APIs as shown below. It is seen that in the second case
> in _set_gpio_wakeup(), even though bank->suspend_wakeup is updated
> correctly, its value is not programmed in wakeup_en register. Fix this.
> 
> chip.irq_set_type()->gpio_irq_type()->_set_gpio_triggering()->set_gpio_trigger()
> chip.irq_set_wake()->gpio_wake_enable()->_set_gpio_wakeup()
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
