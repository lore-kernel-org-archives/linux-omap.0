From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/6] PRCM chain handler
Date: Wed, 22 Jun 2011 19:42:08 +0300
Message-ID: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab1FVQmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:42:36 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MGgaOU014095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:36 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5MGgaoD000732
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:36 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgK31011801
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:35 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I was able to test this on OMAP3 beagleboard and got it working properly
after some sweating.

Version 3 changes:
- Changed omap3 PRCM wakeup interrupt handler to be a dummy, wakeup irq
  clearing is now done when we are entering idle. This prevents PRCM
  interrupt hanging in case UART is disabled, and gives probably slightly
  better latencies during wakeup.
- Added console lock protection during uart clock enable / disable
  * prevents nastiness to happen when omap_device wants to print out something
- A few new resume_idle calls added to tty omap-serial

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

