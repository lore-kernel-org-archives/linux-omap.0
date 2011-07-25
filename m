From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 00/11] PRCM chain handler
Date: Mon, 25 Jul 2011 19:36:00 +0300
Message-ID: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55954 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab1GYQg3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 12:36:29 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6PGaS1t016106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:28 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6PGaSAg007434
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:28 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6PGaR7M009173
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:28 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Changes compared to previous set:
- moved OMAP3/OMAP4 specific code under prmXXXX.c files
- dropped most of the event definitions for now, and just left
  wkup and io events in
- PRCM events are now defined as a common struct under prcm.c
- moved mux handling routines from omap_hwmod.c to mux.c
- some other minor tweaks based on received comments

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

