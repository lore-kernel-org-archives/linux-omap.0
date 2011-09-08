From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 0/9] PRCM chain handler
Date: Thu, 8 Sep 2011 18:22:15 +0300
Message-ID: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47216 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388Ab1IHPWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:35 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

Hello,

This is a preliminary review set for the PRCM chain handler driver work.
This set is still missing the PRM hwmod interaction, which should replace
patches 5 and 6. I am planning to post a new series as soon as this part
is done (waiting for a little bit of help from Paul here.) Anyway, couple
of highlights about this code here compared to previous set:

- PRCM chain handler is now moved to a new PRM driver
- Suspend disables IO chain event, and it is enabled at ->complete
  PM callback, triggering IO chain processing at this point
- OMAP3 PM code interrupt handler is split to two parts, wkup and io

Applies on top of PM branch, so far tested on OMAP3 beagle.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

