From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: Re: [PATCH 0/2] OMAP3: PM: More pedantic parameter and error
	checking in smartreflex
Date: Thu, 14 May 2009 11:03:59 +0300
Message-ID: <1242288239.9103.123.camel@pcarmody-desktop>
References: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
	 <87bppx82du.fsf@deeprootsystems.com>
	 <1242228960.9103.119.camel@pcarmody-desktop>
	 <87ab5h6j06.fsf@deeprootsystems.com>
Reply-To: ext-phil.2.carmody@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53258 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbZENIDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 04:03:18 -0400
In-Reply-To: <87ab5h6j06.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-05-13 at 18:54 +0200, ext Kevin Hilman wrote:
> Phil Carmody <ext-phil.2.carmody@nokia.com> writes:
> 
> > On Wed, 2009-05-13 at 17:10 +0200, ext Kevin Hilman wrote:
> >> Phil Carmody <ext-phil.2.carmody@nokia.com> writes:
> >> 
> >> > A couple of simple patches to improve error handling in smartreflex.
> >> > The first has a practical benefit of avoiding a string-based search
> >> > in situtations where the result wouldn't be needed. The second is
> >> > simple paranoia.
> >> 
> >> Thanks, pushing this series today.
> >> 
> >> Note that I pushed this on top of Rajendra's patch:
> >> "OMAP3: SR: Fix SR driver to check for omap-pm return values"
> >> and had to resolve a couple of conflicts.
> >> 
> >> Could you please sanity check it?
> >
> > Sanity check successful. Many thanks, Kevin.
> 
> Hmm, you're too fast for me.

It's the time zone difference! 

> Not sure how you tested as I hadn't pushed your changes yet ;)
>
> I just pushed them to my pm branch, but they are not yet sync'd to
> tony's tree.  Can you try now.

Freshly pulled, indeed I now see the extent of the rework. I don't know
whether -ENODEV or -EINVAL is better, the former just came to mind first
when I was in the file.

Either way, it looks fine. Thanks again.

Phil

