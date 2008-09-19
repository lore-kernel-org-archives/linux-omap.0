From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Fri, 19 Sep 2008 10:30:11 +0200
Message-ID: <20080919083011.GF22550@infomag.infomag.iguana.be>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk> <20080918200245.GA6617@frodo> <20080918203401.GC14307@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:49326 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792AbYISIaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 04:30:13 -0400
Content-Disposition: inline
In-Reply-To: <20080918203401.GC14307@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>

Hi All,

> On Thu, Sep 18, 2008 at 11:02:58PM +0300, Felipe Balbi wrote:
> > Well, what can I say. I'll try to get rid of those cpu conditional code
> > in the driver and sync omap_wdt.c with mainline. Send all the patches
> > via Wim, so Tony can get them later.
> 
> BTW, I'd also suggest copying Andrew Morton as well - I think Wim doesn't
> have very much time to spend doing kernel stuff, so you may not receive
> a reply for a while.  If Andrew takes the patches, then you have to
> worry less about Wim forgetting about them (or if Andrew times out
> pinging Wim, akpm may decide to send them up to Linus himself, or akpm
> might re-route them via someone else like me.)

Please indeed Cc: Andrew Morton as well, for the reasons that Russell
explained above.

(The not have very much time means that I have been occupied with our
new house. We moved 15th of august and we still have some small details
to fix (like electricity, the basics for the garden so that the kids can
play safely enough, some plumbing work, ...). But the good news is that
we allready moved and that we are getting there.
On the other hand I have now an extra constraint due to the fact that I
was fired at work 3 weeks ago and that I thus have to find a new job...)

Greetings,
Wim.

