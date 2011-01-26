From: "Dave P. Martin" <dave.martin@linaro.org>
Subject: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP
 fixups
Date: Wed, 26 Jan 2011 17:25:35 +0000
Message-ID: <20110126172535.GA15983@arm.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
 <AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
 <20110125165919.GD17286@n2100.arm.linux.org.uk>
 <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
 <20110125174636.GE17286@n2100.arm.linux.org.uk>
 <alpine.LFD.2.00.1101251618230.8580@xanadu.home>
 <AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
 <20110126124452.GB4232@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58105 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab1AZRZp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 12:25:45 -0500
Received: by wyb28 with SMTP id 28so1161520wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 09:25:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110126124452.GB4232@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

SMP_ON_UP fixups lead to vmlinux link errors if those sections are
discarded at link-time.  In particular this may happen for built-in
__exit stuff.

This patch modifies the vmlinux linker script to reduce the amount
of discarded sections, and tries to make sure that __exit sections
are kept in.

This is a hack and probably wrong!  Further discussion is needed.  

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---

On Wed, Jan 26, 2011 at 12:44:52PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 26, 2011 at 11:11:31AM +0000, Dave Martin wrote:
> > Do we need to consider any other discarded sections?  In vmlinux.lds, I have:
> > 
> >  /* Default discards */
> >  /DISCARD/ : { *(.exit.text) *(.cpuexit.text) *(.memexit.text)
> > *(.exit.data) *(.cpuexit.data) *(.cpuexit.rodata) *(.memexit.data)
> > *(.memexit.rodata) *(.exitcall.exit) *(.discard) *(.discard.*) }
> 
> We need to keep all the text exit stuff, and that could well want
> data exit stuff, so I think we need ot keep most of that.  Maybe not
> the .discard* stuff though.
> 
> > If we put every fixup in its own _section_ we might be able to
> > collapse those out of the list at link time too.  However, that seems
> > hard to achieve, since in order to do the correct link-time filtering
> > we would need the fixup's section name to be based on the referenced
> > section's name ... due to preprocessor limitations I don't think we
> > can do that automatically (and manual maintenance would be a bad
> > plan).
> 
> I suspect if it was sanely possible to do, then x86 would already be
> doing it as they've had this problem for a lot longer than we have.
> It might be worth talking to toolchain people to see if it can be made
> to work somehow - but we really don't want to get rid of all discarded
> section warnings.
> 
> IOW, if we have a text segment which is included in the image and it
> references discarded .exit text, we really do want it to fail at link
> time.

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 45b5651..473e30e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -85,6 +85,7 @@ SECTIONS
 	 * unwind exit sections must be discarded before the rest of the
 	 * unwind sections get included.
 	 */
+#ifndef CONFIG_SMP_ON_UP
 	/DISCARD/ : {
 		*(.ARM.exidx.exit.text)
 		*(.ARM.extab.exit.text)
@@ -99,6 +100,7 @@ SECTIONS
 		*(__ex_table)
 #endif
 	}
+#endif
 
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
@@ -107,6 +109,12 @@ SECTIONS
 			__exception_text_end = .;
 			IRQENTRY_TEXT
 			TEXT_TEXT
+#ifdef CONFIG_SMP_ON_UP
+			*(.exit.text)
+			CPU_KEEP(exit.text)
+			DEV_KEEP(exit.text)
+			MEM_KEEP(exit.text)
+#endif
 			SCHED_TEXT
 			LOCK_TEXT
 			KPROBES_TEXT
@@ -116,6 +124,11 @@ SECTIONS
 			*(.gnu.warning)
 			*(.rodata)
 			*(.rodata.*)
+#ifdef CONFIG_SMP_ON_UP
+			CPU_KEEP(exit.rodata)
+			DEV_KEEP(exit.rodata)
+			MEM_KEEP(exit.rodata)
+#endif
 			*(.glue_7)
 			*(.glue_7t)
 		. = ALIGN(4);
@@ -188,6 +201,11 @@ SECTIONS
 		 * and the usual data section
 		 */
 		DATA_DATA
+#ifdef CONFIG_SMP_ON_UP
+		DEV_KEEP(exit.data)
+		CPU_KEEP(exit.data)
+		MEM_KEEP(exit.data)
+#endif
 		CONSTRUCTORS
 
 		_edata = .;
-- 
1.7.1

