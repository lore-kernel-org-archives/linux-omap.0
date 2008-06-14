From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 21/21] ARM: OMAP: Add OMAP chip type structure; clean up mach-omap2/id.c
Date: Sat, 14 Jun 2008 10:22:35 +0100
Message-ID: <20080614092235.GR32122@flint.arm.linux.org.uk>
References: <1212802253-17797-13-git-send-email-tony@atomide.com> <1212802253-17797-14-git-send-email-tony@atomide.com> <1212802253-17797-15-git-send-email-tony@atomide.com> <1212802253-17797-16-git-send-email-tony@atomide.com> <1212802253-17797-17-git-send-email-tony@atomide.com> <1212802253-17797-18-git-send-email-tony@atomide.com> <1212802253-17797-19-git-send-email-tony@atomide.com> <1212802253-17797-20-git-send-email-tony@atomide.com> <1212802253-17797-21-git-send-email-tony@atomide.com> <1212802253-17797-22-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47216 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbYFNJWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 05:22:46 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-22-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:53PM -0700, Tony Lindgren wrote:
> omap_chip is set in mach-omap2/id.c by _set_omap_chip(). Other
> code should use the omap_chip_is() function to test against omap_chip.

> +/**
> + * omap_chip_is - test whether currently running OMAP matches a chip type
> + * @oc: omap_chip_t to test against
> + *
> + * Test whether the currently-running OMAP chip matches the supplied
> + * chip type 'oc'.  Returns 1 upon a match; 0 upon failure.
> + */
> +int omap_chip_is(struct omap_chip_id oci)
> +{
> +	return (oci.oc & omap_chip.oc) ? 1 : 0;
> +}
> +EXPORT_SYMBOL(omap_chip_is);

I've not seen any use cases for this function, so I don't know how it's
intended to be used.  However, is it really sensible for this to take a
structure rather than just a value?
