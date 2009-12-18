From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] OPP layer: hide OPP implementation details
Date: Fri, 18 Dec 2009 09:45:57 -0800
Message-ID: <1261158361-28974-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:53503 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbZLRRqH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:46:07 -0500
Received: by ywh12 with SMTP id 12so3644080ywh.21
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:46:04 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

This series continues on top of Paul's OPP cleanup series and aims to
completly hide the OPP layer implementation details.  

To do this, a couple more temporary (a.k.a already deprecated) helper
functions have been added so current SR/SRF code can still function.

The goal here is to allow continued OPP layer cleanup and possibly
alternate implementations to be done in parallel with the ongoing
SR/SRF rework efforts.

Unless I hear some objections, this series will be added onto my
pm-wip-opp branch after some more thorough testing.

Kevin Hilman (4):
  OMAP OPP: Add accessor function for getting OPP ID.
  OMAP OPP: add helper function to find OPP by index
  OMAP SR/SRF: use OPP API for OPP ID, find by index
  OMAP OPP: hide struct omap_opp internals in OPP layer implementation

 arch/arm/mach-omap2/resource34xx.c    |   14 ++++++++--
 arch/arm/mach-omap2/smartreflex.c     |    4 +-
 arch/arm/plat-omap/include/plat/opp.h |   23 ++++-------------
 arch/arm/plat-omap/opp.c              |   43 +++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 23 deletions(-)

