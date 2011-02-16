From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
 OMAP2xxx
Date: Wed, 16 Feb 2011 16:05:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102161551400.29817@utopia.booyaka.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain> <43af56d25809fa616f0e17d7e641ebc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50204 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1BPXFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 18:05:17 -0500
In-Reply-To: <43af56d25809fa616f0e17d7e641ebc0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 16 Feb 2011, Rajendra Nayak wrote:

> Boot-tested on 3430sdp/4430sdp, with CONFIG_PM and with !CONFIG_PM.
> suspend-offmode tested on 3430sdp and suspend-retmode on 4430sdp (with
> some out-of-tree patches)

Thanks, will add Tested-by:s.

> Dynamic idle testing on 3430sdp showed me some very jerky debug console 
> the moment a 'echo 1 > /debug/pm_debug/sleep_while_idle' is done. This 
> however seems to be the case even on 2.6.38-rc4 and not related to the 
> current patch series.

Does enabling CONFIG_OMAP2_DSS resolve the problem you're seeing?

> Will debug further, but seems to some 3430sdp specific issue, since you 
> did not see it on Beagleboard and seems it is not seen on OMAP3 zoom's 
> either. Just out of curiosity, what dynamic-idle state where you able to 
> achieve on Beagle?

Full chip off.  I use omap2plus_defconfig, sometimes with CONFIG_OMAP2_DSS 
depending on personal mood and what's being tested.  I boot to a shell and 
run the commands at the end of this message (some of which are probably 
superfluous).


- Paul


echo 1 > /debug/pm_debug/sleep_while_idle
echo 1 > /debug/pm_debug/enable_off_mode
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
echo enabled > /sys/devices/platform/omap/omap_uart.0/tty/ttyO0/power/wakeup
echo enabled > /sys/devices/platform/omap/omap_uart.1/tty/ttyO1/power/wakeup
echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup


