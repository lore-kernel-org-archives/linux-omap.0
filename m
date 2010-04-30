From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [2.6.34-rc6] ARM: build breaks with KPROBES
Date: Fri, 30 Apr 2010 12:51:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52179C0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Russell,

The latest mainline ARM build breaks with KPROBES enabled. Anand
Gadiyar did git bisect and figured out that below commit breaks the build.
	commit :4260415f6a3b92c5c986398d96c314df37a4ccbf

I tried matching the sections but failed to fix the build error. Below
is the hack patch to keep build working.

Regards,
Santosh

*******************************************************

ARM: Build break with KPROBES enabled

With CONFIG_KPROBES enabled two section are getting created which
leads to below buid break.

LOG:
 AS      arch/arm/kernel/entry-armv.o
arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:431: Error: symbol ret_from_exception is in a different section
arch/arm/kernel/entry-armv.S:490: Error: symbol ret_from_exception is in a different section
arch/arm/kernel/entry-armv.S:491: Error: symbol __und_usr_unknown is in a different section


Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/kernel/entry-armv.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e6a0fb0..db4ec05 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -679,7 +679,7 @@ do_fpe:
 	.data
 ENTRY(fp_enter)
 	.word	no_fp
-	.text
+	.previous
 
 ENTRY(no_fp)
 	mov	pc, lr
-- 
1.6.0.4
