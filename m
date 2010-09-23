From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Thu, 23 Sep 2010 10:22:54 -0700
Message-ID: <20100923172254.GM4211@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
 <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54942 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab0IWRW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 13:22:58 -0400
Content-Disposition: inline
In-Reply-To: <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100817 21:28]:
> This change adds in MMC and I2C support to the HTC Herald board, as well
> as adding the HTCPLD driver for the PLD used on this phone.  It also
> adds in the gpio-keys entries for the front directional keys and
> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> support for the LEDs attached to the htcpld.
> 
> Additionally, SPI bus support (using the spi100k driver) and
> touchscreen support (using the ads7846 driver) were added.

Thanks, I'll add this into omap-for-linus for the upcoming merge
window. Cory, can you please check if you have other pending
patches? I don't see others in patchwork.kernel.org, but thought
there may be some that did not get merged last merge window?

Regards,

Tony
