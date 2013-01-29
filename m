From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: powerdomain/clockdomain: add a
 per-powerdomain spinlock
Date: Tue, 29 Jan 2013 21:13:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301292101230.11442@utopia.booyaka.com>
References: <20121209011755.19716.25244.stgit@dusk.lan> <20121209012340.19716.62316.stgit@dusk.lan> <CAORVsuU3f9sf5Z3cVNeJbEKwc_VPpyYv2LfbXtehaMJRN7wARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40619 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3A2VNx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 16:13:53 -0500
In-Reply-To: <CAORVsuU3f9sf5Z3cVNeJbEKwc_VPpyYv2LfbXtehaMJRN7wARA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi

On Wed, 12 Dec 2012, Jean Pihet wrote:

> On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Add a per-powerdomain spinlock.  Use that instead of the clockdomain
> > spinlock.  Add pwrdm_lock()/pwrdm_unlock() functions to allow other
> > code to acquire or release the powerdomain spinlock without reaching
> > directly into the struct powerdomain.
> >
> Since clockdomains are part of powerdomains it seems weird for the
> clockdomain code to take a powerdoamin lock.

Why?

> Is there a reason why the powerdomain could not take the lock before
> calling the clockdomain functions?

Do you mean "is there a reason why the powerdomain _code_ could not take 
the lock"?  If so, the reason is that code other than the powerdomain code 
calls the clkdm_* functions directly, without calling any powerdomain 
functions first.  So there's really no other place to take the lock unless 
the callers are updated to take the powerdomain lock themselves.  That 
seems like something to avoid if the caller doesn't have any other 
relationship to the powerdomain code.

> Also, are the lock and nolock version the clockdomain function needed?

Did you have a different solution in mind?  The two versions are used for 
code that needs to be called from two contexts: the first with the 
powerdomain's lock already held; the second needing to acquire the 
powerdomain's lock to avoid racing against other PRCM code.


- Paul
