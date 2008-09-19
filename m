From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] watchdog: introduce platform_data and remove cpu conditional code
Date: Fri, 19 Sep 2008 20:04:32 +0100
Message-ID: <20080919190431.GA9675@flint.arm.linux.org.uk>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-3-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-4-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-5-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-6-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58766 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYISTEy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 15:04:54 -0400
Content-Disposition: inline
In-Reply-To: <1221820359-8943-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

On Fri, Sep 19, 2008 at 01:32:39PM +0300, Felipe Balbi wrote:
> @@ -469,17 +515,26 @@ static struct platform_device omap_wdt_device = {
>  
>  static void omap_init_wdt(void)
>  {
> -	if (cpu_is_omap16xx())
> +	if (cpu_is_omap16xx()) {
> +		omap_wdt_pdata.fck = "armwdt_ck";
>  		wdt_resources[0].start = 0xfffeb000;
> -	else if (cpu_is_omap2420())
> +	} else if (cpu_is_omap2420()) {
> +		omap_wdt_pdata.fck = "mpu_wdt_ick";
> +		omap_wdt_pdata.ick = "mpu_wdt_fck";

What happened to leaving this stuff inside omap_wdt.c as I said
during the previous review?  I really don't want to see such cleanups
when the real answer is to fix the OMAP clock API implementation.  It
just makes for more unnecessary noise when doing this, and then yet more
noise when we fix the OMAP clock API.

Please get rid of this and leave the clock naming crap inside omap_wdt.c.
