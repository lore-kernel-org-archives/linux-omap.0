From: Kalle Valo <kalle.valo@nokia.com>
Subject: board-n800-bt.c compilation error (OMAP_TAG_NOKIA_BT missing)
Date: Fri, 16 Jan 2009 20:48:29 +0200
Message-ID: <87bpu7m6iq.fsf@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33749 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936348AbZAPSst (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 13:48:49 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0GImXXn014240
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 12:48:46 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ville.tervo@nokia.com

Latest linux-omap#master (commit c699464bd) doesn't compile with
n800_defconfig:

arch/arm/mach-omap2/board-n800-bt.c: In function 'n800_bt_init':
arch/arm/mach-omap2/board-n800-bt.c:36: error: 'OMAP_TAG_NOKIA_BT' undeclared (first use in this function)
arch/arm/mach-omap2/board-n800-bt.c:36: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/board-n800-bt.c:36: error: for each function it appears in.)
arch/arm/mach-omap2/board-n800-bt.c:36: error: invalid application of 'sizeof' to incomplete type 'struct omap_bluetooth_config' 

-- 
Kalle Valo
