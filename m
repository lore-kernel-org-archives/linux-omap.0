From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 18 Mar 2011 00:09:35 -0700
Message-ID: <20110318070935.GC3555@atomide.com>
References: <20110317183048.GW7258@atomide.com>
 <AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10653 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1CRHJi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 03:09:38 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [110317 20:00]:
> On Thu, Mar 17, 2011 at 11:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Please pull omap changes for this merge window from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-for-linus
> 
> Btw, that "generic hardware spinlock" thing needs to be hidden from
> sane people and architectures that don't need it.
> 
> Make platforms that need it "select" it or something. It looks like
> nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
> question, SO DON'T ASK IT!

No problem, let's make it depends on OMAP4.

Regards,

Tony
