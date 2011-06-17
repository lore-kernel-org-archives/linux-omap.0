From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 0/3] PRCM chain interrupt handler
Date: Fri, 17 Jun 2011 15:06:25 +0300
Message-ID: <1308312388-3952-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37484 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757934Ab1FQMGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 08:06:34 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5HC6YA1014430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:06:34 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5HC6Xj0023927
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:06:33 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5HC6WRV011489
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:06:33 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This set applies on top of PM branch.

Changes compared to previous set:
- should now apply cleanly
  * removed pm44xx.c changes as the branch does not contain necessary support



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

