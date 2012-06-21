From: Paul Walmsley <paul@pwsan.com>
Subject: N800 MMC broken on v3.5-rc3
Date: Thu, 21 Jun 2012 12:18:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206211216590.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47537 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab2FUSSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 14:18:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org


N800 no longer mounts MMC on v3.5-rc3:

http://www.pwsan.com/omap/bootlogs/20120620/omap_cleanup_a_3.6__07b3a13957aa250ff5b5409b8ed756b113544112/n800_bootlog.txt

This broke at some point between v3.4-rc2 and v3.5-rc3.


- Paul
