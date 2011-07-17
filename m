From: Arnd Bergmann <arnd@arndb.de>
Subject: conflicts between omap/cleanup branch and omap_dss2 tree
Date: Sun, 17 Jul 2011 23:39:32 +0200
Message-ID: <201107172339.32516.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64838 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1GQVk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Jul 2011 17:40:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Paul and Tomi,

I'm trying to get the arm-soc tree integrated into linux-next, but right
now that fails because of lots of conflicts in the arch/arm/mach-omap2/clock44xx_data.c
and arch/arm/mach-omap2/omap_hwmod_44xx_data.c files.

I've done a dumb resolution by pulling in the omap_dss2/for_next tree as a
depedency and taking Tomi's version of the files, which is probably wrong 
but lets Stephen at least take the arm-soc tree.

Please fix this properly in either the omap or the omap_dss2 trees.

	Arnd
