From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: Fix Amstrad Delta omap-keypad usage.
Date: Fri, 27 Oct 2006 17:49:41 +0100
Message-ID: <20061027164941.GQ13361@earth.li>
References: <20061023203925.GC11967@atomide.com>
	<20061024110502.GQ1123@earth.li> <20061027161659.GP13361@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061027161659.GP13361@earth.li>
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

On Fri, Oct 27, 2006 at 05:16:59PM +0100, Jonathan McDowell wrote:
> However having prodded further I'm seeing incorrect key parsing with
> the omap-keypad driver under both -rc2 and -rc3 (works fine in
> 2.6.18-omap1). Numerous keys now returns strings of characters rather
> than the single expected character. A few keys still work as expected
> however. Before I dig in further is anyone else seeing anything similar?

This appears to be due to the addition of keymapsize to the
omap_kp_platform_data structure. The patch below fixes things up for
the Delta; other boards appear to have already had this done.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 0a0c06f..c73ca61 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -187,10 +187,11 @@ static struct resource ams_delta_kp_reso
 };
 
 static struct omap_kp_platform_data ams_delta_kp_data = {
-	.rows	= 8,
-	.cols	= 8,
-	.keymap = ams_delta_keymap,
-	.rep	= 1,
+	.rows		= 8,
+	.cols		= 8,
+	.keymap 	= ams_delta_keymap,
+	.keymapsize	= ARRAY_SIZE(ams_delta_keymap),
+	.delay		= 9,
 };
 
 static struct platform_device ams_delta_kp_device = {
-----

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
  much of : 9 - Processing power.  | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA +
                                   |   `-    DSA keys on the keyservers.
