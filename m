From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: omap3 cpuidle interrupt latency
Date: Sun, 1 Mar 2009 12:18:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0788@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301CBEA0787@dbde02.ent.ti.com>,<13B9B4C6EF24D648824FF11BE8967162037B4D1787@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59618 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbZCAGwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2009 01:52:17 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n216q9Te015989
	for <linux-omap@vger.kernel.org>; Sun, 1 Mar 2009 00:52:15 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n216q8N9023476
	for <linux-omap@vger.kernel.org>; Sun, 1 Mar 2009 12:22:08 +0530 (IST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162037B4D1787@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

It would be nice if this device could dynamically set constraints (say by using a short kernel timer during activity or set/remove pm_qos latency) or the prediction aspect of cpuidle could be improved using rules feed from things like interrupt source.

[Romit] I was thinking that in the irq handler we should add a requirement via the pm_qos or via the constraint framework (not sure if linux-omap has this) and set some kind of a timer (the idea is to keep arming the timer for clustered or rather closely spaced irq instances). If after a while the timer expires we release the latency req. This way perhaps we can handle the latency problem. Again, I am not sure why the menu governor only looks into the PM_QOS_CPU_DMA_LATENCY class only. I was thinking that it should look into other classes as well.

Thanks,
-Romit