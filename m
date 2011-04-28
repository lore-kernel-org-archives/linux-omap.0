From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Thu, 28 Apr 2011 01:12:04 -0700
Message-ID: <20110428081204.GL3755@atomide.com>
References: <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
 <20110427124726.GE3755@atomide.com>
 <20110427125631.GF3755@atomide.com>
 <alpine.LFD.2.00.1104271810450.24613@xanadu.home>
 <20110428063808.GK16892@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51229 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754374Ab1D1IMI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 04:12:08 -0400
Content-Disposition: inline
In-Reply-To: <20110428063808.GK16892@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, patches@linaro.org

* Tony Lindgren <tony@atomide.com> [110427 23:35]:
> * Nicolas Pitre <nicolas.pitre@linaro.org> [110428 01:12]:
> > On Wed, 27 Apr 2011, Tony Lindgren wrote:
> > 
> > > * Tony Lindgren <tony@atomide.com> [110427 05:44]:
> > > > We can't overwrite the running code when relocating only a small amount,
> > > > say 0x100 or so.
> > > > 
> > > > There's no need to relocate all the way past the compressed kernel,
> > > > we just need to relocate past the size of the code in head.o.
> > > > 
> > > > Updated patch below using the GOT end instead of the compressed
> > > > image end.
> > > 
> > > Oops, the mov should be movle of course. Updated patch below.
> > 
> > This is wrong.  You're using r12 before it is fixed up with the 
> > proper offset.
> 
> Hmm I see. I guess I was thinking it only needs to be fixed up after
> the relocation.

Here's this one with r12 calculation fixed using r0 delta. Also updated
it to use movlt instead of movle as that should be sufficient.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 27 Apr 2011 02:06:13 -0700
Subject: [PATCH] ARM: Fix relocation to move past the running code

Otherwise we end up overwriting ourselves partially when relocating
less than size of the running code in head.S.

Without this patch, a system will not boot if the compressed image
load address is slightly less than where the compressed image gets
relocated.

For example, using mkimage to set the load address to something like
zreladdr + uncompressed image size - 0x100 will make the system hang
without this patch.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -282,10 +282,12 @@ dtb_check_done:
 
 /*
  * Check to see if we will overwrite ourselves.
+ *   r0  = delta
  *   r4  = final kernel address
  *   r5  = start of this image
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ *   r12 = GOT end, fixed up with delta in r0 if relocating
  * We basically want:
  *   r4 - 16k page directory >= r10 -> OK
  *   r4 + image length <= r5 -> OK
@@ -297,11 +299,20 @@ dtb_check_done:
 		cmp	r10, r5
 		bls	wont_overwrite
 
+		/*
+		 * Check if the relocate address overlaps the running code in
+		 * head.S. In that case we need to relocate past the code
+		 * to avoid overwriting some of the running code.
+		 */
+		add	r12, r12, r0		@ fixup GOT end with delta
+		cmp	r10, r12		@ relocating less than GOT end?
+		movlt	r10, r12		@ if so, relocate to GOT end
+
 /*
  * Relocate ourselves past the end of the decompressed kernel.
  *   r5  = start of this image
  *   r6  = _edata
- *   r10 = end of the decompressed kernel
+ *   r10 = end of the decompressed kernel or end of GOT end if larger
  * Because we always copy ahead, we need to do it from the end and go
  * backward in case the source and destination overlap.
  */
