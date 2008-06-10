From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/3]  Updates for tea5761 (take #3)
Date: Tue, 10 Jun 2008 13:42:09 -0400
Message-ID: <1213119732-13198-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40379 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813AbYFJRmf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 13:42:35 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5AHfYaZ011339
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 20:42:31 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi guys,

Following recommendation from v4l people, I'm sending
this update to our tea5761 driver.

They already had a tuner for this device which communicates
through i2c.

I needed to update it because there were some register mis-utilization.

Here is a series which updates their tuner and our driver.

After acks and merging here in linux-omap I'll send it to v4l again.

Cheers,

Eduardo Valentin (3):
  tea5761: Add init and sleep callbacks on tea5761 tuner
  tea5761 tuner: fix registers utilization
  radio-tea5761: Update driver

 drivers/media/common/tuners/tea5761.c |   55 +++-
 drivers/media/radio/Kconfig           |    1 +
 drivers/media/radio/Makefile          |    2 +
 drivers/media/radio/radio-tea5761.c   |  570 ++++++++++++++++-----------------
 4 files changed, 329 insertions(+), 299 deletions(-)

