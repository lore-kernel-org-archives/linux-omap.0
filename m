From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 0/3] ARM: omap3: add Seagate Wireless Plus board
Date: Wed, 8 May 2013 12:51:53 -0700
Message-ID: <20130508195152.GE32546@atomide.com>
References: <cover.1368038129.git.jason@lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11532 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750900Ab3EHTv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 15:51:57 -0400
Content-Disposition: inline
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Jason Cooper <jason@lakedaemon.net> [130508 12:29]:
> 
> Current Problem:
> 
> There are several gaps in my understanding of how far along TI's conversion to
> DT is.  Should I be doing a separate board file for initializing the legacy
> items?  I was hoping to do it all with DT.

Sorry forgot to reply to this.. No seprate board file should be needed,
some devices may still need to be initialized with pdata based on the
compatible flag.
 
> Obviously, I don't expect anybody to run out and buy one of these, take it
> apart, and try to boot this code.  But if the omap guys could take a look at
> this and give me a few pointers, I'd appreciate it.  I'm kind of spinning my
> wheels at the moment.
> 
> Primarily, I'd like to get nand and usb working, so that I can read/write,
> mount a rootfs and do better testing.

The USB should be doable with device tree. At least both echi and
musb are working properly on pandaboard. I think people have been
using NAND with the gpmc DT patches, but I don't know the current
status for sure.

Is the hard drive on the EHCI bus or how is it connected to omap?

Regards,

Tony
