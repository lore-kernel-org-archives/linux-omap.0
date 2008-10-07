From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 0/3] Move twl4030 scripts to platform data
Date: Tue,  7 Oct 2008 17:34:07 +0300
Message-ID: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53626 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbYJGOe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 10:34:28 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97EY03D019631
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 17:34:26 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch set move the twl4030 scripts to platform data and integrates the code to download the scripts with the new twl4030 codebase.

Peter 'p2' De Schrijver (3):
  Add twl4030 scripts to 3430sdp platform data
  Adapt twl4030 power code to new twl4030 code
  Add twl4030 power platform device

 arch/arm/mach-omap2/board-3430sdp.c |   61 ++++++++
 drivers/i2c/chips/twl4030-core.c    |   41 +++++
 drivers/i2c/chips/twl4030-power.c   |  290 ++++++++++++++---------------------
 include/linux/i2c/twl4030.h         |   64 ++++++++
 4 files changed, 283 insertions(+), 173 deletions(-)

