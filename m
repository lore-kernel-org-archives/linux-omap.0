From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Fix for twl4030-power.c build failure for beagleboard
Date: Thu, 11 Sep 2008 14:50:01 +0300
Message-ID: <1221133802-19613-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60112 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbYIKLui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 07:50:38 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BBoQUv002095
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 14:50:36 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch should fix the twl4030-power.c build failure for beagleboard.

Peter 'p2' De Schrijver (1):
  Fix build for beagleboard

 drivers/i2c/chips/twl4030-power.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

