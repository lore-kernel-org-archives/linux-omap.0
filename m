From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Mon, 22 Oct 2012 18:35:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com> <50857444.9080308@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab2JVSfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 14:35:07 -0400
In-Reply-To: <50857444.9080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

(including the lists in my reply this time, oops; also adding some more 
detail)

On Mon, 22 Oct 2012, Jon Hunter wrote:

> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
>
> > Failing tests: fixed by posted patches
> > --------------------------------------
> > 
> > Boot tests:
> > 
> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - due to a GPMC bug
> >   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
> 
> This is now addressed and I have verified it is booting on v3.7-rc2. The
> following patch address this boot problem ...
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3

Great, thanks, will update the README.  Did you also enable 
CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT, or were you able 
to pass the DTB from the bootloader?

> > * 4460pandaes: boot fails early
> >   - Appears to be timer-related
> 
> I tried v3.7-rc2 on my pandaES and it is booting fine for me.
> 
> I have an OMAP4460 ES1.1 and u-boot release 2012.10.

Tony's reporting the same thing so maybe this is a bootloader problem.  
Just sent you the bootloader/MLO from my board here, maybe you can give it 
a quick test if you have a moment.  Probably the kernel is implicitly 
assuming that the bootloader has enabled something.

> I don't wish to create more work for you, but it could be good to add
> silicon revision, u-boot release (if applicable)

These can be found by clicking through the link at the top of the message.  
In this case:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/

Click on 'boot' and '4460pandaes'

> and toolchain used for any failures.

This would indeed be useful and will try to figure out a good way to add 
that information.


- Paul
