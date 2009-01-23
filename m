From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Nokia RX51 Board Files
Date: Fri, 23 Jan 2009 23:08:45 +0200
Message-ID: <1232744927-21010-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35443 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbZAWVJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 16:09:16 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0NL9BTk025664
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 23:09:13 +0200
Received: from localhost.localdomain (esdhcp04088.research.nokia.com [172.21.40.88])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0NL8lYM008840
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 23:08:48 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


These patches introduce initial RX-51 Internet Tablet board files
and rx51_defconfig. Comments are welcome, especially concerning
board-rx51-sdram.c. It should be made generic and convert other
OMAP3 boards to use such human readable timing configs.

/lauri

