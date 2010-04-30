From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [2.6.34-rc6] ARM: build breaks with KPROBES
Date: Fri, 30 Apr 2010 14:57:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5217AC1@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52179C0@dbde02.ent.ti.com>
	<20100430074745.GA7874@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100430074745.GA7874@n2100.arm.linux.org.uk>
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

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Friday, April 30, 2010 1:18 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; Linux-OMAP
> Subject: Re: [2.6.34-rc6] ARM: build breaks with KPROBES
> 
> On Fri, Apr 30, 2010 at 12:51:49PM +0530, Shilimkar, Santosh wrote:
> > Russell,
> >
> > The latest mainline ARM build breaks with KPROBES enabled. Anand
> > Gadiyar did git bisect and figured out that below commit breaks the build.
> > 	commit :4260415f6a3b92c5c986398d96c314df37a4ccbf
> 
> Did you read the comments in the commit message to understand why
> .previous is dangerous?
> 
> > I tried matching the sections but failed to fix the build error. Below
> > is the hack patch to keep build working.
> 
> The previous section is not .text, but:
> 
> #ifdef CONFIG_KPROBES
>         .section        .kprobes.text,"ax",%progbits
> #else
>         .text
> #endif
> 
> Either change the preceding .data to .pushsection .data, and the following
> .text to .popsection, or duplicate the above ifdef; .pushsection/.popsection
> is _far_ safer than using .previous.
OK.
Here is the updated patch based on your suggestion.

>From 2660d4ca5d77406fc8d46a5c0f18127332914604 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Fri, 30 Apr 2010 12:41:16 +0530
Subject: [PATCH] ARM: Fix build break with KPROBES enabled

With CONFIG_KPROBES enabled two section are getting created which
leads to below build break.

LOG:
 AS      arch/arm/kernel/entry-armv.o
arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:431: Error: symbol ret_from_exception is in a different section
arch/arm/kernel/entry-armv.S:490: Error: symbol ret_from_exception is in a different section
arch/arm/kernel/entry-armv.S:491: Error: symbol __und_usr_unknown is in a different section

This was introduced by commit 4260415f6a3b92c5c986398d96c314df37a4ccbf

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reported-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/kernel/entry-armv.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e6a0fb0..7ee48e7 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -676,10 +676,10 @@ do_fpe:
  *  lr  = unrecognised FP instruction return address
  */
 
-	.data
+	.pushsection .data
 ENTRY(fp_enter)
 	.word	no_fp
-	.text
+	.popsection
 
 ENTRY(no_fp)
 	mov	pc, lr
-- 
1.6.0.4
