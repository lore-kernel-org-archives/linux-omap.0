From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Thu, 31 Jan 2013 11:00:29 +0200
Message-ID: <1359622829.10415.40.camel@sokoban>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
	 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab3AaJAh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 04:00:37 -0500
In-Reply-To: <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

On Wed, 2013-01-30 at 17:15 +0000, Paul Walmsley wrote:
> Hi Tero et al.,
> 
> On Tue, 22 Jan 2013, Paul Walmsley wrote:
> 
> > As we've discussed, there are known bootloader dependencies with the OMAP4 
> > PM retention idle code, introduced in v3.8.  Boards booted with u-boot 
> > versions even as recent as 2011 won't enter retention idle correctly; for 
> > example:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/pm/4430es2panda/4430es2panda_log.txt
> 
> ...
> 
> > Barring that, what I'd like to see is a patch for v3.8-rc fixes that adds 
> > a warning, printed to the kernel console, during boot.  The warning should 
> > state that the OMAP4 PM code only works with certain bootloaders, and 
> > should identify the minimum u-boot release needed for OMAP4 full-chip 
> > retention idle to work.
> 
> Any progress on this one?  Time is getting very short to get this into 
> v3.8-rc fixes, and it's important to get this into v3.8 so we don't 
> have users expecting chip power management to work correctly with most 
> u-boot versions that are out in the field.
> 
> All we should need for v3.8-rc are a few pr_warn()s that execute during 
> OMAP4 PM init, noting that the OMAP4 chip power management doesn't work 
> correctly with many bootloaders, due to missing code in the kernel to 
> properly reset and initialize some devices, and noting the first u-boot 
> version that is known to work correctly.

Personally I don't like too much to have just extra spam during boot,
which in many cases is even unnecessary (e.g. people who actually have
good u-boot in use.) Personally I would like to have some sort of test
during boot which detects broken PM and maybe prevents core idle
completely if this is the case. Alternatively we can add extra info to
the failed suspend dump and mention a good u-boot to try out (v2012-07
or newer.)

If we could detect boot loader version from kernel side, that would work
also.

-Tero

> 
> Otherwise there's a very real risk that folks out there will waste lots of 
> time trying to figure out why power management doesn't work as they 
> expect.   To respect our users, we shouldn't put them in that situation.
> 
> 
> - Paul


