From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 0/4] OMAP SMPS regulator driver
Date: Thu, 28 Jul 2011 14:48:55 +0300
Message-ID: <1311853739-18984-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1G1LtN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 07:49:13 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6SBnDw7000759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6SBnDrj021059
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:13 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6SBnCYp015288
	for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 06:49:12 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

This version has following changes:

- does not move voltage.h under plat-omap anymore, instead
  creates a stub voltage.h under plat-omap with minimal support required
- platform device registration is now done from voltage.c, no need
  for board file changes anymore
- Kconfig option does not depend upon TWL core anymore

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

