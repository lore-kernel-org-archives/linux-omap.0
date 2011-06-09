From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 0/3] PRCM chain interrupt handler
Date: Thu, 9 Jun 2011 16:25:01 +0300
Message-ID: <1307625904-18629-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab1FINZO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:25:14 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p59DPDnZ015241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p59DPDHf016738
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:13 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p59DP2Df020707
	for <linux-omap@vger.kernel.org>; Thu, 9 Jun 2011 08:25:12 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Following set contains PRCM chain interrupt handling for OMAP3/4. Contents
of this set:

- Patch 1 was initially made by Thomas Petazzoni I believe, I made some
  OMAP4 specific fixes on that one and updated this to conform to latest
  kernel APIs. This patch contains the main logic for the PRCM chain
  handling.

- Patch 2 adds a support for chaining PRCM IO wakeup events to interrupts.
  This is accomplished by simply registering pad -> irq relationship and
  launching the interrupt handler from PRCM hardirq with generic_handle_irq().

- Patch 3 is just a hack to enable serial to work with PRCM IO wakeups,
  this should be written properly by someone when the initial framework
  (patch 1 & 2) are okay.

Any comments welcome.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

