From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Sat, 27 Sep 2008 16:29:33 -0700
Message-ID: <200809271629.34462.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809271441.41412.david-b@pacbell.net> <20080927222900.GC8468@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:43461 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753563AbYI0X3g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 19:29:36 -0400
In-Reply-To: <20080927222900.GC8468@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Saturday 27 September 2008, Felipe Balbi wrote:
> This patch breaks hsmmc.c:
> arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
> /home/underline/workspace/linux-omap-2.6/arch/arm/mach-omap2/hsmmc.c:51: undefined reference to `twl4030_get_gpio_datain'
> 	... etc

Could you verify that still happens with a build-from-scratch?
Like, one in which you made sure to enable CONFIG_GPIO_TWL4030?

I certainly don't get those errors.  That's exactly why those
few TWL-specific symbols are left in that driver:  because that
file still uses them.  They get removed later, before this gets
sent upstream.

- Dave
