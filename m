From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: [PATCH] Fix omap2430 clock build error
Date: Fri, 10 Aug 2007 11:51:21 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429019C4DDE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This fixes a build error for 2430.  fixed_div is under a 2420 only =
define and it should be OMAP2.

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>

diff --git a/include/asm-arm/arch-omap/clock.h =
b/include/asm-arm/arch-omap/clock.h
index c81f0d0..2aeca56 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -34,7 +34,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_ARCH_OMAP2)
 	u8			fixed_div;
 #endif
 };

Regards,
Richard W.
