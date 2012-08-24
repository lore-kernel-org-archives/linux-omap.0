From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3] backlight: Add TPS65217 WLED driver
Date: Fri, 24 Aug 2012 11:27:38 +0200
Message-ID: <8DC20C93-E284-4E30-85FC-F3F39D756891@dominion.thruhere.net>
References: <20120822210419.GA6235@darwin>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55833 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2HXJ1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 05:27:40 -0400
Received: by weyx8 with SMTP id x8so904840wey.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Aug 2012 02:27:38 -0700 (PDT)
In-Reply-To: <20120822210419.GA6235@darwin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Op 22 aug. 2012, om 23:04 heeft Matthias Kaehlcke <matthias@kaehlcke.net> het volgende geschreven:

> The TPS65217 chip contains a boost converter and current sinks which can be
> used to drive LEDs for use as backlights. Expose this functionality via the
> backlight API.
> 
> Tested on an AM335x based custom board with a single WLED string, using
> different values for ISEL and FDIM (though it would be hard to tell the
> difference except for the value in WLEDCTRL1). Both instantiation through the
> device tree and by passing platform data have been tested. Testing has been
> done with an Androidized 3.2 kernel from the rowboat project
> 
> This patch is based on the mfd/for-next branch (20120822)
> 
> Changes since v2:
> 
> * adapted to the latest version of the tps65217 mfd driver
> * register backlight as mfd subdevice
> * allocate struct tps65217_bl after validation of the device tree/platform data
> 
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>

Work beautifully on a beaglebone + 3" LCD cape, although there's no FB driver yet:

Tested-by: Koen Kooi <koen@dominion.thruhere.net>