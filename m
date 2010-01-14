From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v9 0/4] OMAP: McBSP: Use register cache
Date: Thu, 14 Jan 2010 16:58:29 +0100
Message-ID: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39748 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab0ANP6S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jan 2010 10:58:18 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Change the way McBSP registers are maintained: store values written to the
device in a cache in order to make use of those cached values when
convenient.

This could help for developing the McBSP context save/restore features, as
well as solve the problem of possible register corruption, experienced on
OMAP1510 based Amstrad Delta board at least.

Series created against linux-omap for-next, commit
fb7380d70e041e4b3892f6b19dff7efb609d15a4 (2.6.33-rc3+ dated 2010-01-11).
All patches tested on OMAP1510 based Amstrad Delta and compile-tested using
omap_3430sdp_defconfig at least.

Latest changes:
- patch 3: allow for using the mcbsp->free as a guard for cache access,
	   adpot for fixed error handling in omap_mcbsp_request().
- patch 5: dropped
- all: refresh against latest l-o for-next tree.

Janusz Krzysztofik (4):
	OMAP: McBSP: Use macros for all register read/write operations
	OMAP: McBSP: Modify macros/functions API for easy cache access
	OMAP: McBSP: Introduce caching in register write operations
	OMAP: McBSP: Use cache when modifying individual register bits

 arch/arm/mach-omap1/mcbsp.c             |   16 -
 arch/arm/mach-omap2/mcbsp.c             |   20 +
 arch/arm/plat-omap/include/plat/mcbsp.h |    3
 arch/arm/plat-omap/mcbsp.c              |  480 
++++++++++++++++----------------
 4 files changed, 278 insertions(+), 241 deletions(-)

Thanks,
Janusz
