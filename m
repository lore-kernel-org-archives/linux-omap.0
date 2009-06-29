From: Jean Pihet <jpihet@mvista.com>
Subject: get_irq_regs() from soft IRQ
Date: Mon, 29 Jun 2009 16:31:18 +0200
Message-ID: <200906291631.19562.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:37434 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbZF2Oba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 10:31:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, oprofile-list@lists.sourceforge.net

Hi,

I am trying to get the latest IRQ registers from a timer or a work queue but I 
am running into problems:
- get_irq_regs() returns NULL in some cases, so it is unsuable and even causes 
crash when trying to get the registers values from the returned ptr
- I never get user space registers, only kernel

The use case is that the performance unit (PMNC) of the Cortex A8 has some 
serious bug, in short the performance counters overflow IRQ is to be avoided.
The solution I am implementing is to read and reset the counters from a work 
queue that is triggered by a timer.

Some questions:
- is there a way to get the last 'real' IRQ registers from a timer or work 
queue handler?
- is there some other way to do it?

Any thoughts?

Thanks & regards,
Jean
