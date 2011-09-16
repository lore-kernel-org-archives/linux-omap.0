From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8] 00/16] OMAP PRCM chain handler driver
Date: Fri, 16 Sep 2011 19:05:34 +0300
Message-ID: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57268 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab1IPQG1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:27 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk

Hello,

This patch set is the version 8 for the OMAP PRCM chain interrupt handler.
The driver is providing a chain handler for PRCM interrupt events, which
can be then individually used by different drivers. Currently PRCM interrupt
is owned by the PM core code and it is impossible for other users to listen
to any of the PRCM events. Quite a few of the patches in this set are tagged
as TEMP, they are not meant for integration at this point, but are provided
as FYI for educated users and as a means to test the driver out.

Changes compared to the previous set:

- PRCM chain handler is now a driver of its own
- The driver gets PRCM IP info from omap hwmod and configures itself based
  on this
- Added temporary implementations for OMAP3 and OMAP4 PRM hwmods

Applies on top of Kevin's PM branch.

Testing done:

- platforms used: omap3 beagleboard and omap4430 blaze
- suspend / resume test with retention : ok on both
- cpuidle with retention test : ok on both
- off-mode testing : ok on omap3 (omap4 does not support off-mode yet)

OMAP4 testing was done on top of a custom kernel tree, this patch set
does not work directly for omap4 on mainline.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

