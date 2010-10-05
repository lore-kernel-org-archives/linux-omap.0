From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Tue, 5 Oct 2010 00:27:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050026250.13816@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com> <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com> <4CA60F88.4020303@ti.com> <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com> <0680EC522D0CC943BC586913CF3768C003FF3B2C94@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010050023580.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-125286029-1286260025=:13816"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52608 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab0JEG1G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:27:06 -0400
In-Reply-To: <alpine.DEB.2.00.1010050023580.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-125286029-1286260025=:13816
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Oct 2010, Paul Walmsley wrote:

> On Tue, 5 Oct 2010, Nayak, Rajendra wrote:
>=20
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Tuesday, October 05, 2010 11:32 AM
> > >=20
> > > Some IP blocks may require extra time to become ready for register
> > > reads/writes after the PRCM deasserts its IdleAck signal to the
> >=20
> > Maybe it should say 'PRCM deasserts its IdleReq'
>=20
> Oops, yes, you are right; will fix and repost an updated version.

Here's the update.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 4 Oct 2010 23:15:23 -0600
Subject: [PATCH] OMAP: hwmod: add configurable device enable delay after PR=
CM IdleReq deasserts
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Some IP blocks may require extra time to become ready for register
reads/writes after the PRCM deasserts its IdleReq signal to the
module.  If an imprecise external abort happens during or shortly
after the hwmod is enabled, extra time is needed[1].  For those
modules, add a new struct omap_hwmod field, .enable_delay.  This field
represents the number of microseconds that the hwmod code should delay
before attempting to access the IP block's registers or relinquishing
control to the calling code.

Copious guidance is also provided to aid developers in determining the
appropriate enable_delay value.

This problem was identified by Kevin Hilman and Rajendra Nayak.
Beno=EEt Cousson identified the solution.  Rajendra Nayak noted a bug
in the patch comments - thanks Rajendra.

1. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36300.html

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    3 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   33 ++++++++++++++++++++++=
++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 955861a..fbcfe14 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1204,6 +1204,9 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
=20
 =09r =3D _wait_target_ready(oh);
 =09if (!r) {
+=09=09if (oh->enable_delay)
+=09=09=09udelay(oh->enable_delay);
+
 =09=09oh->_state =3D _HWMOD_STATE_ENABLED;
=20
 =09=09/* Access the sysconfig only if the target is ready */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index c1835af..3754490 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -434,6 +434,7 @@ struct omap_hwmod_class {
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
+ * @enable_delay: number of microseconds to wait after IdleReq is deassert=
ed
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
  * @dev_attr: arbitrary device attributes that can be passed to the driver
@@ -460,8 +461,35 @@ struct omap_hwmod_class {
  * accesses to complete."  Modules may not have a main clock if the
  * interface clock also serves as a main clock.
  *
- * Parameter names beginning with an underscore are managed internally by
- * the omap_hwmod code and should not be set during initialization.
+ * On OMAP SoCs prior to OMAP4, some hwmods may require a non-zero
+ * @enable_delay value.  A hwmod needs a non-zero @enable_delay if an
+ * imprecise external abort occurs while the hwmod is being enabled.
+ * This can happen if the hwmod takes a significant time to become
+ * ready for OCP transactions after the PRCM deasserts IdleReq to the
+ * module.  @enable_delay specifies the number of microseconds for the
+ * hwmod code to udelay() between the time that the PRCM deasserts the
+ * IdleReq, and the time when the module is ready to handle register
+ * reads/writes.  Most hwmods shouldn't need anything here and can
+ * leave @enable_delay blank.  For hwmods that do need a value here,
+ * to estimate the required value, the best thing to do is to set the
+ * IP block to run at the slowest interface and functional clock rates
+ * and the lowest voltages.  First, try out a small value, say, 10
+ * microseconds, and keep increasing it until the kernel no longer
+ * crashes.  Then add a safety margin to the value that you arrived at
+ * -- say, 50% -- and specify the value in the structure record
+ * initializer for @enable_delay as (value + safety_margin).  Try not
+ * to overestimate this number; if @enable_delay is too large, then
+ * energy will be wasted and the CPU will spin for an unnecessarily
+ * long time while enabling the device.  If @enable_delay is too
+ * small, the device will trigger an abort.  More information is
+ * available here:
+ * http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36300.html
+ * XXX @enable_value will need to be taken into consideration by the
+ * omap_device code to determine whether the device's current wakeup
+ * latency constraint can be satisfied if the module is placed into idle.
+ *
+ * Parameter names beginning with an underscore are managed internally
+ * by the omap_hwmod code and should not be set during initialization.
  */
 struct omap_hwmod {
 =09const char=09=09=09*name;
@@ -484,6 +512,7 @@ struct omap_hwmod {
 =09void __iomem=09=09=09*_mpu_rt_va;
 =09struct mutex=09=09=09_mutex;
 =09struct list_head=09=09node;
+=09u16=09=09=09=09enable_delay;
 =09u16=09=09=09=09flags;
 =09u8=09=09=09=09_mpu_port_index;
 =09u8=09=09=09=09msuspendmux_reg_id;
--=20
1.7.1

--155748971-125286029-1286260025=:13816--
