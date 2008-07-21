From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: RFC: OMAP3 SYS_OFF_MODE support
Date: Mon, 21 Jul 2008 19:17:19 +0300
Message-ID: <1216657043-5941-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57456 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbYGUQSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 12:18:09 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m6LGI4Bi008194
	for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2008 19:18:07 +0300
Received: from localhost.localdomain (esdhcp04191.research.nokia.com [172.21.41.91])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6LGHN1u020962
	for <linux-omap@vger.kernel.org>; Mon, 21 Jul 2008 19:17:24 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


The following patch set introduces support for the OMAP3 SYS_OFF_MODE
signal. This will cause a properly programmed triton2 to shutdown the
VDD1 and VDD2 regulators when both core and MPU powerdomain are in off
state. The patches includes programming triton2 with the appropriate
scripts for the SDP3430 board.
By default the OMAP3 polarity of the SYS_OFF_MODE signal is inverted
compared to what triton2 expects. This means the polarity needs to be
changed before the triton2 scripts are activated, otherwise the system
will crash. At the moment this is done in omap2_clk_init as this
function is called before triton2 is initialized. Better suggestions are
welcome.
Thanks to Kalle Jokiniemi for doing the initial patch and test work.

