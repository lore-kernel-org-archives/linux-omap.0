From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 0/4] OPP layer: hide OPP implementation details
Date: Fri, 18 Dec 2009 15:05:35 -0800
Message-ID: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41371 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbZLRXFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 18:05:44 -0500
Received: by pzk1 with SMTP id 1so2538284pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 15:05:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

This series continues on top of Paul's OPP cleanup series and aims to
completly hide the OPP layer implementation details.  

To do this, a couple more another accessor 
functions have been added so current SR/SRF code can still function.

The goal here is to allow continued OPP layer cleanup and possibly
alternate implementations to be done in parallel with the ongoing
SR/SRF rework efforts.

Unless I hear some objections, this series will be added onto my
pm-wip-opp branch after some more thorough testing.

Tested on OMAP3EVM, RX51

Changes from v1:
- actually works
- Fix SRF indexing after initial terminators were removed
- dropped opp_find_by_index() in favor of changing SRF remove indexing.

Kevin Hilman (4):
  OMAP OPP: Add accessor function for getting OPP ID.
  OMAP SRF: adjust OPP array access
  OMAP SR/SRF: use OPP API for OPP ID, remove direct access
  OMAP OPP: hide struct omap_opp internals in OPP layer implementation

 arch/arm/mach-omap2/resource34xx.c    |    6 +++---
 arch/arm/mach-omap2/smartreflex.c     |    4 ++--
 arch/arm/plat-omap/include/plat/opp.h |   20 ++------------------
 arch/arm/plat-omap/opp.c              |   24 ++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 23 deletions(-)

