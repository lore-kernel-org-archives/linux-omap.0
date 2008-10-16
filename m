From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/04] OMAP3 SRF: OMAP PM interface implemented using SRF
Date: Thu, 16 Oct 2008 19:41:36 +0530
Message-ID: <022201c92f99$1a8056d0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbYJPOLq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 10:11:46 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9GEBcnP015773
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 09:11:44 -0500
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9GEBa10024158
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 19:41:37 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set implements the Shared Resource Framework which in turn is used
to implement the OMAP-PM layer API's.

The resources modelled in these patch set are 
1) MPU/CORE latency resources
2) Power Domain latency resources (One for each Power domain)

These patches are validated on OMAP3430SDP and should apply on the pm-20081006 branch.

To use/test the OMAP-PM layer API's please enable the following in menuconfig

System Type---> OMAP PM layer selection (PM layer implemented using SRF)

regards,
Rajendra

