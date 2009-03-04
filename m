From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: Setting individual GPIO registers
Date: Wed, 4 Mar 2009 22:32:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC053063@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC053014@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54622 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbZCDRCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 12:02:46 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n24H2cXd013667
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 11:02:44 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n24H2bSP029879
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 22:32:37 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC053014@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Wednesday, March 04, 2009 9:12 PM
> To: linux-omap@vger.kernel.org
> Subject: Setting individual GPIO registers
> 
> I am trying to get the wakeup event from touchscreen on
> omap3evm to bring the EVM out of suspend state.
> 
> For my private testing, I have been updating individual
> registers & bits in the GPIO registers from function
> ads7846_dev_init().
> 
> Ideally, I should be using standard GPIO APIs. However,
> most of the APIs are static within gpio.c
> 
> How can I call functions like gpio_wake_enable(), gpio_unmask_irq()
> OR
> Is there a function to access interface registers for GPIO banks?
> 

Did you mean waking up OMAP3 via touch screen from CORE OFF mode ? Please note that PER domain GPIOs will be not be active during OFF mode (GPIO2-6). Wakeup capability is limited for wakeup domain GPIOs as well. 

>From TRM

"Only gpio_1, gpio_9, gpio_10, gpio_11, gpio_30 and gpio_31 can be used to generate a direct wakeup event. The other GPIO1 pins cannot be used to generate a direct wake-up event because they are connected to the device I/O
pad logic in the CORE power domain (VDD2). When the CORE power domain is off, the VDD2-supplied I/O pins of the GPIO1 module cannot generate a wake-up event"

Enable wakeup in I/O PAD corresponding to TS_IRQ line. On wakeup you will get a PRCM interrupt.

Regards,
Pratheesh
 
