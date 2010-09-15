From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 5/6] OMAP2PLUS: WDT: use omap_device_build for
 device registration
Date: Wed, 15 Sep 2010 10:52:49 -0700
Message-ID: <20100915175248.GC4174@atomide.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
 <1284528403-6494-6-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53412 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0IORwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:52:54 -0400
Content-Disposition: inline
In-Reply-To: <1284528403-6494-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org

* Varadarajan, Charulatha <charu@ti.com> [100914 22:18]:
> Use omap_device_build API instead of platform_device_register for
> watchdog timer device registration.
> 
> For OMAP2PLUS chips, the device specific data defined in centralized
> hwmod database will be used.

<snip>

>  static void omap_init_wdt(void)
>  {
> -	if (cpu_is_omap16xx())
> -		wdt_resources[0].start = 0xfffeb000;
> -	else if (cpu_is_omap2420())
> -		wdt_resources[0].start = 0x48022000; /* WDT2 */
> -	else if (cpu_is_omap2430())
> -		wdt_resources[0].start = 0x49016000; /* WDT2 */
> -	else if (cpu_is_omap343x())
> -		wdt_resources[0].start = 0x48314000; /* WDT2 */
> -	else if (cpu_is_omap44xx())
> -		wdt_resources[0].start = 0x4a314000;
> -	else
> -		return;
> -
> -	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
> -
> -	(void) platform_device_register(&omap_wdt_device);
> +	if (cpu_class_is_omap2())
> +		omap2_init_wdt();
> +	else if (cpu_is_omap16xx())
> +		(void) platform_device_register(&omap1_wdt_device);
> +	return;
>  }
>  #else
>  static inline void omap_init_wdt(void) {}

Please just split this into separate omap_init_wdt functions
under mach-omap1 and mach-omap2. Then set them up with
subsys_initcall and make sure you return early from the
subsys_initcall if the platform is not the right one.

Tony
