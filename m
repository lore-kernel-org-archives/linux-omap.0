From: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 3/3] ARM: omap4: Convert END() to ENDPROC() for correct
	linkage with CONFIG_THUMB2_KERNEL
Date: Mon,  6 Dec 2010 17:35:37 +0000
Message-ID: <1291656937-24992-4-git-send-email-dave.martin@linaro.org>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1291656937-24992-1-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

almost all code for v7+ platforms) is deprecated/incorrect.

ENDPROC() tags the affected symbol as a function symbol, which will
ensure that link-time fixups don't accidentally switch to the
wrong instruction set.

omap_secondary_startup might still need to be changed to ARM,
depending on the compatibility status of bootloaders.

Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
KernelVersion: 2.6.37-rc4

 arch/arm/mach-omap2/omap-headsmp.S |    2 +-
 arch/arm/mach-omap2/omap44xx-smc.S |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 6ae937a..4ee6aec 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -45,5 +45,5 @@ hold:	ldr	r12,=0x103
 	 * should now contain the SVC stack for this core
 	 */
 	b	secondary_startup
-END(omap_secondary_startup)
+ENDPROC(omap_secondary_startup)
 
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
index 1980dc3..e69d37d 100644
--- a/arch/arm/mach-omap2/omap44xx-smc.S
+++ b/arch/arm/mach-omap2/omap44xx-smc.S
@@ -29,7 +29,7 @@ ENTRY(omap_smc1)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_smc1)
+ENDPROC(omap_smc1)
 
 ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
@@ -37,7 +37,7 @@ ENTRY(omap_modify_auxcoreboot0)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r1-r12, pc}
-END(omap_modify_auxcoreboot0)
+ENDPROC(omap_modify_auxcoreboot0)
 
 ENTRY(omap_auxcoreboot_addr)
 	stmfd   sp!, {r2-r12, lr}
@@ -45,7 +45,7 @@ ENTRY(omap_auxcoreboot_addr)
 	dsb
 	smc	#0
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_auxcoreboot_addr)
+ENDPROC(omap_auxcoreboot_addr)
 
 ENTRY(omap_read_auxcoreboot0)
 	stmfd   sp!, {r2-r12, lr}
@@ -54,4 +54,4 @@ ENTRY(omap_read_auxcoreboot0)
 	smc	#0
 	mov	r0, r0, lsr #9
 	ldmfd   sp!, {r2-r12, pc}
-END(omap_read_auxcoreboot0)
+ENDPROC(omap_read_auxcoreboot0)
-- 
1.7.1
