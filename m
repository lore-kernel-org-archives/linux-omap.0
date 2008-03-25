From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 0/1] ALSA SoC support for OMAP
Date: Tue, 25 Mar 2008 11:33:56 +0200
Message-ID: <1206437637-8260-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50761 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYCYJee (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2008 05:34:34 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2P9Y86h018539
	for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 11:34:31 +0200
Received: from localhost.localdomain (esdhcp04050.research.nokia.com [172.21.40.50])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m2P9XVvD016665
	for <linux-omap@vger.kernel.org>; Tue, 25 Mar 2008 11:33:32 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi

I wanted to do this early release of OMAP ASoC work here before going into
alsa-devel. Patch includes common PCM DMA module, single McBSP link I2S DAI
driver and machine driver for Nokia N810. Patch tries to cover OMAPs from 1510
onward but e.g. McBSP ports 3-5 found in 2430 and 34xx are not supported
yet.

I have tested this only in N810 using codec both as a I2S master (as now) and
slave (exact 44.1 and 48 kHz rates are not possible in N810) configuration.

Known issues:
- McBSP doesn't synchronize properly to channel sync (LR/FSX) when codec is
  master. Seems happen only in playback.
- If RFIG bit in RCR2 is not set, then McBSP ends up to endless RX irq loop?

TODO:
- Pin multiplexing for standard I2S signals, McBSP: DR, DX, CLKX and FSX, and
  for external CLKS clock input
- Can we configure more than one McBSP port for I2S? omap-mcbsp module should
  support multiple I2S DAIs almost already
- Other link formats than I2S?
- Change omap_mcbsp_start and omap_mcbsp_stop API to allow individual RX/TX
  control. Frame sync and/or sample rate generator restart is required
  if there is already capture stream active and we'll start simultaneous
  playback. Yet again channel sync can be wrong in this case. Have to dig more
  on this.

Comments are welcome. I would like to get this as good as possible for
submission to alsa-devel. Meaning that at least OMAP1510-2420 are supported
and then gradual updates to later OMAPs when we are more sync with the
mainline. E.g. pin multiplexing for McBSP ports 3-5 etc.

-- 
Jarkko
