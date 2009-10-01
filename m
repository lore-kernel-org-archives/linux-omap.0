From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 0/1] OMAP3: PM: Functions to get freq from opp and vice-versa
Date: Thu,  1 Oct 2009 23:32:58 +0530
Message-ID: <1254420178-4721-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57622 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbZJASDA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Oct 2009 14:03:00 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n91I31pD012952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Oct 2009 13:03:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch takes care of the comments from Kevin [1].

In addition, it fixes:

1) Simple typos
     const struct omap_opp_table omap3_l3_opp_table = {
    -       VDD1_OPP1,
    -       VDD1_OPP3,
    +       VDD2_OPP1,
    +       VDD2_OPP3,
            omap3_l3_rate_table
 
2) Lines overflowing 80 chars
    -int opp_to_freq(unsigned long* freq, const struct omap_opp_table* table, u8 opp);
    -int freq_to_opp(u8* opp, const struct omap_opp_table* table, unsigned long freq);
    +int opp_to_freq(unsigned long* freq,
    +               const struct omap_opp_table* table,
    +               u8 opp);
    +
    +int freq_to_opp(u8* opp,
    +               const struct omap_opp_table* table,
    +               unsigned long freq);
    +


  [1] http://marc.info/?l=linux-omap&m=125433466225276&w=2

Sanjeev Premi (1):
  OMAP3: PM: Functions to get freq from opp and vice-versa

 arch/arm/mach-omap2/omap3-opp.h           |   42 +++------------------
 arch/arm/mach-omap2/pm.c                  |   49 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |   57 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/omap-pm.h |   22 +++++++++++
 4 files changed, 134 insertions(+), 36 deletions(-)

