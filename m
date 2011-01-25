From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to use
 ldrex/strex
Date: Tue, 25 Jan 2011 16:38:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101251631540.8580@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
 <20110123001636.GA20841@n2100.arm.linux.org.uk>
 <000601cbbc97$cc6955d0$653c0170$%deacon@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:11394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1AYViw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 16:38:52 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFL00FBELGF83C0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Tue, 25 Jan 2011 16:38:40 -0500 (EST)
In-reply-to: <000601cbbc97$cc6955d0$653c0170$%deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 25 Jan 2011, Will Deacon wrote:

> Hi Russell,
> 
> Hopefully this isn't too late to be useful.
> 
> > On Mon, Jan 17, 2011 at 07:21:40PM +0000, Russell King - ARM Linux wrote:
> > > Switch the set/clear/change bitops to use the word-based exclusive
> > > operations, which are only present in a wider range of ARM architectures
> > > than the byte-based exclusive operations.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > As only one person replied to this patch with test information, I'm
> > not happy to push this into -rc, and hence that prevents it going into
> > -stable too.  That means omap2plus_defconfig .38 mainline kernels
> > (including -stable) will remain potentially dangerous when run on
> > SMP capable hardware.
> > 
> > Therefore, I see no alternative at the moment but to purposely cause
> > builds which cover ARMv6, and ARMv6K or ARMv7 CPUs to save people from
> > data corruption.
> > 
> > Please get your tested-by's to me for at least the first three patches
> > of this series ASAP.
> 
> I've tested this on the Versatile Express (ca9x4, little endian) with a USB
> hard drive and ext3 (rw) filesystem. I did a bunch of parallel dds of a 2GB
> file containing random data whilst the system was fairly loaded. File checksums
> all passed and the kernel didn't do anything untowards.
> 
> Tested-by: Will Deacon <will.deacon@arm.com>
> 
> I appreciate this is the same test configuration as the one Nicolas did,
> but it at least replicates his findings.

Well, I did run parallel instances of the git test suite on a Dove board 
using the sata_mv driver.  Therefore this is still a significant
difference in configuration which is good.


Nicolas
