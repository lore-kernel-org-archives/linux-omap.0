From: Paul Walmsley <paul@pwsan.com>
Subject: N800 problems with MMC, LM8323 on current linux-omap git head
Date: Thu, 17 Jul 2008 21:25:06 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807172113070.467@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34609 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbYGRDZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 23:25:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, jarkko.lavinen@nokia.com, tony@atomide.com


Hello everyone,

noticed a few issues booting the N800 with the current git head
d3b3ae0fe6c71641da19c8de466ec366d39847e3 today.  Haven't booted the N800 
for a while, so not sure when these showed up.

Looks like there is some LM8323 problem - suppose it could be an I2C 
problem:

[    4.384094] lm8323 2-0045: sent 2 bytes of -121 total
[    4.389312] lm8323 2-0045: sending read cmd 0x82 failed
[    4.394775] lm8323 2-0045: sent 2 bytes of -121 total
[    4.400024] lm8323 2-0045: sent 2 bytes of -121 total
[    4.405212] lm8323 2-0045: sent 2 bytes of -121 total
[    4.410614] lm8323 2-0045: sent 2 bytes of -121 total
[    4.415985] lm8323 2-0045: sent 2 bytes of -121 total
[    4.421325] lm8323 2-0045: sent 3 bytes of -121 total
[    4.426696] lm8323 2-0045: sent 3 bytes of -121 total
[    4.432067] lm8323 2-0045: sending read cmd 0x80 failed
[    4.437316] lm8323 2-0045: device not found

Also MMC looks like something may be wrong:

[    4.524597] mmci-omap mmci-omap.1: command timeout (CMD8)
[    4.530059] mmci-omap mmci-omap.1: command timeout (CMD8)
[    4.536224] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.542327] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.547790] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.553894] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.559326] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.565429] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.570892] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.581481] mmci-omap mmci-omap.1: command timeout (CMD8)
[    4.586914] mmci-omap mmci-omap.1: command timeout (CMD8)

... and then later ...

[    4.866729] mmc0: host does not support reading read-only switch. 
assuming write-enable.
[    4.874969] mmc0: new SD card at address e624
[    4.881042] mmcblk0: mmc0:e624 SD128 123008KiB
[    4.886077]  mmcblk0: p1
[    4.915222] mmci-omap mmci-omap.1: command timeout (CMD8)
[    4.920684] mmci-omap mmci-omap.1: command timeout (CMD8)
[    4.926818] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.932312] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.938415] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.944519] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.949981] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.956085] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.961547] mmci-omap mmci-omap.1: command timeout (CMD5)
[    4.967681] mmci-omap mmci-omap.1: command timeout (CMD55)
[    4.973236] mmci-omap mmci-omap.1: command timeout (CMD55)
[    4.979095] omap24xxcam omap24xxcam: sensor is tcm825x
[    4.984283] mmci-omap mmci-omap.1: command timeout (CMD55)
[    4.990539] mmci-omap mmci-omap.1: command timeout (CMD55)
[    4.996765] mmci-omap mmci-omap.1: command timeout (CMD55)
[    5.002319] mmci-omap mmci-omap.1: command timeout (CMD55)
[    5.008575] mmci-omap mmci-omap.1: command timeout (CMD1)


Something is also wrong with audio - no touchscreen clicks play.

- Paul
