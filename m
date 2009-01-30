From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH D 11/11] Fix omap1 clock issues
Date: Fri, 30 Jan 2009 00:58:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901300057360.26985@utopia.booyaka.com>
References: <20090128191638.16688.33452.stgit@localhost.localdomain> <20090128191844.16688.39372.stgit@localhost.localdomain> <20090129143733.GB18233@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42417 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZA3H6S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 02:58:18 -0500
In-Reply-To: <20090129143733.GB18233@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, 29 Jan 2009, Russell King - ARM Linux wrote:

> On Wed, Jan 28, 2009 at 12:18:48PM -0700, Paul Walmsley wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > This fixes booting, and is a step toward fixing things properly:
> > 
> > - Make enable_reg u32 instead of u16
> 
> No, you're passing this to __raw_read/write, so it needs to be
> void __iomem *, not u32.  If there's another patch doing that it
> needs to be combined with this one.  The miniscule details of
> fixes upon fixes aren't interesting for submission purposes, and
> just adds extra unnecessary review load for upstream people.
> 
> Ditto for anything else which is passed to __raw_read/write*.

Will build a revised patch for this and pass it to Tony for a boot test, 
then repost.

- Paul
