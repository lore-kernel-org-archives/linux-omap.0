From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Wed, 27 Apr 2011 05:47:26 -0700
Message-ID: <20110427124726.GE3755@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
 <20110420072156.GA28679@atomide.com>
 <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58331 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755686Ab1D0Mrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 08:47:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110421 06:18]:
> On Thu, 21 Apr 2011, Tony Lindgren wrote:
> 
> > Otherwise we end up overwriting ourselves. This fixes booting
> > on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> > (ARM: 6750/1: improvements to compressed/head.S).
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> I don't understand why this is needed.  The copy loop is explicitly 
> copying from the end going backward exactly to cope with this 
> possibility.

This one is starting to make sense now too after the stack corrupting
the image issue is out of the way :)

We can't overwrite the running code when relocating only a small amount,
say 0x100 or so.

There's no need to relocate all the way past the compressed kernel,
we just need to relocate past the size of the code in head.o.

Updated patch below using the GOT end instead of the compressed
image end.

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
@@ -286,6 +286,7 @@ dtb_check_done:
  *   r5  = start of this image
  *   r9  = size of decompressed image
  *   r10 = end of this image, including  bss/stack/malloc space if non XIP
+ *   r12 = GOT end, corrupted if relocating
  * We basically want:
  *   r4 - 16k page directory >= r10 -> OK
  *   r4 + image length <= r5 -> OK
@@ -297,11 +298,20 @@ dtb_check_done:
 		cmp	r10, r5
 		bls	wont_overwrite
 
+		/*
+		 * Check if the relocate address overlaps the running code in
+		 * head.S. In that case we need to relocate past the code
+		 * to avoid overwriting some of the running code.
+		 */
+		add	r12, r12, r5		@ use GOT end for upper limit
+		cmp	r10, r12		@ relocating less than GOT end?
+		mov	r10, r12		@ if so, relocate past GOT end
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
