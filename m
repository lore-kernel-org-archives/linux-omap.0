From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v5 0/5] omap: mailbox: hwmod support
Date: Fri, 11 Feb 2011 15:01:21 -0800
Message-ID: <87ipwq89by.fsf@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:52268 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758352Ab1BKXBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 18:01:25 -0500
Received: by pvg12 with SMTP id 12so552168pvg.12
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 15:01:24 -0800 (PST)
In-Reply-To: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Wed, 2 Feb 2011 13:27:18 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> Mailbox hwmod support for OMAP 2,3,4.
>
> This was tested on OMAP3 (3430, 3630), minor testing
> was made on OMAP4.
>
> No testing on OMAP2 since I don't have the hardware.

To help in testing, I wrote a simple mailbox loopback test module for
OMAP2/3/4 that I used to do send and receive messages on the MPU.  This
can be used to test the mailbox without any DSP software.

I tested it against l-o master branch and found a couple bugs in the
mailbox driver (patches posted earlier today.)  

With those patches plus my test I can send & receieve a series of
messages on the MPU, which is enough to sanity test the basic sending
and receiving messages on the MPU.

I've tested the master branch, now it's your turn to use this test
module to validate this hmod conversion series.

The test module is available here:

    git://gitorious.org/omap-test/mailbox.git

Note that the current mailbox driver has hard-coded settings for the
receiver of messages.  While this should be configurable at runtime, I'm
not an expert on the mailbox IP so my test module includes a kernel
patch that changes these hard-coded settings of the first mbox (dsp on
OMAP2/3, mailbox-1 on OMAP4) so that my loopback tester will work.

Kevin

