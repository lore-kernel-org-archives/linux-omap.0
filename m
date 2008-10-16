From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.27, some issues remain
Date: Thu, 16 Oct 2008 13:46:08 -0700
Message-ID: <200810161346.08862.david-b@pacbell.net>
References: <20081010120427.GZ3044@atomide.com> <200810161243.41079.david-b@pacbell.net> <D944DB09-436B-4549-8D61-EAC385290F26@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:26505 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754409AbYJPUqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Oct 2008 16:46:11 -0400
In-Reply-To: <D944DB09-436B-4549-8D61-EAC385290F26@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Thursday 16 October 2008, Koen Kooi wrote:
> > The MUSB transceiver-level issues I was aware of (mostly
> > on Overo, but minor glitches on Beagle) now seem to be
> > fixed by the combination of the IRQ patches I sent last
> > week, plus the twl4030-usb patch I just sent.
> 
> Does your patch also make OTG cable detect work?

I'm not entirely sure what you mean by that ...

For an OTG connector there are four states of note:

 (1) Nothing connected
 (2) There's a B-connector
	(2a) with nothing on the other end, same as (1)
	(2b) with a host on the other end, suppling VBUS
 (3) There's an A-connector, grounding the ID pin
	(3a) with nothing on the other end,
	(3b) with a periphereral pulling up D+ or D-

That patch uses the STS_HW_CONDITIONS register to detect
those three basic states ...

Now, whether the musb_hdrc code handles both (3a) and (3b)
correctly is another issue.  Recently it only handled the
(3b) case, which is what I tend to use.

On this go-around I didn't test the (3a) case.  If that
starts to work, great; but I was focussing on fixing the
regresssions.  Does it work for you?  (So you can plug
in a B-device to the other end, "later"?)

- Dave

