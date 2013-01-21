From: Matt Porter <mporter@ti.com>
Subject: Re: OMAP baseline test results for v3.8-rc4
Date: Mon, 21 Jan 2013 12:10:22 -0500
Message-ID: <20130121171022.GC10020@beef>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <49ca66a84bb245ca9cfe4fd044c4d6f6@DFLE72.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:55075 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3AURK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 12:10:26 -0500
Received: by mail-qa0-f42.google.com with SMTP id hg5so6968637qab.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 09:10:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <49ca66a84bb245ca9cfe4fd044c4d6f6@DFLE72.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 21, 2013 at 04:32:13PM +0000, Mark Jackson wrote:
> Vaibhav / Matt
> 
> On 20/01/13 21:38, Paul Walmsley wrote:
> > 
> > Here are some basic OMAP test results for Linux v3.8-rc4.
> > Logs and other details at:
> > 
> >     http://www.pwsan.com/omap/testlogs/test_v3.8-rc4/20130120122039/
> 
> <snip>
> 
> > Failing tests: needing investigation
> > ------------------------------------
> > 
> > Boot tests:
> > 
> > * am335xbone: hangs after "Starting kernel"
> >   - Cause unknown
> >   - http://www.mail-archive.com/linux-omap@vger.kernel.org/msg82297.html
> 
> <snip>
> 
> > Failing tests: needing local investigation (may be due to testbed issues)
> > -------------------------------------------------------------------------
> > 
> > Boot tests:
> > 
> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - May be fixed now, pending retest:
> >     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
> >   - Not yet part of the automated test suite
> >   - Nishanth Menon & Vaibhav Hiremath report that it works for them
> >   * May be due to an old U-boot with FDT support problems used here?
> >     Pending local investigation and re-test
> 
> Does anyone know when the BeagleBone support is going to be fixed in mainline ?

Hi Mark,

I'm not sure what needs to be fixed. The only thing my edma dmaengine
series adds is new features (specifically, mmc and spi dma support).
I would suspect some boot problem specific to Paul's configuration
if it's hanging. I just booted current mainline with an
omap2plus_defconfig build on my bone a5 and it came up fine.

> I've just tried the latest linux-next git, and no joy.
> 
> However, Matt's edma-dmaengine-am33xx-v5 branch on github seems to be working:-
>
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.8.0-rc3-61978-g108da76-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4
> (Buildroot 2012.11-git-00497-ge48bf89) ) #7 SMP Mon Jan 21 15:52:14 GMT 2013
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
> 
> Are we just waiting for Matt's DMA stuff to be accepted ?

For the features I listed above, yes. Also Mark Greer's crypto patches
for AM33xx depend on that series as does a patch series (not ready yet)
that I have to support the Bone audio capes.

There's a dependency I'm working through in a separate thread on lkml
since the dmaengine edma series requires the proposed
dma_get_channel_caps() api...still discussing that implementation.

-Matt
