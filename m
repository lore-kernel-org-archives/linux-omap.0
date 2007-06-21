From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: dss2 dvfs fix.
Date: Wed, 20 Jun 2007 20:48:15 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901403565@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

While testing low power refresh I noticed the DSS2 clock setting wasn't
being perserved across DVFS changes.  The below makes sure to not change
the source for DSS2.

Signed-off-by: Richard Woodruff  <r-woodruff2@ti.com>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index f6da2bd..a7792d3 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -995,7 +995,7 @@ static int omap2_clk_set_parent(struct clk *clk,
struct clk *new_parent)
 /* Sets basic clocks based on the specified rate */
 static int omap2_select_table_rate(struct clk * clk, unsigned long
rate)
 {
-	u32 flags, cur_rate, done_rate, bypass =3D 0;
+	u32 flags, cur_rate, done_rate, bypass =3D 0, tmp;
 	u8 cpu_mask =3D 0;
 	struct prcm_config *prcm;
 	unsigned long found_speed =3D 0;
@@ -1056,7 +1056,8 @@ static int omap2_select_table_rate(struct clk *
clk, unsigned long rate)
 		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD,
CM_CLKSEL);
=20
 		/* Major subsystem dividers */
-		cm_write_mod_reg(prcm->cm_clksel1_core, CORE_MOD,
CM_CLKSEL1);
+		tmp =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & 0x2000;
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
CM_CLKSEL1);
 		if (cpu_is_omap2430())
 			cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);


Regards,
Richard W.
