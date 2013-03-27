From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Wed, 27 Mar 2013 11:11:03 +0200
Message-ID: <1364375463.3146.9.camel@sokoban>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
	 <51482707.6020501@ti.com> <1363684373.15426.137.camel@sokoban>
	 <alpine.DEB.2.00.1303261829440.23957@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3C0JLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 05:11:12 -0400
In-Reply-To: <alpine.DEB.2.00.1303261829440.23957@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

On Tue, 2013-03-26 at 18:43 +0000, Paul Walmsley wrote:
> Hi.
> 
> On Tue, 19 Mar 2013, Tero Kristo wrote:
> 
> > I think you should definitely upgrade your bootloader, the old one you
> > are using is prone to cause trouble due to bugs it has, and we have no
> > simple way to workaround the issues it causes on kernel side.
> 
> So, the kernel should be independent of the bootloader that's used.  Many 
> of the rest of us have taken great care to ensure that devices get reset 
> to do this.  We've got pretty good coverage on OMAP3 and most of the other 
> OMAP4 IP blocks.
> 
> You mention that there's no simple way to do it, but as far as I know, no 
> one has assessed what's needed to reset the remaining devices.  Or if 
> someone has this information, it hasn't been shared here - please do so.
> 
> So what I'd like you to do is:
> 
> 1. Determine what devices are remaining to be reset and idled on OMAP4 
>    with the bootloader that I use.  As far as I know, there are only four 
>    that block full-chip idle: M3, DSP, SL2IF, FSUSB
> 
> 2. Determine what's needed to reset and idle them.  For the M3 and DSP, 
>    I'd assume this involves pointing the reset vector for those 
>    processors at a few lines of code that basically enter WFI or the C64x 
>    equivalent.

This is the nasty part. We need firmware support for the blocks to do
this, and this is imo a complete overkill for the task at hand, as it
will duplicate the DSP + M3 firmware and drivers at least partially. On
OMAP3, it was easy as you could just setup the boot mode for IVA and get
over with it. We don't have similar luxury on OMAP4.

If there was a simple way to do this, don't you think this would have
been done already a year back when we started to discuss this first
time? And, a year old bootloader is ancient seeing we didn't have any
kind of support for OMAP4 core idle in mainline back then and this
feature was essentially completely untested.... nobody cared about the
upstream u-boot PM compatibility before that.

-Tero

> 
> 3. At this point, we can determine the difficulty level of the task.
> 
> 4. Then, assuming it's of the level described in step 2, that reset/idle 
>    code should be implemented.
> 
> This process will ensure both that users with "old" OMAP4 bootloaders -- 
> really, u-boot versions distributed less than a year ago, so not very old 
> at all -- will be able to successfully enter chip low power states.  It 
> will also ensure that users who boot to new kernels with kexec will be 
> able to do so successfully, with a minimum of interference from other 
> devices.
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


