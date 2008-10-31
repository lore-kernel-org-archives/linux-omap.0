From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP tree][RFC 2.6.28-rc2-omap 0/9]
Date: Fri, 31 Oct 2008 14:18:48 +0200
Message-ID: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33818 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbYJaMT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:19:58 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCINP8031695
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 07:19:57 -0500
Received: from localhost.localdomain (esdhcp041151.research.nokia.com [172.21.41.151])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9VCJOcw011691
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:19:24 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is from the "Continue phasing out legacy GPIO calls" set I sent earlier
and include files which are in linux-omap tree only.

This is generated on top of David's recent 4+5 "legacy gpio phaseout.." patches
in linux-omap tree.

Note that this still includes the drivers/leds/leds-omap.c which should vanish
and board-palmtt.c which should be converted to use leds-gpio.c instead.


-- 
Jarkko
