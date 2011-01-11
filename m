From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/5] OMAP: clockdomain: Arch specific funcs to handle
 deps
Date: Mon, 10 Jan 2011 18:32:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101808530.5731@utopia.booyaka.com>
References: <1294237365-10893-1-git-send-email-rnayak@ti.com> <1294237365-10893-2-git-send-email-rnayak@ti.com> <1294237365-10893-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53531 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab1AKBcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 20:32:09 -0500
In-Reply-To: <1294237365-10893-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

On Wed, 5 Jan 2011, Rajendra Nayak wrote:

> Define the following architecture specific funtions for omap2/3
> .clkdm_add_wkdep
> .clkdm_del_wkdep
> .clkdm_read_wkdep
> .clkdm_clear_all_wkdeps
> .clkdm_add_sleepdep
> .clkdm_del_sleepdep
> .clkdm_read_sleepdep
> .clkdm_clear_all_sleepdeps
> 
> Convert the platform-independent framework to call these functions.
> With this also move the clkdm lookups for all wkdep_srcs and
> sleepdep_srcs at clkdm_init.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                     |    2 +
>  arch/arm/mach-omap2/clockdomain.c                |   80 ++++++---------
>  arch/arm/mach-omap2/clockdomain.h                |    2 +
>  arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |  113 ++++++++++++++++++++++
>  arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    2 +-

This is definitely a good start, but a lot of OMAP4 stuff still needs 
to be done.

For example, OMAP4 has static wakeup dependencies just like OMAP2/3; 
described in section 3.1.1.1.7.3 "Wake-Up Dependency" of the OMAP4430 TRM 
Rev. L.

OMAP4 also has static sleep dependencies just like OMAP3; described in 
section 3.1.1.1.7.1 "Static Dependency" of the OMAP4430 TRM
Rev. L.

The dynamic wakeup dependencies (section 3.1.1.1.7.2 of the TRM) and the 
hardware inactivity timer are new for OMAP4.

What's the plan to add support for these?

Based on a brief look, it would seem to make sense to add support now for 
static sleep dependencies.  These seem quite similar to the OMAP3 
implementation, in that they are between clockdomains.

Dynamic wakeup dependencies and the prescaler timer configuration should 
be fairly easy to add since it is a new feature, and thus no OMAP2/3 
implementation is needed.  The dyndep stuff is between clockdomains, so 
there shouldn't be any interaction needed with the hwmod code by my 
reading.

Static wakeup dependency support appears a little more tricky, since the 
dependencies are between modules and clockdomains on OMAP4, rather than 
between clockdomains and clockdomains as they were on OMAP2/3.  One way to 
handle this would be to change the existing wkdep interface for all OMAPs 
to be between modules and clockdomains; then for the OMAP2/3 
implementations, use the hwmod code/data to get the clockdomain of the 
module's main_clk.  Another is to add a separate interface to add wkdeps 
between a module and clockdomain, use that for OMAP4, but use the existing 
clockdomain-to-clockdomain interface for OMAP2/3.  It might be necessary 
to do both until the hwmod data is more complete, then perhaps phase out 
the latter interface.  Thoughts?


- Paul
