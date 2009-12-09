From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v7 0/5] OMAP: McBSP: Use register cache
Date: Wed, 9 Dec 2009 21:24:13 +0100
Message-ID: <200912092124.14430.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37955 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbZLIUYL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 15:24:11 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

Change the way McBSP registers are maintained: store values written to the
device in a cache in order to make use of those cached values when
convenient.

This could help for developing the McBSP context save/restore features, as
well as solve the problem of possible register corruption, experienced on
OMAP1510 based Amstrad Delta board at least.

Series created against linux-omap for-next, commit
82f1d8f22f2c65e70206e40a6f17688bf64a892c.
All patches tested on OMAP1510 based Amstrad Delta and compile-tested using
omap_3430sdp_defconfig at least.

Janusz Krzysztofik (5):
	OMAP: McBSP: Use macros for all register read/write operations
	OMAP: McBSP: Modify macros/functions API for easy cache access
	OMAP: McBSP: Introduce caching in register write operations
	OMAP: McBSP: Use cache when modifying individual register bits
	OMAP: McBSP: Split and move read/write functions to mach-omap1/2

 arch/arm/mach-omap1/mcbsp.c             |   28 +
 arch/arm/mach-omap2/mcbsp.c             |   42 ++
 arch/arm/plat-omap/include/plat/mcbsp.h |    6
 arch/arm/plat-omap/mcbsp.c              |  470 +++++++++++++++-----------------
 4 files changed, 292 insertions(+), 254 deletions(-)

Thanks,
Janusz
