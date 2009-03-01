From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap3 cpuidle interrupt latency
Date: Sat, 28 Feb 2009 22:05:39 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162037B4D1787@dlee02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0787@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59451 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbZCAEFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2009 23:05:46 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2145eTD022672
	for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2009 22:05:45 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2145ea4025617
	for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2009 22:05:40 -0600 (CST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0787@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Part of it is a poor prediction.  A while back, I had hacked in a simple irq time stamp and used a kind of crude running average over all irq sources. Then I added this info into cpuidle for next state prediction. It did improve latency a quite a bit.  Simple idea is irqs might cluster and there is always a little activity after irq.

The effect of this is easily seen on musb driver. It uses some kind of streaming api where data is only sent up after a bunch of irqs have brought in data above some threshold.  CPUidle doesn't take this kind of thing into account well and will choose a poor cstate which causes effective throughput to drop.

I did post some of this code on linux pm.  I did get a response from one power person at Intel.  He indicated that cpuidle wasn't so good at in this aspect and that they were looking at a similar but different approach to the issue.  He didn't like the idea of extra overhead on each irq.  It was pretty minor to me.

It would be nice if this device could dynamically set constraints (say by using a short kernel timer during activity or set/remove pm_qos latency) or the prediction aspect of cpuidle could be improved using rules feed from things like interrupt source.

Regards
Richard W.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Dasgupta, Romit
> Sent: Saturday, February 28, 2009 9:25 PM
> To: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: RE: omap3 cpuidle interrupt latency
>
> I think the original code had checks in 3 places but as you say it might have
> changed in linux-omap. I feel the right way to do this is to add a latency
> (using pm_qos) so that the CPU idle driver doesn't even attempt deeper idle
> states. Ideally we should use PM_QOS_NETWORK_LATENCY but the menu governor
> seems to check only PM_QOS_CPU_DMA_LATENCY class. I am not sure why menu
> governor does not check the other classes of latency. But for now I think if
> we add to PM_QOS_CPU_DMA_LATENCY when we detect some network activity and
> remove latency req after a while of network inactivity.
>
> Thanks,
> -Romit
>
> ________________________________________
> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On
> Behalf Of Premi, Sanjeev [premi@ti.com]
> Sent: Saturday, February 28, 2009 11:22 PM
> To: linux-omap@vger.kernel.org
> Subject: omap3 cpuidle interrupt latency
>
> I have noticed large interrupt latency when the cpuidle is enabled.
> e.g. response time for ping goes from avg 10-20ms to 800-1000ms.
> (I am at HEAD of the 'pm' branch)
>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

