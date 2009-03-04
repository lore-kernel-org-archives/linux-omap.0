From: "Premi, Sanjeev" <premi@ti.com>
Subject: Setting individual GPIO registers
Date: Wed, 4 Mar 2009 21:11:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CC053014@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbZCDPlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 10:41:49 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n24FfghZ009614
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 09:41:47 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n24Fffh3020255
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 21:11:41 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I am trying to get the wakeup event from touchscreen on
omap3evm to bring the EVM out of suspend state.

For my private testing, I have been updating individual
registers & bits in the GPIO registers from function
ads7846_dev_init().

Ideally, I should be using standard GPIO APIs. However,
most of the APIs are static within gpio.c

How can I call functions like gpio_wake_enable(), gpio_unmask_irq()
OR
Is there a function to access interface registers for GPIO banks?

Best regards,
Sanjeev