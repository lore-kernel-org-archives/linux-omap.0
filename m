From: Sanjeev Premi <premi@ti.com>
Subject: [RFC 0/3] Support TPS65023 with AM35xx
Date: Wed, 23 Feb 2011 23:28:30 +0530
Message-ID: <1298483913-20344-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41183 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab1BWR6m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 12:58:42 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NHwd4w032179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 11:58:41 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Intent of this series is to solicit feedback on
on adding basic support for AM3517 and TPS65023.

This is definitely not the complete support, but
wanted to get early comments while i continue to
work.

Sanjeev Premi (3):
  omap: voltage: Allow custom vp_init() implementation
  am35xx: voltage: Add basic initialization
  am35xx: pm: Hook-up with TPS65023

 arch/arm/mach-omap2/am3517_tps.c |   96 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.c    |   51 +++++++++++++++++++-
 2 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/am3517_tps.c

-- 
1.7.2.2

