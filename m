From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RESEND PATCH 2/2] ARM: kexec: Check segment memory addresses
Date: Tue, 16 Oct 2012 20:09:00 +0300
Message-ID: <20121016170900.GB1613@blackmetal.musicnaut.iki.fi>
References: <1348157018-31059-1-git-send-email-will.deacon@arm.com>
 <1348157018-31059-2-git-send-email-will.deacon@arm.com>
 <20121016161020.GA1613@blackmetal.musicnaut.iki.fi>
 <20121016163226.GG23979@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49564 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab2JPRJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 13:09:03 -0400
Content-Disposition: inline
In-Reply-To: <20121016163226.GG23979@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Oct 16, 2012 at 05:32:26PM +0100, Will Deacon wrote:
> On Tue, Oct 16, 2012 at 05:10:21PM +0100, Aaro Koskinen wrote:
> > On Thu, Sep 20, 2012 at 05:03:38PM +0100, Will Deacon wrote:
> > > From: Matthew Leach <matthew.leach@arm.com>
> > > 
> > > Ensure that the memory regions that are set within the segments
> > > correspond to physical contiguous memory regions.
> > 
> > This patch seems to break kexec for me in 3.7-rc1 (commit
> > c564df4db85aac8d1d65a56176a0a25f46138064, bisected).
> > 
> > kexec -l fails with the following output:
> > 
> > kexec_load failed: Invalid argument
> > entry       = 0x80008000 flags = 280000
> > nr_segments = 2
> > segment[0].buf   = 0xc48008
> > segment[0].bufsz = 230
> > segment[0].mem   = 0x80001000
> > segment[0].memsz = 1000
> > segment[1].buf   = 0xb6a9b008
> > segment[1].bufsz = 3a4668
> > segment[1].mem   = 0x80008000
> > segment[1].memsz = 3a5000
> > Could not load the kexec kernel: n800-zImage
> > 
> > The board is OMAP2420 / Nokia N800.
> 
> Interesting, it sounds like kexec thinks that you don't have contiguous
> memory from 0x80008000 to 0x803ad000. Can you provide some more information
> about your physical memory map please?

Well, I think it's because the patch is wrong. Shouldn't it be:

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index e29c333..a80192e 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -47,7 +47,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 		err = memblock_is_region_memory(current_segment->mem,
 						current_segment->memsz);
-		if (err)
+		if (!err)
 			return - EINVAL;
 
 		err = get_user(header, (__be32*)current_segment->buf);

A.
