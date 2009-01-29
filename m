From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP3: update omap_chip flags;
	mark USBTLL SAR for ES3.1 only
Date: Thu, 29 Jan 2009 02:12:03 -0700
Message-ID: <20090129090821.24256.46439.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33562 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZA2JQP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 04:16:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

this series marks USBTLL SAR as being available on ES3.1 and beyond only, 
per 

   http://marc.info/?l=linux-arm-kernel&m=123319614808833&w=2

To do this, the omap_chip flags had to be updated.  Now, ES2+ features
are marked as CHIP_GE_OMAP3430ES2.  ES3.1+ features are similarly marked
as CHIP_GE_OMAP3430ES3_1.

Tested on ES2.1 Beagle.  Further testing on ES3+ boards is very welcome.

---

Paul Walmsley (2):
      OMAP3 powerdomains: make USBTLL SAR only available on ES3.1 and beyond
      OMAP3: update ES level flags to discriminate between post-ES2 revisions


 arch/arm/mach-omap2/clockdomains.h     |    6 +++---
 arch/arm/mach-omap2/id.c               |    7 ++++++-
 arch/arm/mach-omap2/powerdomains.h     |    4 ++--
 arch/arm/mach-omap2/powerdomains34xx.h |   16 +++++++++-------
 arch/arm/plat-omap/include/mach/cpu.h  |   26 ++++++++++++++++++++------
 5 files changed, 40 insertions(+), 19 deletions(-)


