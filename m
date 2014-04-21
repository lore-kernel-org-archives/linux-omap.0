From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed
 variants of readl/writel
Date: Mon, 21 Apr 2014 10:31:13 -0500
Message-ID: <20140421153113.GA32641@kahuna>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-6-git-send-email-nm@ti.com>
 <20140417215228.GD8504@saruman.home>
 <53504DFF.7090907@ti.com>
 <20140417220329.GF8504@saruman.home>
 <53551A2C.8060404@ti.com>
 <20140421150919.GE27341@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140421150919.GE27341-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10:09-20140421, Felipe Balbi wrote:
> On Mon, Apr 21, 2014 at 08:16:28AM -0500, Nishanth Menon wrote:
> > On 04/17/2014 05:03 PM, Felipe Balbi wrote:
> > > On Thu, Apr 17, 2014 at 05:56:15PM -0400, Santosh Shilimkar wrote:
> > >> On Thursday 17 April 2014 05:52 PM, Felipe Balbi wrote:
> > >>> Hi,
> > >>>
> > >>> On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
> > >>>> Currently we use __raw_readl and writel in this driver, however, there
> > >>>
> > >>> __raw_* and *_relaxed variants are the same, just have a look <asm/io.h>
> > >>>
> > >> Except the relaxed version can take care of endian conversion if
> > >> needed. :-)
> > > 
> > > right, but according to commit log, this commit is more concerned about
> > > the memory barriers which writel()/readl() add, not endianness. Just a
> > > matter of fixing up commit log.
> > > 
> > 
> > yep, this patch does replace writel with writel_relaxed there is no
> > strong need for barriers in the operations that we perform here.
> > 
> > I agree that the commit message should probably be a little more
> > detailed at this point.
> > 
> > 
> > How about:
> > Currently we use __raw_readl and writel in this driver. Considering
> > there is no specific need for a memory barrier, replacing writel with
> > endian-neutral writel_relaxed and replacing __raw_readls with the
> > corresponding endian-neutral readl_relaxed allows us to have a
> > standard set of register operations for the driver.
> > 
> > While at it, simplify address computation using variables for register.
> 
> reads a lot better, thanks
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Thanks.
Updated branch with patches with Acked-bys pickedup is available here:
https://github.com/nmenon/linux-2.6-playground/commits/l3noc/driver-fixes-v2-repost

I have dropped the empty commit while at it.

Updated patch below for the record:
------------------8<-----------------8<----------------------------
>From a8198b8c78f2a2731fdd4df1ac540887a4c464be Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Date: Fri, 11 Apr 2014 11:21:47 -0500
Subject: [PATCH V2 UPDATE 05/19] bus: omap_l3_noc: switch over to relaxed variants of
 readl/writel

Currently we use __raw_readl and writel in this driver. Considering
there is no specific need for a memory barrier, replacing writel
with endian-neutral writel_relaxed and replacing __raw_readls with
the corresponding endian-neutral readl_relaxed allows us to have a
standard set of register operations for the driver.

While at it, simplify address computation using variables for
register.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/bus/omap_l3_noc.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 37d71b7..c8facb0 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -55,6 +55,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 	int err_src = 0;
 	u32 std_err_main, err_reg, clear, masterid;
 	void __iomem *base, *l3_targ_base;
+	void __iomem *l3_targ_stderr, *l3_targ_slvofslsb, *l3_targ_mstaddr;
 	char *target_name, *master_name = "UN IDENTIFIED";
 
 	/* Get the Type of interrupt */
@@ -66,8 +67,8 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 		 * to determine the source
 		 */
 		base = l3->l3_base[i];
-		err_reg = __raw_readl(base + l3_flagmux[i] +
-					+ L3_FLAGMUX_REGERR0 + (inttype << 3));
+		err_reg = readl_relaxed(base + l3_flagmux[i] +
+					L3_FLAGMUX_REGERR0 + (inttype << 3));
 
 		/* Get the corresponding error and analyse */
 		if (err_reg) {
@@ -76,10 +77,14 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 
 			/* Read the stderrlog_main_source from clk domain */
 			l3_targ_base = base + *(l3_targ[i] + err_src);
-			std_err_main =  __raw_readl(l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
-			masterid = __raw_readl(l3_targ_base +
-					L3_TARG_STDERRLOG_MSTADDR);
+			l3_targ_stderr = l3_targ_base + L3_TARG_STDERRLOG_MAIN;
+			l3_targ_slvofslsb = l3_targ_base +
+					    L3_TARG_STDERRLOG_SLVOFSLSB;
+			l3_targ_mstaddr = l3_targ_base +
+					  L3_TARG_STDERRLOG_MSTADDR;
+
+			std_err_main = readl_relaxed(l3_targ_stderr);
+			masterid = readl_relaxed(l3_targ_mstaddr);
 
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
@@ -87,12 +92,10 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					l3_targ_inst_name[i][err_src];
 				WARN(true, "L3 standard error: TARGET:%s at address 0x%x\n",
 					target_name,
-					__raw_readl(l3_targ_base +
-						L3_TARG_STDERRLOG_SLVOFSLSB));
+					readl_relaxed(l3_targ_slvofslsb));
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
+				writel_relaxed(clear, l3_targ_stderr);
 				break;
 
 			case CUSTOM_ERROR:
@@ -107,8 +110,7 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					master_name, target_name);
 				/* clear the std error log*/
 				clear = std_err_main | CLEAR_STDERR_LOG;
-				writel(clear, l3_targ_base +
-					L3_TARG_STDERRLOG_MAIN);
+				writel_relaxed(clear, l3_targ_stderr);
 				break;
 
 			default:
-- 
1.7.9.5




-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
