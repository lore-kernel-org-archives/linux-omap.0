From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Cleaned up version of system_rev to omap_rev()
Date: Sat,  1 Nov 2008 13:07:03 +0200
Message-ID: <1225537624-6669-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:38257 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYKALGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2008 07:06:21 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mA1B6HP5012497
	for <linux-omap@vger.kernel.org>; Sat, 1 Nov 2008 13:06:17 +0200
Received: from pure.research.nokia.com (pure.research.nokia.com [172.21.42.21])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mA1B6FlB020458
	for <linux-omap@vger.kernel.org>; Sat, 1 Nov 2008 13:06:15 +0200
Received: from lleukkun by pure.research.nokia.com with local (Exim 4.69)
	(envelope-from <lleukkun@pure.research.nokia.com>)
	id 1KwEJs-0001k0-Vo
	for linux-omap@vger.kernel.org; Sat, 01 Nov 2008 13:07:04 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi,

This one passes checkpatch.pl and adds KERN_* for all printk()s
in mach-omap1/{pm,id}.c

/lauri
