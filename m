From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v2] ARM: Avoid discarding sections that might have
 SMP_ON_UP fixups SMP_ON_UP fixups
Date: Thu, 27 Jan 2011 14:37:09 +0000
Message-ID: <20110127143709.GA13735@arm.com>
References: <alpine.LFD.2.00.1101261617190.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35305 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab1A0OhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 09:37:18 -0500
Received: by wyb28 with SMTP id 28so2141260wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 06:37:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101261617190.8580@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 26, 2011 at 04:31:37PM -0500, Nicolas Pitre wrote:
> Since discarded sections are by definition not used, we should at least 
> put them into the .init section so to discard them at run time.  And 
> only the EXIT_TEXT and EXIT_DATA would need to be kept (see x86 for 
> example).
> 
> 
> Nicolas

I'll check up on whether we need to care about writable data.
For now I've just attempted to move stuff to .init.

Cheers
---Dave



v2: Also move the .exit stuff to the .init area where it can
be discarded on boot.  The result builds, but I haven't tested it
yet.

v1:

SMP_ON_UP fixups lead to vmlinux link errors if those sections are
discarded at link-time.  In particular this may happen for built-in
__exit stuff.

This patch modifies the vmlinux linker script to reduce the amount
of discarded sections, and tries to make sure that __exit sections
are kept in.

This is a hack and probably wrong!

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 45b5651..5774b95 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -43,6 +43,17 @@ SECTIONS
 		_sinittext = .;
 			HEAD_TEXT
 			INIT_TEXT
+#ifdef CONFIG_SMP_ON_UP
+			*(.exit.text)
+			CPU_KEEP(exit.text)
+			DEV_KEEP(exit.text)
+			MEM_KEEP(exit.text)
+#endif
+#ifdef CONFIG_SMP_ON_UP
+			CPU_KEEP(exit.rodata)
+			DEV_KEEP(exit.rodata)
+			MEM_KEEP(exit.rodata)
+#endif
 		_einittext = .;
 		ARM_CPU_DISCARD(PROC_INFO)
 		__arch_info_begin = .;
@@ -72,6 +83,11 @@ SECTIONS
 		__init_begin = _stext;
 		INIT_DATA
 #endif
+#ifdef CONFIG_SMP_ON_UP
+		DEV_KEEP(exit.data)
+		CPU_KEEP(exit.data)
+		MEM_KEEP(exit.data)
+#endif
 	}
 
 	PERCPU(PAGE_SIZE)
@@ -85,6 +101,7 @@ SECTIONS
 	 * unwind exit sections must be discarded before the rest of the
 	 * unwind sections get included.
 	 */
+#ifndef CONFIG_SMP_ON_UP
 	/DISCARD/ : {
 		*(.ARM.exidx.exit.text)
 		*(.ARM.extab.exit.text)
@@ -99,6 +116,7 @@ SECTIONS
 		*(__ex_table)
 #endif
 	}
+#endif
 
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
-- 
1.7.1

