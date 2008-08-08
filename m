From: Peter Barada <peterb@logicpd.com>
Subject: Troubles with twl4030 audio...
Date: Fri, 08 Aug 2008 17:12:04 -0400
Message-ID: <1218229924.24975.35.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:40958 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753295AbYHHVMH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2008 17:12:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to get ALSA audio going on an OMAP3430-based board, and I've
configured using CONFIG_SND_OMAP_3430SDP_COMP=m which builds
sound/arm/omap/omap2-audio-twl4030.ko module that I load/unload as part
of my debug cycle.

When I play a sound though, the results are *really* distorted with lots
of pulse noise showing up in both channels. Using audacity I created an
empty file (i.e. silence), and the output contains pulse noise in both
channels, Much mnore on the left than right channel.

To look deeper, I created a sawtooth waveform and used that instead of
the tone[] array in omap2-audio-twl4030.c, and the result looks good on
the left channel, but the right is essentially silent, but contains
pulse noise whos amplitude looks to be porportional with the sawtooth,
but only in the 2nd half of the sawtooth (when the data is > 0x8000).
Also, there's a lot of initial DC bias in the output.

Anyone see anything like this, or have suggestions?

