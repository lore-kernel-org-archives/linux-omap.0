From: David Brownell <david-b@pacbell.net>
Subject: Re: Preempt-RT on OMAP3?
Date: Mon, 6 Apr 2009 03:25:45 -0700
Message-ID: <200904060325.45758.david-b@pacbell.net>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:45551 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754826AbZDFKZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 06:25:48 -0400
In-Reply-To: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sunday 05 April 2009, Hugo Vincent wrote:
> I'm trying to get the realtime patch set to work on OMAP3 (Gumstix
> Overo). Linux-omap 2.6.29 with the RT patches -rt1 or -rt2 work mostly
> as is (MUSB and the usb-gadget layer have quite a few problems, and

Like what?  Way back in 2.6.10 MUSB behaved relatively sanely.
But that's a while back.  ;)


> the realtime self-test stuff picks up a few problems to do with
> spinlock usage etc, but most things seem to mostly work correctly for
> my needs). Running cyclictest with various types of loads gives an
> average latency of ~30-50 usec and worst case up around 300 usec.


