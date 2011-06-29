From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/9] PRCM chain interrupt handling
Date: Wed, 29 Jun 2011 12:04:54 +0300
Message-ID: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45681 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab1F2JFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:12 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95BoP031262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:12 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95BQC001776
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:11 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95Bid009004
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:11 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sorry for the delay, I had still some problems with the OMAP3 wakeup handling
with this set from suspend, but now this one works again. This set has been
tested on OMAP3 beagleboard, with suspend and cpuidle, with and without
off-mode. Appears to be working in all cases.

Main differences between previous version of the set:
- OMAP3 wakeup clearing moved back to PRCM interrupt (due to request)
  This caused problems with wakeup from suspend, and was fixed with patch #9
- PAD checks use now omap mux code
- PAD wakeups are enabled automatically by hwmod code for defined pads
- All other comments received for previous set should be taken care of
  (hopefully I didn't forget anything)

This patch set contains a number of testing purposes patches that should
probably not be integrated (tagged as TEMP.) They are mainly provided as
test setup for proof of consept.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

