From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: omap3 cpuidle interrupt latency
Date: Sun, 1 Mar 2009 08:55:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0787@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56373 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328AbZCADZj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2009 22:25:39 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n213PUL1006061
	for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2009 21:25:36 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n213PTcg010743
	for <linux-omap@vger.kernel.org>; Sun, 1 Mar 2009 08:55:30 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I think the original code had checks in 3 places but as you say it might have changed in linux-omap. I feel the right way to do this is to add a latency (using pm_qos) so that the CPU idle driver doesn't even attempt deeper idle states. Ideally we should use PM_QOS_NETWORK_LATENCY but the menu governor seems to check only PM_QOS_CPU_DMA_LATENCY class. I am not sure why menu governor does not check the other classes of latency. But for now I think if we add to PM_QOS_CPU_DMA_LATENCY when we detect some network activity and remove latency req after a while of network inactivity. 

Thanks,
-Romit

________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Premi, Sanjeev [premi@ti.com]
Sent: Saturday, February 28, 2009 11:22 PM
To: linux-omap@vger.kernel.org
Subject: omap3 cpuidle interrupt latency

I have noticed large interrupt latency when the cpuidle is enabled.
e.g. response time for ping goes from avg 10-20ms to 800-1000ms.
(I am at HEAD of the 'pm' branch)

The IRQs and FIQs are disabled at the beginning of the function
omap3_enter_idle() but WFI is executed much later in _omap_sram_idle().
In between, there is only one check for pending IRQs - omap_irq_pending()

If any interrupt occurs beyond this point is it considered by the WFI?

To reduce this latency, I am planning to do either/both of thse:
- Add more checks for pending IRQs
- Reduce the time for which the IRQs and FIQs are disabled

Benefits will depend upon the behavior of WFI.

Best regards,
Sanjeev

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

