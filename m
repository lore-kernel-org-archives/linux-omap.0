From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 2/4] OMAP4: Keyboard: Fix section mismatch in the
 board file
Date: Wed, 28 Sep 2011 11:26:33 -0700
Message-ID: <20110928182633.GA6324@atomide.com>
References: <CAFULf_zAqFGcUfgfOMyrm8DLJhg1qXG+48W5u+pjBUwa=PmrRg@mail.gmail.com>
 <CAFULf_x_7GXMRY_rNDFk377R-ZWSOvM5KBqOe0a4cYbzGARnYA@mail.gmail.com>
 <20110816065332.GC2305@legolas.emea.dhcp.ti.com>
 <CAFULf_yWUwSf8kgtJmMeNx04axG1FoRBAy2b=ApYjGfcEvvAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51512 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753615Ab1I1S0f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 14:26:35 -0400
Content-Disposition: inline
In-Reply-To: <CAFULf_yWUwSf8kgtJmMeNx04axG1FoRBAy2b=ApYjGfcEvvAhg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bjarne Steinsbo <bsteinsbo@gmail.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com

* Bjarne Steinsbo <bsteinsbo@gmail.com> [110913 23:39]:
> I can't see this one queued up anywhere.  Did it just slip through the
> cracks, or are there any problems with it?

Just slipped through the cracks.. Adding into fixes thanks.

Tony
 
> BR,
> 
> Bjarne Steinsbo
> 
> On Tue, Aug 16, 2011 at 8:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Aug 12, 2011 at 05:27:52PM +0200, Bjarne Steinsbo wrote:
> >> `keypad_pads' is referred to by `keypad_data' which is
> >> not __initdata, so `keypad_pads' should not be __initdata either.
> >>
> >> Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
> >
> > Reviewed-by: Felipe Balbi <balbi@ti.com>
> >
> > --
> > balbi
> >
