From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/09] OMAP PM interface implementation using Shared resource f/w
Date: Tue, 8 Jul 2008 17:09:18 +0530
Message-ID: <030701c8e0ef$42440a20$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49316 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbYGHLj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:39:29 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m68BdK0x021801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 06:39:27 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m68BdIxF005245
	for <linux-omap@vger.kernel.org>; Tue, 8 Jul 2008 17:09:19 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The patches which follow implement the API's defined by Paul Walmsley as part of the 
OMAP PM Interface on OMAP3430sdp. 
Shared resource f/w is used for the underlying implementation.

The following resources are modeled
1) MPU/CORE latency resources
2) Power Domain latency resources (One for each Power domain)
3) OPP/Freq resources (For DVFS)

The below API from the OMAP PM interface is yet to be implemented.
void omap_pm_set_min_bus_tput(struct device *dev, struct bus_type *bus,
                                    unsigned long r)

regards,
Rajendra

