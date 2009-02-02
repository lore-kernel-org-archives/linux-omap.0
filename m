From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: BUG: LDP - smc911x region too small
Date: Mon, 2 Feb 2009 16:41:22 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620376E9B0F3@dlee02.ent.ti.com>
References: <20090119223750.GL18301@n2100.arm.linux.org.uk>
 <1232433403.31748.8.camel@localhost>
 <20090120083121.GA11157@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50878 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZBBWle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 17:41:34 -0500
In-Reply-To: <20090120083121.GA11157@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, "stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > Here should be 0x100. Fixing this won't cause problems with smsc911x
> > patches.
>
> Yes it will - if it gets fixed in the -rc series for the smc911x driver
> your patches will conflict.
>
> There's more which needs fixing though - no platform data is being passed
> so the smc911x driver still fails to initialise.

Data sheet shows addressable range as 0x50 from base --> 0xFC.  So 0xFF should be good.

I tried to send Russell data sheet but his emails is rejecting it.

Regards,
Richard W.
