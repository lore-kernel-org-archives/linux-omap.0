From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 12:00:30 -0700
Message-ID: <200809261200.30728.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261012.28007.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:24835 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752227AbYIZTAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 15:00:32 -0400
In-Reply-To: <200809261012.28007.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 26 September 2008, David Brownell wrote:
> Let's apply the following patch 10/9 on top of this though.

And after applying this, and removing MADC config from
the Beagle and Overo board setup files, things worked!!

Moreover ... the USB host code worked, at least partially.
(Finally!  RC7.)  It enumerated the external hub, and the
Ethernet adapter hooked up to it.

But there were problems reading some chip registers via
control requests, and with MII read/write.  So it's not
all there yet.

- Dave

