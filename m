From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
Date: Tue, 25 Jan 2011 14:11:53 +0000
Message-ID: <20110125141153.GA17286@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk> <20110123001636.GA20841@n2100.arm.linux.org.uk> <000601cbbc97$cc6955d0$653c0170$@deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36770 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab1AYOMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 09:12:37 -0500
Content-Disposition: inline
In-Reply-To: <000601cbbc97$cc6955d0$653c0170$@deacon@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 01:57:26PM -0000, Will Deacon wrote:
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

Was this for just the first three or the complete set?

Thanks.
