From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 14:49:39 -0700
Message-ID: <20130430214939.GD28721@atomide.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201304301304.20650.arnd@arndb.de>
 <20130430161104.GB26257@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10680 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933713Ab3D3Vtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 17:49:46 -0400
Content-Disposition: inline
In-Reply-To: <20130430161104.GB26257@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>

* Tony Lindgren <tony@atomide.com> [130430 09:19]:
> * Arnd Bergmann <arnd@arndb.de> [130430 04:10]:
> > On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> > > Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> > > great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> > > arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> > > source of errors.
> > 
> > Yes, I noticed this but haven't gotten around to prepare a patch. I'll comment
> > below.
> > 
> > > OMAP stuff needs a serious look at too - much Kconfig madness there
> > > caused by over-use of select, which then goes on to cause build errors
> > > because it assumes some stuff is always enabled.
> 
> I have posted a few randconfig fixes in "[PATCH 0/3] few omap randconfig
> fixes for v3.10" that also remove the select of SERIAL_OMAP that I missed
> while fixing the 8250 issue. I was planning to send a pull request after
> the merge window, but can do it now too if people prefer that.

I'll apply only the SERIAL_OMAP fix into omap-for-v3.10/fixes-randconfig
against v3.9-rc7 as the two other warning fixes depend on other branches
and can be merged after -rc1.
  
> > Ack. I have not looked much at randconfig output, but this has certianly
> > grown worse after CONFIG_ARCH_OMAP has gotten included in ARCH_MULTIPLATFORM
> 
> I have a patch coming for the "no SoC selected" randconfig issue as
> discussed in the "linux-next ARM multi-platform randconfig errors"
> thread. I suggest we do the minimal fix I already posted for now,
> then reorganize more of the Makefile as Arnd suggested for v3.11.

Got the fix for "no SoC selected" boiled down to a minimal Makefile only
fix as Arnd suggested, will post shortly.

Regards,

Tony
