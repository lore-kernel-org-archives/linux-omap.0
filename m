From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: arm: omap3: pm34xx.c: Some minor fixups
Date: Thu, 15 Mar 2012 10:39:23 -0700
Message-ID: <20120315173923.GA9205@animalcreek.com>
References: <1331828441-1406-1-git-send-email-mgreer@animalcreek.com>
 <87pqcdbwpu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:60310 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab2CORjY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 13:39:24 -0400
Content-Disposition: inline
In-Reply-To: <87pqcdbwpu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 15, 2012 at 10:27:57AM -0700, Kevin Hilman wrote:
> Hi Mark,
> 
> "Mark A. Greer" <mgreeraz@gmail.com> writes:
> 
> > found a some minor issues when looking through pm34xx.c recently
> > so these patches try to address them.  My apologies if they are already
> > fixed in another branch somewhere.  Based on latest k.o. master branch.
> 
> Thanks for the fixes, they look right.
> 
> Minor nit: can you resend with linux-arm-kernel in Cc?  Any
> upstream-bound patches need to be Cc'd there so the maintainers don't
> have to resend them there before submitting a pull request.

Sure.  I also have a stray ':' in the Subject of one of them so I'll fix
and resend (with fixed 'From:' line too).

Mark
--
