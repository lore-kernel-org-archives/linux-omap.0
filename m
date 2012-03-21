From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 11:39:57 -0700
Message-ID: <20120321183957.GM9859@atomide.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
 <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61271 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab2CUSkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 14:40:03 -0400
Content-Disposition: inline
In-Reply-To: <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Porter, Matt" <mporter@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>

* Porter, Matt <mporter@ti.com> [120321 11:27]:
> 
> On Mar 21, 2012, at 2:13 PM, Mark Brown wrote:
> 
> > On Wed, Mar 21, 2012 at 10:55:54AM -0700, Russ Dill wrote:
> > 
> >> unwieldy this would become if it were done for every device. Either the
> >> functionality needs to be moved to Snowball board init code, or a generic
> >> framework needs to be made for attaching regulators to arbitrary devices.
> > 
> > Hrm?  Adding regulator supply mappings anywhere other than the
> > initialisation for a specific board would be extremely unusual and
> > rather suspicious.

The issue here is that we don't want to copy paste the dummy fixed
regulator all over the board-*.c files, and we don't know how the
real regulator is wired up.
 
> Just to be clear, here is the thread on the board-specific approach:
> https://lkml.org/lkml/2012/2/8/415

We should use the real regulator if passed from board file.

And if no real regulator is passed, just use the dummy fixed regulator
in gpmc-smsc911x.c.

This patch I posted should fix the situation and allow adding the
real regulators to board-*.c files when they become known:

http://www.spinics.net/lists/linux-omap/msg66714.html

Regards,

Tony
