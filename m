From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v3 0/4] OMAP: McBSP: Use register cache
Date: Tue, 1 Dec 2009 04:10:07 +0100
Message-ID: <200912010410.10129.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38132 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbZLADKI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Nov 2009 22:10:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Change the way McBSP registers are maintained: store values written to the
device in a cache in order to  make use of those cached values when
convenient.

This could help for developing the McBSP context save/restore features, as
well as solve the problem of possible register corruption experienced on
OMAP1510 based Amstrad Delta board, at least.

Janusz Krzysztofik (4):
	OMAP: McBSP: Use macros for all register read/write operations
	OMAP: McBSP: Prepare register read/write macros API for caching
	OMAP: McBSP: Introduce caching in register write operations
	OMAP: McBSP: Use cache when modifying individual register bits

 arch/arm/plat-omap/include/plat/mcbsp.h |    5
 arch/arm/plat-omap/mcbsp.c              |  397 ++++++++++++++++++++++++---------------------------
 2 files changed, 198 insertions(+), 204 deletions(-)

Thanks,
Janusz
