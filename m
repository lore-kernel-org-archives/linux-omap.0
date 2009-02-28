From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3 cpuidle interrupt latency
Date: Sat, 28 Feb 2009 23:22:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CBF74DF9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbZB1RxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Feb 2009 12:53:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1SHr1dj021656
	for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2009 11:53:07 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1SHr0pJ005274
	for <linux-omap@vger.kernel.org>; Sat, 28 Feb 2009 23:23:01 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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

