From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 0/7] OMAP4: mux: Add the OMAP4430 ES1 & ES2 support
Date: Tue, 19 Oct 2010 16:06:42 -0700
Message-ID: <20101019230642.GF3038@atomide.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63587 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757590Ab0JSXGo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 19:06:44 -0400
Content-Disposition: inline
In-Reply-To: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

* Benoit Cousson <b-cousson@ti.com> [101019 15:14]:
> Hi Tony,
> 
> Upon Nishanth request, here is the updated version...
> 
> It takes into account your proposal to store partition
> information in a partition structure instead of inside every pad entries.
> The mechanism relies on the uniqueness of the pad name in each partition to
> find the correct partition during iteration.

OK, using the offset defines won't be unique necessarily..
 
> Removed as well some cpu_is_xxx calls from the core code by adding a couple of
> flags during partition init.

That's great.
 
> Please note that due to low level access to mux api from the RX51 board code,
> I have to disable the mux change to build properly with omap2plus_defconfig.
> Look like you do have some idea to fix that :-)
> I was thinking of:
> - brute force approach that consist of keeping all the data after init, and
> thus allowing removing the __init in the omap_mux_init_signal API
> - or adding some flag in the pad entry to keep them after init .

Well I was thinking we just register a board specific dynamic mux table
and then call that when hitting retention or off and restore after that.
Still need to think about that a bit more, I don't know if we want
the automatic muxing of gpio pins still in addition to that.

> Boot tested on SDP4430 with ES1.0 & ES2.0 with omap2plus_defconfig. Still require
> some real driver to use that mux API in order to validate it.

You can test by echoing wrong values after booting via /sys to
mess up the MMC data lines and then type sync :)

> The series is on top of lo/master (2.6.36-rc8) and is available here:
> git://gitorious.org/omap-pm/linux.git ctrl-wip/mux-omap4-v2

For pulling anything in, the git branches need to be based on something
that's immutable. So preferrably v2.6.35 or some recent -rc tag
in this case. Or rebase it on v2.6.36 after that's been released.

Regards,

Tony
