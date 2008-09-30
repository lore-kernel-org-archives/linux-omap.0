From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 26/25] twl4030 gpio cleanups
Date: Tue, 30 Sep 2008 23:16:11 +0300
Message-ID: <20080930201610.GP2445@frodo>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <200809301249.06778.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39550 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYI3UQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 16:16:21 -0400
Content-Disposition: inline
In-Reply-To: <200809301249.06778.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Sep 30, 2008 at 12:49:06PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Clean up the twl4030-gpio code a bit ... mostly by shrinkage.
> 
> Remove a bunch of macros that are just obfuscating what the
> TWL4030 GPIO code is doing.  Some duplicated standard macros
> like BIT(); others hid trivial math (mask/shift); others were
> completely unused.
> 
> Use BIT() in several places to highlight the bitmasking and
> make the code more compact.
> 
> Remove pointless locking calls, sanity checks, and parenthesis.
> And needless irq_chip.

The code looks much better after you apply the patch.
Great job Dave :-)

-- 
balbi
