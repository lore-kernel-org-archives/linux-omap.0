From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
Date: Thu, 21 Jan 2016 11:12:03 -0800
Message-ID: <1453403527-21308-2-git-send-email-tony@atomide.com>
References: <1453403527-21308-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453403527-21308-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Nishanth Menon <nm@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Tero Kristo <t-kristo@ti.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We don't want to be writing to .text so it can be set rodata.
Fix error "Unable to handle kernel paging request at virtual address
c012396c" in wait_dll_lock_timed if CONFIG_DEBUG_RODATA is selected.

As these counters are for debugging only and unused, we can just
remove them.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep34xx.S | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index eafd120..787cfda 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -289,12 +289,6 @@ wait_sdrc_ready:
 	bic	r5, r5, #0x40
 	str	r5, [r4]
 
-/*
- * PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 as a
- * base instead.
- * Be careful not to clobber r7 when maintaing this code.
- */
-
 is_dll_in_lock_mode:
 	/* Is dll in lock mode? */
 	ldr	r4, sdrc_dlla_ctrl
@@ -302,11 +296,7 @@ is_dll_in_lock_mode:
 	tst	r5, #0x4
 	bne	exit_nonoff_modes	@ Return if locked
 	/* wait till dll locks */
-	adr	r7, kick_counter
 wait_dll_lock_timed:
-	ldr	r4, wait_dll_lock_counter
-	add	r4, r4, #1
-	str	r4, [r7, #wait_dll_lock_counter - kick_counter]
 	ldr	r4, sdrc_dlla_status
 	/* Wait 20uS for lock */
 	mov	r6, #8
@@ -330,9 +320,6 @@ kick_dll:
 	orr	r6, r6, #(1<<3)		@ enable dll
 	str	r6, [r4]
 	dsb
-	ldr	r4, kick_counter
-	add	r4, r4, #1
-	str	r4, [r7]		@ kick_counter
 	b	wait_dll_lock_timed
 
 exit_nonoff_modes:
@@ -360,15 +347,6 @@ sdrc_dlla_status:
 	.word	SDRC_DLLA_STATUS_V
 sdrc_dlla_ctrl:
 	.word	SDRC_DLLA_CTRL_V
-	/*
-	 * When exporting to userspace while the counters are in SRAM,
-	 * these 2 words need to be at the end to facilitate retrival!
-	 */
-kick_counter:
-	.word	0
-wait_dll_lock_counter:
-	.word	0
-
 ENTRY(omap3_do_wfi_sz)
 	.word	. - omap3_do_wfi
 
-- 
2.7.0.rc3
