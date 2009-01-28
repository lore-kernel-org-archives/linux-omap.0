From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Wed, 28 Jan 2009 19:41:56 +0000
Message-ID: <20090128194156.GH23301@n2100.arm.linux.org.uk>
References: <20090128144955.GA23089@n2100.arm.linux.org.uk> <20090128.172951.193700554.Hiroshi.DOYU@nokia.com> <20090128175043.GB23301@n2100.arm.linux.org.uk> <20090128.212122.193700100.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36172 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZA1TmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 14:42:10 -0500
Content-Disposition: inline
In-Reply-To: <20090128.212122.193700100.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 09:21:22PM +0200, Hiroshi DOYU wrote:
> It seems that I misunderstood your comment in the following mail.
> 
> http://lkml.indiana.edu/hypermail/linux/kernel/0901.2/00610.html

Ah, that comment was more about that specific include in that specific
file - I couldn't see anything in there which required it.

The general rule is: if both asm/xxx.h and linux/xxx.h exists, then use
the linux/xxx.h version.  I stress _general_ rule - there are exceptions.
For example, linux/irq.h and linux/memory.h.  A clue would be if linux/xxx.h
doesn't include asm/xxx.h, then the rule above probably doesn't apply.

> Reverted both header file changes. Update attached patches.

Much better, thanks.  This I'm happy with.
