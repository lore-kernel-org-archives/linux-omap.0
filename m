From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC] To fix 3430 Compilation broken due to PRCM changes
Date: Sat, 22 Sep 2007 08:49:03 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701D27E3A@dlee13.ent.ti.com>
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
To: Paul Walmsley <paul@booyaka.com>, Tony Lindgren <tony@atomide.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Paul,=20

Due to the recent merges the OMAP3430 compilation breaks. To fix this =
for now:

Option 1:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+++ linux-omap/arch/arm/mach-omap2/prcm.c  2007-09-22
void omap_prcm_arch_reset(char mode)
{
        u32 wkup;
+ #ifdef CONFIG_ARCH_OMAP2
        omap2_clk_prepare_for_reboot();
+ #endif
        wkup =3D prm_read_mod_reg(WKUP_MOD, RM_RSTCTRL) | =
OMAP_RST_DPLL3;

Option 2:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+++ linux-omap/arch/arm/mach-omap2/Makefile  2007-09-22 =
08:44:15.000000000 -0500
@@ -13,6 +13,7 @@ obj-$(CONFIG_PM) +=3D pm.o sleep.o

 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)               +=3D clock24xx.o
+obj-$(CONFIG_ARCH_OMAP3)               +=3D clock24xx.o

 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)     +=3D mmu_mach.o

Let me know your preference, I can post a patch for the same.

Regards,
Khasim
