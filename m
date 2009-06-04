From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Please help on testing new sound driver for OMAP1510 based machine
Date: Thu, 4 Jun 2009 20:07:43 +0200
Message-ID: <200906042007.45302.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49874 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbZFDSIT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2009 14:08:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

As some of you may have already noticed, I am trying to create a sound driver 
for ams-delta board, based on ASoC OMAP framework. AFAIK, this would be the 
first ASoC implementation for OMAP1510/5910 based board. Unfortunatelly, I am 
not able to get DMA interrupts working.

It would be much easier to find the reason of the problem if there were 
already working ASoC OMAP implementations for other OMAP1510/5910 based 
boards. As there is none yet, I would be willing to spend my time on creating 
one for a board with a former, omap-alsa based working sound driver, if I 
could only find someone who has such device on hand, knows how to boot a 
custom kernel and would like spend some time on testing my patches.

AFAICS, there were following OMAP1510/5910 based machines supoorted by 
omap-alsa:
- OMAP-1510 Innovator (AIC23 codec),
- Palm Tungsten E,
- Palm Tungsten T (AIC23 codec),
- Palm Zire71 (AIC23 codec),
- Siemens SX1.
It would be better to start with a machine that has AIC23 codec on board, as 
this codec is already supported by current ASoC framework.

If you know of someone who has access to one of those devices and would like 
to help, please ask him to drop me a message.

Cheers,
Janusz
