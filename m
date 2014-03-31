From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 58/75] ARM: l2c: omap2: remove cache size override
Date: Mon, 31 Mar 2014 11:55:49 +0100
Message-ID: <20140331105549.GF27282@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk> <E1WTYZ1-0007Gn-3J@rmk-PC.arm.linux.org.uk> <20140328160358.GG24308@atomide.com> <20140328210945.GU7528@n2100.arm.linux.org.uk> <20140328222159.GB30388@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:43579 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752041AbaCaK4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 06:56:14 -0400
Content-Disposition: inline
In-Reply-To: <20140328222159.GB30388@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Mar 28, 2014 at 03:21:59PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140328 14:13]:
> > On Fri, Mar 28, 2014 at 09:03:59AM -0700, Tony Lindgren wrote:
> > > * Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> > > 
> > > Missing description?
> > 
> > No, I just got sick and tired of trying to write descriptions for these
> > patches.  Many of these I regard as totally unnecessary patches that
> > should never have been required had platform folk not invested in
> > cargo cult programming.
> > 
> > Given the number of patches I'm presently dealing with in my tree right
> > now, I don't actually have time to even follow the mailing lists at the
> > moment.  If I were to properly describe all of these patches, I'd
> > probably be at this for another few weeks.
> 
> Heh well I have a feeling you'll add some generic description anyways :)

If I end up merging each of these patches removingthe cache override
together into one commit touching many of the SoCs, then yes.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
