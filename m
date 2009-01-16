From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/1] ASoC patch on top of linux-omap 2.6.29-rc1 (TWL4030 related) - try2
Date: Fri, 16 Jan 2009 09:48:05 +0200
Message-ID: <1232092086-30074-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37427 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684AbZAPHsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 02:48:12 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0G7lrng006696
	for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 09:48:08 +0200
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

BTW: the twl4030 codec driver has been changed dramatically, meaning that
most (shall I say all?) of the platforms using it need to be updated to define
the correct output and input pins.
The playback and capture path now implemented with DAPM, so without the correct
definitions the audio is most likely will not going to work.
On the bright side: all possible playback and capture routing combination can be
configured (except for the pre-DAC routing, but I can send a sample code,
which does it in the board file).

---
Peter Ujfalusi (1):
  ASoC: Fix the power update function for snd_soc_dapm_value_mux

 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

