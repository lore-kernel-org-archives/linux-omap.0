From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Patch for proper Cortex-A8 cache configuration output
Date: Thu, 11 Sep 2008 09:45:43 +0100
Message-ID: <20080911084543.GB26078@flint.arm.linux.org.uk>
References: <489B24DA.4020008@googlemail.com> <20080808104007.GU24923@atomide.com> <20080910232807.GP21163@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45209 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYIKIqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 04:46:03 -0400
Content-Disposition: inline
In-Reply-To: <20080910232807.GP21163@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

On Wed, Sep 10, 2008 at 04:28:07PM -0700, Tony Lindgren wrote:
> I guess Catalin will submit his patch at some point after 2.6.28 opens.
> I'll apply it l-o tree, and remove the L2 debug info we had in id.c
> to clean up id.c in the future patches.

As I've said on the main ARM lists where I've given reasons, I'm against
extending this stuff, and it is my intention to remove it completely.
It was only added because it was relatively simple and easy to print the
information.

However, with ARMs attitude of breaking configuration register formats
willy nilly, it's just not worth having the additional complexity to
try to work out which format we have, and decode that format.

For all we know, come the next ARM architecture revision, these registers
will have completely changed their format again.  So much for providing
software with an easy way to determine the parameters of the core.

It's just not worth the complexity and effort to try and decode this
information for no other purpose than a few printk's.
