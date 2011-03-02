From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia n810 LCD (MIPID/blizzard) on 2.6.38
Date: Wed, 2 Mar 2011 10:30:33 -0800
Message-ID: <20110302183033.GD20560@atomide.com>
References: <1298925943.16391.19.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab1CBSai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 13:30:38 -0500
Content-Disposition: inline
In-Reply-To: <1298925943.16391.19.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Varadarajan Charulatha <charu@ti.com>, Paul Walmsley <paul@pwsan.com>

* Michael Buesch <mb@bu3sch.de> [110228 12:43]:
> 
> The hwmod code performs a soft-reset on the GPIO
> module. The first GPIO module carries the MIPID
> "nreset" line, which is toggled due to the hwmod soft reset.
> This resets Blizzard and breaks it, because
> it assumes the LCD was left in the state that the
> bootloader initialized it to:

The long term solution is to allow passing options to the
hwmod framework to not reset pins from both board-*.c
files and from cmdline.

For this case it would be nice to pass info from the board-*.c
file to hwmod so it knows to skip reset only for this GPIO.

For booting Linux from other OS, something like
hwmod.reset_disable=all is needed to keep the LCD on.

Regrads,

Tony
