From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] CBUS Patches
Date: Tue, 14 Jun 2011 06:11:39 -0700
Message-ID: <20110614131139.GE23145@atomide.com>
References: <1307994058-25486-1-git-send-email-balbi@ti.com>
 <20110614100643.GM3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:50771 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751892Ab1FNNLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 09:11:42 -0400
Content-Disposition: inline
In-Reply-To: <20110614100643.GM3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [110614 03:02]:
> * Felipe Balbi <balbi@ti.com> [110613 12:36]:
> > Hi Tony,
> > 
> > the following two patches get rid of
> > the static global variable holding the
> > bus context. It's not needed at all.
> > 
> > This will allow us to have multiple
> > CBUS buses by using different GPIOs.
> > 
> > Will never be useful, but that's it
> > should've been done anyway :-p
> 
> OK cool applying to cbus branch.

Hmm the second patch "cbus: pass device as argument" breaks
booting on n800. Anyways pushed out already so that will
need to be fixed in a separate patch.

Tony
