From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 1/3] ARM: OMAP: Beagle: revision detection
Date: Thu, 23 Sep 2010 10:26:31 -0700
Message-ID: <20100923172631.GN4211@atomide.com>
References: <1282271926-2676-1-git-send-email-robertcnelson@gmail.com>
 <20100820150328.c18681ce.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59433 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0IWR0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 13:26:33 -0400
Content-Disposition: inline
In-Reply-To: <20100820150328.c18681ce.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jhnikula@gmail.com> [100820 04:55]:
> On Thu, 19 Aug 2010 21:38:44 -0500
> Robert Nelson <robertcnelson@gmail.com> wrote:
> 
> > Due to the omap3530 ES3.0 Silicon being used on both the
> > B5/B6 and C1/2/3 Beagle we can't use the cpu_is_omap34xx() 
> > routines to differentiate the Beagle Boards.
> > 
> > However gpio pins 171,172,173 where setup for this prupose, so 
> > lets use them.
> > 
> > Changes:
> > for older U-Boot's, use omap_mux_init_gpio()
> > keep Beagle Rev in board-omap3beagle.c
> > gpio_free on gpio request failure
> > 
> > Tested on Beagle Revisions: B5, C2, C4, and xMA
> > 
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > Cc: Jarkko Nikula <jhnikula@gmail.com>
> > ---
> 
> To this set:
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Adding all three.

Tony
