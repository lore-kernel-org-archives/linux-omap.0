From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-omap-git 0/4] start phasing out legacy GPIO calls
Date: Fri, 24 Oct 2008 00:38:12 -0700
Message-ID: <200810240038.12838.david-b@pacbell.net>
References: <200810222350.54467.david-b@pacbell.net> <20081024095103.45791f94.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:30406 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751203AbYJXHiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2008 03:38:15 -0400
In-Reply-To: <20081024095103.45791f94.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thursday 23 October 2008, Jarkko Nikula wrote:
> 
> Hi David
> 
> Did you know what? I was doing something like similar conversion patches
> just few days ago but didn't find yet time to finalize them and fix
> arch/arm/plat-omap/gpio.c for omap_[request | free]_gpio :-)

Sounds ... oddly familiar.  :)

 
> My set was basically doing all gpiolib conversions in one patch and the
> set was grouped so that one patch for all OMAP1 boards (all of them are
> in mainline), separate patches for couple OMAP2 boards and some random
> patches for different drivers.

I've found that splitting such API changes into blatantly obvious
chunks that make the same repetitive change is a big win in terms
of reviewability and buglessness.  The first two patches (get/set,
direction_in) show that well.  The other two followed naturally from
that start, but weren't as brainless.  The request/free stuff needed
some actual thought, so I deferred it...

Did you find anything wrong with these patches?

 
> I can add omap_request_gpio/omap_free_gpio conversion patch on top of
> yours but probably that will go somewhere next week. Useful conversion
> due label argument in gpio_request :-)

The label is handy for auditing /sys/kernel/debug/gpio against
board schematics, for sure ... a little cross-checking can be a
big help.  "Whoops, we must have overlooked <mechanism-X/> ..."
Also helps code maintainability a bit, IMO!

I'd split that work in two phases:

 - First a set of gpio_chip.request() and gpio_chip.free() hooks
   to make the standard calls *exactly* like the legacy ones,
   and replacing the legacy calls with inlined wrappers;

 - Then then lots of syntactic changes to use the new calls,
   providing labels and then removing those wrappers.

If you'd like to do those parts, OK by me.  Splitting things
out into different gpio_chip flavors can be done in parallel
with the second set of patches.

I wasn't planning to touch that stuff for a bit ... like until
after Tony merges 2.6.28-rc1 (it's out now) and the $SUBJECT
patches into the OMAP tree.

- Dave


> 
> 
> Jarkko
> 
> 


