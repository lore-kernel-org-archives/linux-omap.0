From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine specific sources
Date: Mon, 26 Sep 2011 11:45:58 -0700
Message-ID: <87fwjjcfbt.fsf@ti.com>
References: <hvaibhav@ti.com>
	<1316529142-27564-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:47700 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752375Ab1IZSqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 14:46:04 -0400
Received: by gwj17 with SMTP id 17so3150902gwj.38
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 11:46:02 -0700 (PDT)
In-Reply-To: <1316529142-27564-3-git-send-email-hvaibhav@ti.com>
	(hvaibhav@ti.com's message of "Tue, 20 Sep 2011 20:02:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

<hvaibhav@ti.com> writes:

> From: Afzal Mohammed <afzal@ti.com>
>
> This patch updates the common machine specific source files for
> support for AM33XX/AM335x with cpu type, macros for identification of
> AM33XX/AM335X device.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

[...]

> @@ -3576,7 +3579,8 @@ int __init omap3xxx_clk_init(void)
>  	 * Lock DPLL5 -- here only until other device init code can
>  	 * handle this
>  	 */
> -	if (!cpu_is_ti816x() && (omap_rev() >= OMAP3430_REV_ES2_0))
> +	if (!cpu_is_ti816x() && !cpu_is_am33xx() &&
> +			(omap_rev() >= OMAP3430_REV_ES2_0))
>  		omap3_clk_lock_dpll5();

This is getting ugly.  

Instead of continuing to expand this if-list, I think it's time for a
new feature-flag for whether or not an SoC has DPLL5 instead.

Kevin

