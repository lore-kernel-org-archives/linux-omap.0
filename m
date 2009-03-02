From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: omap3 cpuidle interrupt latency
Date: Mon, 02 Mar 2009 11:46:17 -0800
Message-ID: <873advaet2.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:20663 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbZCBTqW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 14:46:22 -0500
Received: by rv-out-0506.google.com with SMTP id g9so5456915rvb.5
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 11:46:20 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com> (Sanjeev Premi's message of "Sat\, 28 Feb 2009 23\:22\:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

> I have noticed large interrupt latency when the cpuidle is enabled.
> e.g. response time for ping goes from avg 10-20ms to 800-1000ms.
> (I am at HEAD of the 'pm' branch)

Is it interrupt latency in general you are measuring?  or just the
interrupt latency for the smc network driver.  I think what you are
seeing is the result of the SMC IRQ not being configured as a wakeup
source, thus a network interrupt will not wake the system, but you end
up waiting for the next idle timer until the system wakes and handles
the network interrupt.

By default, I don't believe the GPIO interrupt used by the smc is
configured as a wakeup source.  Have you configured that GPIO as a
wakeup source?

Kevin


> The IRQs and FIQs are disabled at the beginning of the function
> omap3_enter_idle() but WFI is executed much later in _omap_sram_idle().
> In between, there is only one check for pending IRQs - omap_irq_pending()
>  
> If any interrupt occurs beyond this point is it considered by the WFI?
>  
> To reduce this latency, I am planning to do either/both of thse:
> - Add more checks for pending IRQs
> - Reduce the time for which the IRQs and FIQs are disabled
>  
> Benefits will depend upon the behavior of WFI.
>  
> Best regards,
> Sanjeev
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
