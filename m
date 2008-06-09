From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/3]  Updates for tea5761 (take #2)
Date: Mon,  9 Jun 2008 16:05:40 -0400
Message-ID: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46452 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYFIUKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 16:10:03 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m59K3Cea028269
	for <linux-omap@vger.kernel.org>; Mon, 9 Jun 2008 15:10:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
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
 drivers/media/radio/radio-tea5761.c   |  564 ++++++++++++++++-----------------
 4 files changed, 330 insertions(+), 292 deletions(-)

