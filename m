From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Tue, 26 Mar 2013 18:43:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303261829440.23957@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>  <51482707.6020501@ti.com> <1363684373.15426.137.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39271 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3CZSnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 14:43:04 -0400
In-Reply-To: <1363684373.15426.137.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi.

On Tue, 19 Mar 2013, Tero Kristo wrote:

> I think you should definitely upgrade your bootloader, the old one you
> are using is prone to cause trouble due to bugs it has, and we have no
> simple way to workaround the issues it causes on kernel side.

So, the kernel should be independent of the bootloader that's used.  Many 
of the rest of us have taken great care to ensure that devices get reset 
to do this.  We've got pretty good coverage on OMAP3 and most of the other 
OMAP4 IP blocks.

You mention that there's no simple way to do it, but as far as I know, no 
one has assessed what's needed to reset the remaining devices.  Or if 
someone has this information, it hasn't been shared here - please do so.

So what I'd like you to do is:

1. Determine what devices are remaining to be reset and idled on OMAP4 
   with the bootloader that I use.  As far as I know, there are only four 
   that block full-chip idle: M3, DSP, SL2IF, FSUSB

2. Determine what's needed to reset and idle them.  For the M3 and DSP, 
   I'd assume this involves pointing the reset vector for those 
   processors at a few lines of code that basically enter WFI or the C64x 
   equivalent.

3. At this point, we can determine the difficulty level of the task.

4. Then, assuming it's of the level described in step 2, that reset/idle 
   code should be implemented.

This process will ensure both that users with "old" OMAP4 bootloaders -- 
really, u-boot versions distributed less than a year ago, so not very old 
at all -- will be able to successfully enter chip low power states.  It 
will also ensure that users who boot to new kernels with kexec will be 
able to do so successfully, with a minimum of interference from other 
devices.


- Paul
