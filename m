From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 PM bootloader dependency problems
Date: Wed, 30 Jan 2013 17:15:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3A3RPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 12:15:07 -0500
In-Reply-To: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi Tero et al.,

On Tue, 22 Jan 2013, Paul Walmsley wrote:

> As we've discussed, there are known bootloader dependencies with the OMAP4 
> PM retention idle code, introduced in v3.8.  Boards booted with u-boot 
> versions even as recent as 2011 won't enter retention idle correctly; for 
> example:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/pm/4430es2panda/4430es2panda_log.txt

...

> Barring that, what I'd like to see is a patch for v3.8-rc fixes that adds 
> a warning, printed to the kernel console, during boot.  The warning should 
> state that the OMAP4 PM code only works with certain bootloaders, and 
> should identify the minimum u-boot release needed for OMAP4 full-chip 
> retention idle to work.

Any progress on this one?  Time is getting very short to get this into 
v3.8-rc fixes, and it's important to get this into v3.8 so we don't 
have users expecting chip power management to work correctly with most 
u-boot versions that are out in the field.

All we should need for v3.8-rc are a few pr_warn()s that execute during 
OMAP4 PM init, noting that the OMAP4 chip power management doesn't work 
correctly with many bootloaders, due to missing code in the kernel to 
properly reset and initialize some devices, and noting the first u-boot 
version that is known to work correctly.

Otherwise there's a very real risk that folks out there will waste lots of 
time trying to figure out why power management doesn't work as they 
expect.   To respect our users, we shouldn't put them in that situation.


- Paul
