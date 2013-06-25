From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC breakage on 3.11/cleanup
Date: Mon, 24 Jun 2013 23:49:44 -0700
Message-ID: <20130625064944.GX5523@atomide.com>
References: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45484 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3FYGtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jun 2013 02:49:46 -0400
Content-Disposition: inline
In-Reply-To: <CAD=GYpZGdLem1igUsLq7DzMu-Z=9d6apS-aT=MJ59_-ytZan7w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>

* Joel A Fernandes <agnel.joel@gmail.com> [130624 15:33]:
> Hi Tony,
> 
> Following branch breaks MMC for me on am33xx (beaglebone):
> http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.11/cleanup
> 
> I tried to work around it by specifying interrupt and reg property in DT:
>       mmc1: mmc@48060000 {
>          compatible = "ti,omap3-hsmmc";
>          ti,hwmods = "mmc1";
>          ti,dual-volt;
>          ti,needs-special-reset;
>          dmas = <&edma 24
>             &edma 25>;
>          dma-names = "tx", "rx";
>          interrupts = <64>;
>          interrupt-parent = <&intc>;
>          reg = <0x48060000 0x1000>;
>          status = "disabled";
>       };
> 
> The probe succeeds but I still get a "Waiting for root device
> /dev/mmcblk0p2" when booting over MMC.
> 
> If you're planning to push the cleanup branch, can we temporarily add
> the hwmod data back while we work on this issue so that upstream MMC
> is kept working.

Yes the cleanup branch is queued up. Can you please send a patch
reverting the MMC parts of the hwmod change for am33xx for now,
then try to find the real cause for the breakage?

Regards,

Tony
