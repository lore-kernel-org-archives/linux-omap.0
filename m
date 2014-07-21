From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM3517 fails to boot 3.16-rc5 device tree kernel
Date: Mon, 21 Jul 2014 00:17:23 -0700
Message-ID: <20140721071723.GO18374@atomide.com>
References: <20140717234037.GA9660@sysresccd>
 <20140718063806.GK18374@atomide.com>
 <CAO5Z=i1WdcrwWP2F6XZimUD5ts66AsV3RrvA31g71aUJewbNJA@mail.gmail.com>
 <20140718150253.GA27360@sysresccd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54123 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753438AbaGUHSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 03:18:47 -0400
Content-Disposition: inline
In-Reply-To: <20140718150253.GA27360@sysresccd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@emacinc.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>, paul@pwsan.com

* Michael Welling <mwelling@emacinc.com> [140718 08:05]:
> On Fri, Jul 18, 2014 at 09:40:48AM -0500, Michael Welling wrote:
> > On Fri, Jul 18, 2014 at 1:38 AM, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Can you please enable debug_ll + earlyprintk and pass also earlyprintk
> > > in the kernel cmdline?
> > I will try this.
> 
> Adding the earlyprintk did not work. It still hangs without any
> messages.

If you have it enabled for the wrong UART it will always hang..
Maybe check you have the right port? 

> > > Hmm maybe double check your're booting device tree based kernel
> > > instead of legacy machine ID based kernel? The legacy booting should
> > > still work just fine and no changes has been made to it, but it will
> > > get removed shortly.
> 
> How do you determine which you are booting?

Looking at the dmesg, the earliest point you'll see it is from
"Machine model: " line, that's most likely different than for
legacy booting :)

And later on you'll see some DT only drivers get initialized
properly like pinctrl-single:

pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
...

Regards,

Tony
