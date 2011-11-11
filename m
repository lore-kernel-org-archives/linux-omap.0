From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Thu, 10 Nov 2011 16:12:03 -0800
Message-ID: <20111111001203.GD31337@atomide.com>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
 <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22306 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab1KKAMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 19:12:07 -0500
Content-Disposition: inline
In-Reply-To: <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

* Ilya Yanok <yanok@emcraft.com> [111108 15:38]:
> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
>  arch/arm/boot/dts/mcx.dts                    |   29 ++
>  arch/arm/mach-omap2/Kconfig                  |    5 +
>  arch/arm/mach-omap2/Makefile                 |    3 +
>  arch/arm/mach-omap2/board-mcx.c              |  618 ++++++++++++++++++++++++++

This looks OK but let's concentrate on getting things working with
board-generic.c and DT only in mainline kernel.

I can apply this into testing-board, but let's not cause more churn
in mainline with the board files that will be disappearing.

Can you please split it into something minimal for mainline that
allows booting with DT, and then another patch for testing-board
branch?

Thanks,

Tony
