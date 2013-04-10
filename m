From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m"
 as the main clock (fwd)
Date: Wed, 10 Apr 2013 19:43:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304101941550.25123@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed;
 BOUNDARY="843723315-1840391867-1365622592=:25123"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-ID: <alpine.DEB.2.00.1304101937000.25123@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, Keerthy <j-keerthy@ti.com>, rnayak@ti.com, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1840391867-1365622592=:25123
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1304101937001.25123@utopia.booyaka.com>


Hi Tony,

could you send this one upstream for v3.9-rc fixes?  Should prevent=20
a MUSB regression in v3.9, mostly due to my own incompetence.


- Paul

---------- Forwarded message ----------
Date: Wed, 10 Apr 2013 19:41:38 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>, rnayak@ti.com, b-cousson@ti.com=
,
    tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org,
    Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] ARM: OMAP4: hwmod data: make
    'ocp2scp_usb_phy_phy_48m" as the main clock

From: Kishon Vijay Abraham I <kishon@ti.com>

Commit 92702df3570e ("ARM: OMAP4: PM: fix PM regression introduced by recen=
t
clock cleanup") makes the 'ocp2scp_usb_phy_phy_48m' as optional
functional clock causing regression in MUSB. But this 48MHz clock is a
mandatory clock for usb phy attached to ocp2scp and hence made as the main
clock for ocp2scp.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[paul@pwsan.com: add comment to the hwmod data to try to prevent any
 future mistakes here]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

Nothing further received from Kishon per the request:

http://marc.info/?l=3Dlinux-omap&m=3D136554118302342&w=3D2

Since the deadline for v3.9-rc fixes is quite close, have added the=20
comment myself, and have confirmed that this patch does not cause=20
additional PM regressions on 4460 Panda-ES in the tests here.

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 9e05765..eaba9dc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2714,16 +2714,22 @@ static struct omap_ocp2scp_dev ocp2scp_dev_attr[] =
=3D {
 =09{ }
 };
=20
-static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] =3D {
-=09{ .role =3D "48mhz", .clk =3D "ocp2scp_usb_phy_phy_48m" },
-};
-
 /* ocp2scp_usb_phy */
 static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod =3D {
 =09.name=09=09=3D "ocp2scp_usb_phy",
 =09.class=09=09=3D &omap44xx_ocp2scp_hwmod_class,
 =09.clkdm_name=09=3D "l3_init_clkdm",
-=09.main_clk=09=3D "func_48m_fclk",
+=09/*
+=09 * ocp2scp_usb_phy_phy_48m is provided by the OMAP4 PRCM IP
+=09 * block as an "optional clock," and normally should never be
+=09 * specified as the main_clk for an OMAP IP block.  However it
+=09 * turns out that this clock is actually the main clock for
+=09 * the ocp2scp_usb_phy IP block:
+=09 * http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September=
/119943.html
+=09 * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
+=09 * to be the best workaround.
+=09 */
+=09.main_clk=09=3D "ocp2scp_usb_phy_phy_48m",
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -2732,8 +2738,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwm=
od =3D {
 =09=09},
 =09},
 =09.dev_attr=09=3D ocp2scp_dev_attr,
-=09.opt_clks=09=3D ocp2scp_usb_phy_opt_clks,
-=09.opt_clks_cnt=09=3D ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
 };
=20
 /*
--=20
1.7.10.4
--843723315-1840391867-1365622592=:25123
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-1840391867-1365622592=:25123--
