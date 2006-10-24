From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Fixup omap-rtc (was: Git tree updated to
	2.6.19-rc2)
Date: Tue, 24 Oct 2006 12:05:02 +0100
Message-ID: <20061024110502.GQ1123@earth.li>
References: <20061023203925.GC11967@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061023203925.GC11967@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 23, 2006 at 11:39:26PM +0300, Tony Lindgren wrote:
> I've updated our git tree to 2.6.19-rc2. At least following have
> problems on omap1 (OSK):
> 
> - CONFIG_DEBUG_LL hangs system
> - BUG in omap1_mbox_enable_irq
> - Aic23 NULL pointer exception
> 
> So YMMV :) Anybody got patches for these issues already?

Haven't hit any of these with the Amstrad Delta defconfig so far (just
done a compile and boot so far), but did need the patch below to get
omap-rtc to compile.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/drivers/char/omap-rtc.c b/drivers/char/omap-rtc.c
index f48563f..d57402f 100644
--- a/drivers/char/omap-rtc.c
+++ b/drivers/char/omap-rtc.c
@@ -120,7 +120,7 @@ static const unsigned char days_in_mo[] 
  *	A very tiny interrupt handler. It runs with SA_INTERRUPT set.
  */
 
-irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t rtc_interrupt(int irq, void *dev_id)
 {
 	/*
 	 *	Either an alarm interrupt or update complete interrupt.
-----

J.

-- 
] http://www.earth.li/~noodles/ []   How does it work?  I don't know   [
]  PGP/GPG Key @ the.earth.li   []            but it does!             [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
