From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 00/11] PRCM chain handler
Date: Tue, 5 Jul 2011 13:27:46 +0300
Message-ID: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab1GEK2H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:28:07 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p65AS6oO018741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:06 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p65AS6ii013803
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:06 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p65AS6HV028399
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:06 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Changes compared to previous version:

- rebased on top of latest PM branch
- sparse interrupt numbering in use (thanks Felipe)
- removed duplicate pad mapping as proposed by Kevin
  * io pad parsing done now in a support function provided by omap_hwmod
  * see patch 4
- using Govindraj's ioring support functions for mux
  * patches 2 + 3 only added as reference and because this set needs those
- tagged a couple of more patches as TEMP, these are just for testing purposes
  * also changed suspend irq disable / enable logic a bit
- generic irq chip used more properly now, dropped most of the support funcs

Tested again on omap3-beagle:
- suspend / resume with retention -> ok
- cpuidle with retention -> ok

Off-mode tested also, kind of works but hangs eventually. This happens with
plain PM branch also, so it is not caused by this set.

On top of commit 40d10207b5389184333bacb786d27036cbcee500 off-mode was
still functional, so it would seem like some late patch has broken something.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

