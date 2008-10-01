From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 11/9] move twl4030-gpio to drivers/gpio
Date: Wed, 1 Oct 2008 08:58:12 -0700
Message-ID: <200810010858.13612.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809272216.14672.david-b@pacbell.net> <94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:20388 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751718AbYJAP6Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 11:58:16 -0400
In-Reply-To: <94a0d4530810010646j7bc4bd8bsb2b94e96adbb0182@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jean Delvare <khali@linux-fr.org>

On Wednesday 01 October 2008, Felipe Contreras wrote:
> Hmm, I'm seeing two different configs:
> CONFIG_TWL4030_GPIO
> CONFIG_GPIO_TWL4030
> 
> I guess the defconfigs are wrong.

Right, they should get fixed.

The same issue will come when drivers/i2c/chips/twl4030-core.c
moves to drivers/mfd/twl4030-core.c I suspect ... it might be
simpler to hold off on that change for a bit.  (No big deal
either way.)

- Dave

