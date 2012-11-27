From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP build now completely broken in latest arm-soc
Date: Mon, 26 Nov 2012 17:13:42 -0800
Message-ID: <20121127011341.GO5279@atomide.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
 <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:50778 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757789Ab2K0BNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 20:13:47 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org

* Olof Johansson <olof@lixom.net> [121125 05:59]:
> On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > But also, the:
> >
> > arch/arm/mach-omap2/timer.c:163:28: warning: 'omap_counter_match' defined but not used
> >
> > warning is still there.
> 
> There's a fix for this in Tony's tree, but he hasn't sent up the pull
> request for it yet.

Sent a pull request for that as "omap late timer clean-up
(and a warning fix) for v3.8 merge window". The fix is there
there as the topmost third patch, but that probably does not
matter in this case as the regression was introduced in the
patches queued.

Let me know if you want it separately though.

Regards,

Tony
