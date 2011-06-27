From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 0/6] PRCM chain handler
Date: Mon, 27 Jun 2011 18:02:13 +0300
Message-ID: <1309186933.6148.17.camel@sokoban>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46866 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab1F0PCS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 11:02:18 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Govindraj <govindraj.ti@gmail.com>

Just a heads up on this, to let you know I have not ignored your
comments. :)

I have been doing some re-work / testing on this set based on your
comments, and will hopefully post a new set tomorrow. One of the bigger
changes is that I have changed pad wakeups to use omap_mux and they are
now enabled automatically when omap_hwmod_enable_wakeup /
omap_hwmod_disable_wakeup are called. I am trying to get other changes
in also.

-Tero

On Wed, 2011-06-22 at 18:42 +0200, Kristo, Tero wrote:
> I was able to test this on OMAP3 beagleboard and got it working properly
> after some sweating.
> 
> Version 3 changes:
> - Changed omap3 PRCM wakeup interrupt handler to be a dummy, wakeup irq
>   clearing is now done when we are entering idle. This prevents PRCM
>   interrupt hanging in case UART is disabled, and gives probably slightly
>   better latencies during wakeup.
> - Added console lock protection during uart clock enable / disable
>   * prevents nastiness to happen when omap_device wants to print out something
> - A few new resume_idle calls added to tty omap-serial
> 
> -Tero
> 
> 
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

