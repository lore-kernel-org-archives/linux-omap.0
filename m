From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [patch 2.6.27-omap-git 0/4] start phasing out legacy GPIO calls
Date: Fri, 24 Oct 2008 11:42:08 +0300
Message-ID: <20081024114208.5d8493ed.jarkko.nikula@nokia.com>
References: <200810222350.54467.david-b@pacbell.net>
	<20081024095103.45791f94.jarkko.nikula@nokia.com>
	<200810240038.12838.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57156 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbYJXInA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 04:43:00 -0400
In-Reply-To: <200810240038.12838.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, 24 Oct 2008 00:38:12 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> > My set was basically doing all gpiolib conversions in one patch and the
> > set was grouped so that one patch for all OMAP1 boards (all of them are
> > in mainline), separate patches for couple OMAP2 boards and some random
> > patches for different drivers.
> 
> I've found that splitting such API changes into blatantly obvious
> chunks that make the same repetitive change is a big win in terms
> of reviewability and buglessness.  The first two patches (get/set,
> direction_in) show that well.  The other two followed naturally from
> that start, but weren't as brainless.  The request/free stuff needed
> some actual thought, so I deferred it...
> 
> Did you find anything wrong with these patches?
> 
Nope. My way was just bit more lazy by doing all changes into one file
at once and by separating patches so that it's easier for Tony to get
them forward.

> I'd split that work in two phases:
> 
>  - First a set of gpio_chip.request() and gpio_chip.free() hooks
>    to make the standard calls *exactly* like the legacy ones,
>    and replacing the legacy calls with inlined wrappers;
> 
>  - Then then lots of syntactic changes to use the new calls,
>    providing labels and then removing those wrappers.
> 
> If you'd like to do those parts, OK by me.  Splitting things
> out into different gpio_chip flavors can be done in parallel
> with the second set of patches.
> 
Yeah, I'll try to look next week.


Jarkko
