From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 4/4] [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related
 devices
Date: Tue, 6 Jul 2010 11:44:25 +0300
Message-ID: <20100706084421.GD3192@atomide.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
 <1275407698-12945-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63311 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0GFIob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 04:44:31 -0400
Content-Disposition: inline
In-Reply-To: <1275407698-12945-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100601 18:49]:
> This change adds in MMC and I2C support to the HTC Herald board, as well
> as adding the HTCPLD driver for the PLD used on this phone.  It also
> adds in the gpio-keys entries for the front directional keys and
> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> support for the LEDs attached to the htcpld.
> 
> The Kconfig was also modified to add 64 GPIOs and IRQs to the default
> maximum number of each for the HTC herald.  This is needed because the
> HTCPLD chip on this board exposes an additional 32 gpios and 16 irqs
> that would not fit in the default limits.
> 
> The defconfig has been updated to reflect the changes.

This one needs to be updated too to leave out the defconfig changes.

Thanks,

Tony
