From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog,
 UART, i2c
Date: Tue, 5 Oct 2010 00:01:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
References: <8762xpenf8.fsf@deeprootsystems.com> <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com> <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com> <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com> <4CA60F88.4020303@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1644992186-1286258492=:13816"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37600 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483Ab0JEGBd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:01:33 -0400
In-Reply-To: <4CA60F88.4020303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1644992186-1286258492=:13816
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Beno=EEt, Rajendra, Kevin,

On Fri, 1 Oct 2010, Cousson, Benoit wrote:

> The issue is that 2420 idlest does not reflect the real status of the OCP=
 bus
> clock, but just the fact that the idle_req is asserted or not.
>=20
> So potentially, the IP is still not accessible when you think it is.
> This imprecise external abort always happen when you try to access an IP =
that
> is not properly clock.
>=20
> BTW, this is exactly the same kind of issue we have with FDIF and ISS on
> OMAP4.

Won't the new idle protocol resolve this for OMAP4 ?

> The easy quick and dirty fix is to comment out the sysconfig structure in=
 the
> hwmod definition. You will then prevent any access to the sysconfig.
> Otherwise, I'm quite sure that a small udelay(1000) can help fixing such =
issue
> as well.
>=20
> Do not forget that 2420 is the very first implementation of the PRCM +
> smartidle mechanism... It was broken for most IPs at that time :-)

Below is an untested patch to provide some mechanism to deal with this --=
=20
I'd appreciate everyone's comments on this, particularly the comments in=20
the patch code on how to deal with this problem.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 4 Oct 2010 23:15:23 -0600
Subject: [PATCH] OMAP: hwmod: add configurable device enable delay after PR=
CM IdleAck deasserts
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Some IP blocks may require extra time to become ready for register
reads/writes after the PRCM deasserts its IdleAck signal to the
module.  If an imprecise external abort happens during or shortly
after the hwmod is enabled, extra time is needed[1].  For those
modules, add a new struct omap_hwmod field, .enable_delay.  This field
represents the number of microseconds that the hwmod code should delay
before attempting to access the IP block's registers or relinquishing
control to the calling code.

Copious guidance is also provided to aid developers in determining the
appropriate hwmod value.

This problem was identified by Kevin Hilman and Rajendra Nayak.
Beno=EEt Cousson identified the solution.

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
index c1835af..5a1e058 100644
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
+ * ready for OCP transactions after the PRCM deasserts IdleAck to the
+ * module.  @enable_delay specifies the number of microseconds for the
+ * hwmod code to udelay() between the time that the PRCM deasserts the
+ * IdleAck, and the time when the module is ready to handle register
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

--155748971-1644992186-1286258492=:13816--
