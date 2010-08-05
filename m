From: Tony Lindgren <tony@atomide.com>
Subject: Re: Board mux entries ignored?
Date: Thu, 5 Aug 2010 09:54:24 +0300
Message-ID: <20100805065423.GU9881@atomide.com>
References: <AANLkTimYgkviKVfXNpQB9vsjSZyMdxuwkrXYQHSb02wY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63519 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758243Ab0HEGx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 02:53:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimYgkviKVfXNpQB9vsjSZyMdxuwkrXYQHSb02wY@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Faith <jfaith7@gmail.com>
Cc: linux-omap@vger.kernel.org

* John Faith <jfaith7@gmail.com> [100804 22:22]:
> Hi,
> I'm trying to set mux modes for a 3530, package CBC in my board.c
> (2.6.32 kernel) using an omap_board_mux entry:
>  OMAP3_MUX(GPMC_WAIT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> 
> , but sysfs reports mode4:
> # grep WAIT1 /sys/kernel/debug/omap_mux/board
> OMAP3_MUX(GPMC_WAIT1, OMAP_PIN_INPUT | OMAP_MUX_MODE4),
> 
> I tried adding to bootargs "omap_mux=gpmc_wait1.gpmc_wait1=0x100", but
> still got MODE4.  Doing "echo 0x100 >
> /sys/kernel/debug/omap_mux/gpmc_wait1" gave me MODE0, but I'd prefer
> to init pins in board.c.  I've also noticed for pin SDMMC2_DAT3 that
> my OMAP3_MUX() entry specifies MODE1, but sysfs shows MODE4; it
> changed to MODE1 after adding:
>  omap_mux_init_signal("mcspi3_cs0", OMAP_PIN_OUTPUT);
> 
> Is just having the mode in omap_board_mux entries sufficient?

Hmm that should be enough. Does dmesg | grep -i mux show any errors?

You do have CONFIG_OMAP_MUX set, right? Otherwise omap_mux_init_signals
does not do anything, and the mux code just builds a list of GPIO
pins for PM runtime muxing (not implemented yet).

Regards,

Tony
