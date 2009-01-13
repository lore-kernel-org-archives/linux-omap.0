From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 0/2] omap_hsmmc patches
Date: Tue, 13 Jan 2009 15:38:27 +0200
Message-ID: <20090113133827.29474.92645.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56009 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbZAMN1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 08:27:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>, Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Here are two patches for omap_hsmmc.  They are applied
on top of Jean Pihet's "OMAP: MMC: recover from transfer
failures" patch, which is here:

http://marc.info/?l=linux-omap&m=123141577308177&w=2
