From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Fri, 17 Oct 2008 12:54:39 +0300
Message-ID: <20081017095439.GM3812@gandalf.research.nokia.com>
References: <20081010120427.GZ3044@atomide.com> <200810161243.41079.david-b@pacbell.net> <D944DB09-436B-4549-8D61-EAC385290F26@student.utwente.nl> <200810161346.08862.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47575 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYJQJzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 05:55:42 -0400
Content-Disposition: inline
In-Reply-To: <200810161346.08862.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thu, Oct 16, 2008 at 01:46:08PM -0700, David Brownell wrote:
> On Thursday 16 October 2008, Koen Kooi wrote:
> > > The MUSB transceiver-level issues I was aware of (mostly
> > > on Overo, but minor glitches on Beagle) now seem to be
> > > fixed by the combination of the IRQ patches I sent last
> > > week, plus the twl4030-usb patch I just sent.
> > 
> > Does your patch also make OTG cable detect work?
> 
> I'm not entirely sure what you mean by that ...
> 
> For an OTG connector there are four states of note:
> 
>  (1) Nothing connected
>  (2) There's a B-connector
> 	(2a) with nothing on the other end, same as (1)
> 	(2b) with a host on the other end, suppling VBUS
>  (3) There's an A-connector, grounding the ID pin
> 	(3a) with nothing on the other end,
> 	(3b) with a periphereral pulling up D+ or D-
> 
> That patch uses the STS_HW_CONDITIONS register to detect
> those three basic states ...
> 
> Now, whether the musb_hdrc code handles both (3a) and (3b)
> correctly is another issue.  Recently it only handled the
> (3b) case, which is what I tend to use.
> 
> On this go-around I didn't test the (3a) case.  If that
> starts to work, great; but I was focussing on fixing the
> regresssions.  Does it work for you?  (So you can plug
> in a B-device to the other end, "later"?)

In that case, if we have nothing connected on the other end, there's not
much to do besides xceiv.state = OTG_STATE_A_IDLE; It won't be useful to
start sourcing vbus since there's nothing to use it and we'd just spend
battery for nothing.

-- 
balbi
