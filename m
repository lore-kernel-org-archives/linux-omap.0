From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 00/11] voltage domain cleanup
Date: Wed, 5 Oct 2011 20:17:00 +0300
Message-ID: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40243 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934481Ab1JERRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 13:17:31 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p95HHV3i003785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:31 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p95HHU99003282
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:30 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p95HHU8c001660
	for <linux-omap@vger.kernel.org>; Wed, 5 Oct 2011 12:17:30 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This set contains following changes compared to v2:

- split into several patches for easier handling
- added a couple of patches from Nishanth Menon (01, 05)
- vddmin / vddmax are now defined for both pmic and omap, max of vddmin and
  min of vddmax is used
- clock setup / pmic setup times calculated from lp params (patch 10, 11)

Todo:
- figure out a way to configure ramp times based on sleep mode (callbacks
  from pm34xx / pm44xx files?)
- add oscillator and pmic ramp times for omap3
- add oscillator ramp times for omap4

Misc notes:
- Applies on top of Kevin's old pm-wip/voltdm branch
- Tested on OMAP3 beagle

-Tero


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

