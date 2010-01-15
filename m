From: Romit Dasgupta <romit@ti.com>
Subject: [PM-WIP-OPP] [PATCH 0/2]: OPP layer changes (introducing enum for
 OPP types and returning NULL on failure from some OPP APIs)
Date: Fri, 15 Jan 2010 16:32:51 +0530
Message-ID: <1263553371.3490.40.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41518 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847Ab0AOLC6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 06:02:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: nm@ti.com, linux-omap@vger.kernel.org


       Based on the discussion in the mailing list, I have taken some
suggestions and am reposting the patch. In this two part patchset:

a) the first patch introduces a new enum type for identifying different
OPP types. This helps in encapsulating the actual pointers to the
respective OPP lists inside the OPP layer itself. One can now interact
with the OPP layer by passing the appropriate OPP enum type instead of
the actual pointer to the OPP list.

b) the second patch is for the OPP layer to return NULL pointer (instead
of ERR_PTR) when the return type of the API is struct omap_opp *

Signed-off-by: Romit Dasgupta <romit@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c          |   15 --
 arch/arm/mach-omap2/resource34xx.c    |   86 ++++++----------
 arch/arm/mach-omap2/smartreflex.c     |   33 +-----
 arch/arm/plat-omap/common.c           |    6 -
 arch/arm/plat-omap/cpu-omap.c         |   12 +-
 arch/arm/plat-omap/include/plat/opp.h |   58 +++++-----
 arch/arm/plat-omap/omap-pm-noop.c     |    4 
 arch/arm/plat-omap/omap-pm-srf.c      |    4 
 arch/arm/plat-omap/opp.c              |  127 ++++++++++++++++--------
 9 files changed, 170 insertions(+), 175 deletions(-)


