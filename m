From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 11:01:44 -0700
Message-ID: <20080903180142.GS23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49391 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYICSB7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 14:01:59 -0400
Content-Disposition: inline
In-Reply-To: <20080902221501.GD23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-omap@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

* Tony Lindgren <tony@atomide.com> [080902 15:16]:
> Hi,
> 
> * David Brownell <david-b@pacbell.net> [080831 14:47]:
> > On Wednesday 27 August 2008, Russell King wrote:

<snip>

> > 
> > So I can try my patch for the omap_udc thing ... even though for
> > OSK the mainline kernel ** DOES NOT BOOT ** and dies even before
> > the kernel "hello, I'm RC5!" banner prints.  Someone with a JTAG
> > to throw at this might be able to fix that regression quickly.
> 
> I'll take a look at the OSK boot problem unless somebody else is
> already working on it.

My OSK is booting just fine here with current mainline and the
omap_osk_5912_defconfig. This is the current head at
2.6.27-rc5-00100-gec0c15a. Have you checked if yours boots with
the mainline omap_osk_5912_defconfig?

Tony
