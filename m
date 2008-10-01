From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 26/25] twl4030 gpio cleanups
Date: Wed, 1 Oct 2008 13:42:58 +0300
Message-ID: <20081001104258.GG15017@atomide.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <200809301249.06778.david-b@pacbell.net> <20080930201610.GP2445@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63901 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYJAKkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20080930201610.GP2445@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [080930 23:16]:
> On Tue, Sep 30, 2008 at 12:49:06PM -0700, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Clean up the twl4030-gpio code a bit ... mostly by shrinkage.
> > 
> > Remove a bunch of macros that are just obfuscating what the
> > TWL4030 GPIO code is doing.  Some duplicated standard macros
> > like BIT(); others hid trivial math (mask/shift); others were
> > completely unused.
> > 
> > Use BIT() in several places to highlight the bitmasking and
> > make the code more compact.
> > 
> > Remove pointless locking calls, sanity checks, and parenthesis.
> > And needless irq_chip.
> 
> The code looks much better after you apply the patch.
> Great job Dave :-)

This pushed too.

Tony
