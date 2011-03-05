From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH V2 0/3]: OMAP4: Update OPP Table and Voltage Rail Values
Date: Sat,  5 Mar 2011 15:20:21 +0530
Message-ID: <1299318621-21280-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1CEJui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 04:50:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Shweta Gulati <shweta.gulati@ti.com>

The Series Updates OPP Table for MPU, add OPP enteries
for IVA and update Voltage Rail values for MPU/IVA.

It is based on the Patch which replaces
Voltage values with Macros, Submitted by 
Nishanth Menon 
https://patchwork.kernel.org/patch/607541/

Branch: pm-core

Tested on OMAP4430 SDP.

V2:
Rebased on pm-core and incorporated
comments from Nishanth Menon. 

Shweta Gulati (3):
  OMAP4: Enable 800 MHz and 1 GHz OPP for OMAP4.
  OMAP4: Update Voltage Rail Values for MPU/IVA
  OMAP4: Add IVA OPP enteries.

 arch/arm/mach-omap2/opp4xxx_data.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

