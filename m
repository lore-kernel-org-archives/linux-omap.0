From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 0/2] OMAP3:PM:SR Refactor
Date: Thu,  1 Oct 2009 19:31:03 -0500
Message-ID: <1254443465-13006-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43357 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZJBAbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 20:31:03 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n920V6o0029517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Oct 2009 19:31:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

Hi,
Smart Reflex sequencing recommendation has improved
in recent times and presents an opportunity to refactor
the code to add in understanding that we have of the
system. The patch set replaces smartreflex.c with a
new revision.

This revision is meant to be RFC due to the nature of
intrusive changes done

Nishanth Menon (2):
  OMAP3:PM:SR: prepare: remove old SR code
  OMAP3:PM:SR: SmartReflex Refactor Rev2.0

 arch/arm/mach-omap2/resource34xx.c |    8 +-
 arch/arm/mach-omap2/smartreflex.c  | 1899 +++++++++++++++++++++---------------
 arch/arm/mach-omap2/smartreflex.h  |  241 +++---
 arch/arm/plat-omap/Kconfig         |   18 +-
 4 files changed, 1249 insertions(+), 917 deletions(-)

Regards,
Nishanth Menon
