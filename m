From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: OMAP: TWL4030: Sound broken in 3.1
Date: Fri, 04 Nov 2011 15:18:05 +0000
Message-ID: <WC20111104151805.630235@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:53153 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab1KDPSQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 11:18:16 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id pA4FI7YN009432
	for <linux-omap@vger.kernel.org>; Fri, 4 Nov 2011 15:18:13 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.0.4)
	with ESMTP id md50002104076.msg
	for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 15:18:08 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

In 3.1 sound support is broken for any boards using a TWL4030-based CODEC.

The Kconfig option for the TWL4030 CODEC used to be TWL4030_CODEC, and in 
3.1 this has been changed to MFD_TWL4030_AUDIO.

I believe this has caused a problem in drives/mfd/twl-core.c:112 as the 
define for the twl_has_codec() macro still tests for CONFIG_TWL4030_CODEC. 
Hence the macro always returns false and during boot I get:

[    2.417999] ALSA device list:
[    2.421142]   No soundcards found.

Is this likely to be the problem?

Cheers,
Joe


