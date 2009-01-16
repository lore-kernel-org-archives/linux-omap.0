From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC patch on top of linux-omap 2.6.29-rc1 (TWL4030 related)
Date: Fri, 16 Jan 2009 08:14:52 +0200
Message-ID: <1232086493-2811-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65057 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbZAPGPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 01:15:03 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0G6ELUP012227
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 00:14:59 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Hello,

This patch has been sent after 29-rc1 to ALSA devel, it is already in Takashi's
tree and will go upstream as soon as possible.

Somehow I have left out this from the soc_value_enum type merge to the soc_enum
series, which kind of renders the twl4030 codec driver to not to update the
value_enum types. In other words: without this patch the twl4030 codec is not
working.

The patch applies cleanly to the head of linux-omap tree.

---
Peter Ujfalusi (1):
  ASoC: Fix the power update function for snd_soc_dapm_value_mux

 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

