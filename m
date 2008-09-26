From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 12:45:44 -0700
Message-ID: <200809261245.44612.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809261200.30728.david-b@pacbell.net> <5e088bd90809261210x61bbd07ey6742dfd13180073f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:46089 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753876AbYIZTpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 15:45:46 -0400
In-Reply-To: <5e088bd90809261210x61bbd07ey6742dfd13180073f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Friday 26 September 2008, Steve Sakoman wrote:
> On Fri, Sep 26, 2008 at 12:00 PM, David Brownell <david-b@pacbell.net> wrote:
> > And after applying this, and removing MADC config from
> > the Beagle and Overo board setup files, things worked!!
> 
> That's really great news!

Yeah ... once Tony merges these ten patches, and the core
gets relocated (I'll do that patch) we're nearly ready to
submit the core upstream.  For the 2.6.28 merge window!
(Then the other function drivers can follow...)


> > Moreover ... the USB host code worked, at least partially.
> > (Finally!  RC7.)  It enumerated the external hub, and the
> > Ethernet adapter hooked up to it.
> 
> Just to clarify -- you are referring to musb host code, correct?

Yes.  Plus a few minor cleanup patches, none changing MUSB
behavior except in terms of diagnostics (unless you're faced
with a bogus board config).

- Dave

