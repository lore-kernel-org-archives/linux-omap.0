From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module
 support
Date: Tue, 29 Mar 2011 10:01:13 -0700
Message-ID: <20110329170113.GG4016@atomide.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
 <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
 <20110328205027.GC30616@atomide.com>
 <5cbdd88c3ca3fe5c5a0f119be446ce99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab1C2RBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:01:17 -0400
Content-Disposition: inline
In-Reply-To: <5cbdd88c3ca3fe5c5a0f119be446ce99@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 22:47]:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> >
> > Do you really need to initialize all of this that early?
> >
> Yes. It's a interrupt controller extension and needs to work
> together with GIC.

Hmm to me it seems that the gic_arch_extn functions should be
all NULL during runtime operation, and the wake-up generator
should be programmed only before entering an idle state.

Then the wake-up generator can be cleared after delivering
the wake-up event(s).

Or am I missing something on why this should be enabled all
the time?

BTW, looks like you got few typos in the comments in this
patch, noticed these while reading:

Hardware requirements is
GIC rgeisters
gic architecture specific fucntioms

I know I'm making tons of typos too ;)

Tony
