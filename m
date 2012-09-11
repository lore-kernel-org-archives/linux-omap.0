From: Paul Walmsley <paul@pwsan.com>
Subject: Ack possibility for '[PATCH] SPI: OMAP: remove unnecessary includes
 of plat/clock.h' ?
Date: Tue, 11 Sep 2012 23:44:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209112333550.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2IKXoM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 19:44:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Grant,

was wondering if you might be willing to ack this patch so we can merge it 
via OMAP:

    http://marc.info/?l=linux-omap&m=134740630311140&w=2

Just noticed we have a dependency on that patch for some common clock 
framework conversion patches also...


- Paul
