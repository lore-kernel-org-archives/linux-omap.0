From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime
 PM status
Date: Tue, 16 Oct 2012 19:14:43 -0700
Message-ID: <20121017021442.GQ15569@atomide.com>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
 <20121016102517.GD21801@arwen.pp.htv.fi>
 <20121016211828.GL15569@atomide.com>
 <87wqyplxjo.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13367 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755930Ab2JQCOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 22:14:47 -0400
Content-Disposition: inline
In-Reply-To: <87wqyplxjo.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [121016 18:04]:
> 
> Doh, this isn't quite right yet.  Some more PM testing shows that UART
> wakeups are broken, so this isn't ready for v3.7 yet.

OK I'll drop it then.

Tony
