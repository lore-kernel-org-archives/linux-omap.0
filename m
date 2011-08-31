From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 0/4] omap smps regulator driver
Date: Wed, 31 Aug 2011 18:11:14 +0300
Message-ID: <1314803478-15634-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756514Ab1HaPLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 11:11:47 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7VFBko2024632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:46 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p7VFBkKa025310
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:46 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7VFBk0Q023820
	for <linux-omap@vger.kernel.org>; Wed, 31 Aug 2011 10:11:46 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Changes compared to previous version of this set:

- dropped stub header file patch as it is integrated to voltm branch already
- PATCH 1:
  * fixed section mismatch
  * changed consumer supply naming to match with omap PM code better
  * refreshed so that it applies cleanly on latest codebase
- PATCH 2:
  * new patch, needed for mapping from voltagedomains to processor devices
    (e.g. core voltdm -> l3_main processor device on OMAP4)
- PATCH 3:
  * now uses sane names for supply devices, see patch 2
- PATCH 4:
  * fixed opp hacking not to touch hwmod internals

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

