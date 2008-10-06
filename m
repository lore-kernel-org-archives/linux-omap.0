From: David Brownell <david-b@pacbell.net>
Subject: Re: Current git head oops'es at boot on Overo
Date: Mon, 6 Oct 2008 14:39:19 -0700
Message-ID: <200810061439.19486.david-b@pacbell.net>
References: <5e088bd90810061126g75ff7768k8fa768751a31e379@mail.gmail.com> <5e088bd90810061404r76001744w4bc094cbd98077f@mail.gmail.com> <e5e6ade50810061415k60d77010x8f46be8835b6830d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:24911 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753251AbYJFVjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Oct 2008 17:39:21 -0400
In-Reply-To: <e5e6ade50810061415k60d77010x8f46be8835b6830d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nathan Monson <nmonson@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Monday 06 October 2008, Nathan Monson wrote:
> I'm set up as host, using a BeagleBoard, and with the current
> linux-omap git I can get USB working by unplugging and replugging the
> A side of the cable (at the mini-AB connector on the BeagleBoard).
> 
> Just disconnecting the cable at the B side is not enough.  It must
> have something to do with the ID pin.  So, if you have a soldered ID
> pin it wouldn't work either.

Right.  That's a bug in the transciever support, note ... on
host side there are TWO relevant cable events:  ID pin grounded,
and D+/D- rising.  It only understands the former for now, and
doesn't check for the state very well unless poked by an IRQ.

(All that can be a PITA to get right.  It helps to have a cable
tester that will let you do things like switch the ID ground,
apply a variable VBUS load, apply D+/D- pullups/pulldowns,
and so on.)


> Also, my cable is going into a powered 4 port high speed hub.  That
> might make a difference.

That's what I was doing too.  It's a common setup ... just a
bit easier to preconfigure networking that way than through
a bridgede configuration.

- Dave

