From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling mechanism within
 UART driver
Date: Fri, 29 Jul 2011 20:43:49 +0530
Message-ID: <CAAL8m4wdKu_XGFaGxuAJ9uypRyyQMkR8HL7Y6E=pBkwX=L43nA@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
 <20110729095512.GE31013@legolas.emea.dhcp.ti.com> <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw@mail.gmail.com>
 <20110729113713.GK31013@legolas.emea.dhcp.ti.com> <CAAL8m4wq7RQ_Rp-+LMWYY=dtTnhtR5UY+8HpO5C_54goKezaTg@mail.gmail.com>
 <20110729121907.GM31013@legolas.emea.dhcp.ti.com> <CAAL8m4wQqS64xG0Vi9YCOdy3f2=1V7UkJCErpikHOra4X=g7+w@mail.gmail.com>
 <20110729140210.GT31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41466 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758Ab1G2POL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 11:14:11 -0400
In-Reply-To: <20110729140210.GT31013@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

On Fri, Jul 29, 2011 at 7:32 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Jul 29, 2011 at 06:28:32PM +0530, Govindraj wrote:
>> On Fri, Jul 29, 2011 at 5:49 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > On Fri, Jul 29, 2011 at 05:29:12PM +0530, Govindraj wrote:
>> >> Yes fine, But there are scenarios even before first runtime_suspe=
nd happens,
>> >>
>> >> ex: uart_port_configure -> get_sync -> pm_generic_runtime_resume
>> >> (omap_device_enable in this case) debug printk -> console_write -=
> get_sync.
>> >>
>> >> there are numerous such scenarios where we end from runtime conte=
xt
>> >> to runtime api context again, or jumping from one uart port opera=
tion
>> >> to uart print operation.
>> >
>> > calling pm_runtime_get_sync() should not be a problem. It should o=
nly
>> > increase the usage counters... This sounds like a race condition o=
n the
>> > driver, no ?
>>
>> Actually when we call a API to enable clocks we except the internals=
 of API
>> to just enable clocks and return.
>>
>> *Clock enable API should not cause or trigger to do a _device_driver=
_operation_
>> even before enabling clocks of the device-driver which called it*
>>
>> for uart context get_sync can land me to uart driver back
>> even before enabling the uart clocks due to printks.
>
> only if _you_ have prints or _your_ runtime_*() calls, no ?
>
> Let's say omap_hwmod.c wants to do a print:
>
> -> printk()
> =A0-> pm_runtime_get_sync
> =A0 =A0-> console_write
> =A0-> pm_runtim_put
>
> now, if you have a printk() on your runtime_resume() before you enabl=
e
> the clocks, then I can see why you would deadlock:
>
> -> pm_runtime_get_sync
> =A0-> omap_serial_runtime_resume
> =A0 =A0-> printk
> =A0 =A0 =A0-> pm_runtime_get_sync
> =A0 =A0 =A0 =A0-> omap_serial_runtime_resume
> =A0 =A0 =A0 =A0 =A0-> printk
> =A0 =A0 =A0 =A0 =A0 -> pm_runtime_get_sync
> =A0 =A0 =A0 =A0 =A0 =A0.....
>
> maybe I'm missing something, but can you add a stack dump on your
> ->runtime_resume and ->runtime_suspend methods, just so we try to fig=
ure
> out who's to blame here ?
>
>> > What you're experiencing, if I understood correctly, is a deadlock=
 ? In
>> > that case, can you try to track the locking mechanism on the omap-=
serial
>> > driver to try to find if there isn't anything obviously wrong ?
>> >
>>
>> Yes deadlocks. due to entering from runtime context to runtime conte=
xt
>> or entering from uart_port_operation to uart_console_write ops.
>>
>> There are already port locks used extensively within the uart driver
>> to secure a port operation.
>>
>> But cannot secure a port operation while using clock_enable API.
>> since clock enable API can land the control back to uart_console_wri=
te
>> operation..
>
> but in that case, if clock isn't enabled, why don't you just ignore t=
he
> print and enable the clock ?? Just return 0 and continue with
> clk_enable() ??
>
>> >> So either we should not have those prints from pm_generic layers =
or suppress
>> >> them(seems pretty much a problem for a clean design within the dr=
iver
>> >> using console_lock/unlock for every get_sync, and for
>> >> runtime_put we cannot suppress the prints as it gets scheduled la=
ter)
>> >>
>> >> or if other folks who really need those prints form pm_generic* l=
ayers
>> >> to debug and analysis then we have no other choice rather control
>> >> the clk_enable/disable from outside driver code in idle path.
>> >
>> > yeah, none of these would be nice :-(
>> >
>> > I think this needs more debugging to be sure what's exactly going =
on.
>> > What's exactly causing the deadlock ? Which lock is held and never
>> > released ?
>> >
>>
>> I had done some investigations, from scenarios it simply boils down =
to fact
>> to handle clock within uart driver, uart driver expects clock enable=
 API* used
>> to just enable uart clocks but rather not trigger a _uart_ops_ withi=
n which
>> kind of unacceptable from the uart_driver context.
>
> ok, now I see what you mean:
>
> 113 static int _omap_device_activate(struct omap_device *od, u8 ignor=
e_lat)
> 114 {
> 115 =A0 =A0 =A0 =A0 struct timespec a, b, c;
> 116
> 117 =A0 =A0 =A0 =A0 pr_debug("omap_device: %s: activating\n", od->pde=
v.name);
> 118
> 119 =A0 =A0 =A0 =A0 while (od->pm_lat_level > 0) {
> 120 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_device_pm_latency *od=
pl;
> 121 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long long act_lat =3D 0;
> 122
> 123 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->pm_lat_level--;
> 124
> 125 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl =3D od->pm_lats + od->pm_lat=
_level;
> 126
> 127 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ignore_lat &&
> 128 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (od->dev_wakeup_lat <=3D =
od->_dev_wakeup_lat_limit))
> 129 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> 130
> 131 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_persistent_clock(&a);
> 132
> 133 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX check return code */
> 134 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->activate_func(od);
> 135
> 136 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_persistent_clock(&b);
> 137
> 138 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c =3D timespec_sub(b, a);
> 139 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 act_lat =3D timespec_to_ns(&c);
> 140
> 141 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("omap_device: %s: pm_lat=
 %d: activate: elapsed time "
> 142 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%llu nsec\n",=
 od->pdev.name, od->pm_lat_level,
> 143 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0act_lat);
> 144
> 145 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (act_lat > odpl->activate_lat)=
 {
> 146 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 odpl->activate_la=
t_worst =3D act_lat;
> 147 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (odpl->flags &=
 OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
> 148 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 o=
dpl->activate_lat =3D act_lat;
> 149 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p=
r_warning("omap_device: %s.%d: new worst case "
> 150 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0"activate latency %d: %llu\n",
> 151 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
> 152 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0od->pm_lat_level, act_lat);
> 153 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> 154 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p=
r_warning("omap_device: %s.%d: activate "
> 155 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0"latency %d higher than exptected. "
> 156 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0"(%llu > %d)\n",
> 157 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0od->pdev.name, od->pdev.id,
> 158 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0od->pm_lat_level, act_lat,
> 159 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0odpl->activate_lat);
> 160 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> 161
> 162 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->dev_wakeup_lat -=3D odpl->act=
ivate_lat;
> 163 =A0 =A0 =A0 =A0 }
> 164
> 165 =A0 =A0 =A0 =A0 return 0;
> 166 }
>
> When that first pr_debug() triggers, UART's hwmod could be disabled, =
and
> that would trigger the state I described above where you would keep o=
n
> calling pm_runtime_get_sync() forever ;-)
>
> isn't it enough to patch it like below:
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index b6b4097..560f622 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -114,8 +114,6 @@ static int _omap_device_activate(struct omap_devi=
ce *od, u8 ignore_lat)
> =A0{
> =A0 =A0 =A0 =A0struct timespec a, b, c;
>
> - =A0 =A0 =A0 pr_debug("omap_device: %s: activating\n", od->pdev.name=
);
> -
> =A0 =A0 =A0 =A0while (od->pm_lat_level > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_device_pm_latency *odpl;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long long act_lat =3D 0;
> @@ -162,6 +160,8 @@ static int _omap_device_activate(struct omap_devi=
ce *od, u8 ignore_lat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0od->dev_wakeup_lat -=3D odpl->activate=
_lat;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 pr_debug("omap_device: %s: activated\n", od->pdev.name)=
;
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>

Actually there is much more than this:

<<SNIP>>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 180299e..221ffb9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -12,7 +12,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#undef DEBUG
+//#undef DEBUG
+#define DEBUG

 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -254,14 +255,14 @@ void omap2_clk_disable(struct clk *clk)
 		return;
 	}

-	pr_debug("clock: %s: decrementing usecount\n", clk->name);
+//	pr_debug("clock: %s: decrementing usecount\n", clk->name);

 	clk->usecount--;

 	if (clk->usecount > 0)
 		return;

-	pr_debug("clock: %s: disabling in hardware\n", clk->name);
+//	pr_debug("clock: %s: disabling in hardware\n", clk->name);

 	if (clk->ops && clk->ops->disable) {
 		trace_clock_disable(clk->name, 0, smp_processor_id());
@@ -290,14 +291,14 @@ int omap2_clk_enable(struct clk *clk)
 {
 	int ret;

-	pr_debug("clock: %s: incrementing usecount\n", clk->name);
+//	pr_debug("clock: %s: incrementing usecount\n", clk->name);

 	clk->usecount++;

 	if (clk->usecount > 1)
 		return 0;

-	pr_debug("clock: %s: enabling in hardware\n", clk->name);
+//	pr_debug("clock: %s: enabling in hardware\n", clk->name);

 	if (clk->parent) {
 		ret =3D omap2_clk_enable(clk->parent);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 7ed0479..8ca7d40 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -124,7 +124,8 @@
  * XXX error return values should be checked to ensure that they are
  * appropriate
  */
-#undef DEBUG
+//#undef DEBUG
+#define DEBUG

 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -597,7 +598,8 @@ static int _enable_clocks(struct omap_hwmod *oh)
 {
 	int i;

-	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
+	if (strcmp(oh->class->name, "uart"))
+		pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);

 	if (oh->_clk)
 		clk_enable(oh->_clk);
@@ -627,7 +629,8 @@ static int _disable_clocks(struct omap_hwmod *oh)
 {
 	int i;

-	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
+	if (strcmp(oh->class->name, "uart"))
+		pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);

 	if (oh->_clk)
 		clk_disable(oh->_clk);
@@ -1232,7 +1235,8 @@ static int _enable(struct omap_hwmod *oh)
 		return -EINVAL;
 	}

-	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
+	if (strcmp(oh->class->name, "uart"))
+		pr_debug("omap_hwmod: %s: enabling\n", oh->name);

 	/*
 	 * If an IP contains only one HW reset line, then de-assert it in ord=
er
@@ -1264,8 +1268,9 @@ static int _enable(struct omap_hwmod *oh)
 		}
 	} else {
 		_disable_clocks(oh);
-		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
-			 oh->name, r);
+		if (strcmp(oh->class->name, "uart"))
+			pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
+				 oh->name, r);
 	}

 	return r;
@@ -1287,7 +1292,8 @@ static int _idle(struct omap_hwmod *oh)
 		return -EINVAL;
 	}

-	pr_debug("omap_hwmod: %s: idling\n", oh->name);
+	if (strcmp(oh->class->name, "uart"))
+		pr_debug("omap_hwmod: %s: idling\n", oh->name);

 	if (oh->class->sysc)
 		_idle_sysc(oh);
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap=
_device.c
index 49fc0df..7b27704 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -75,7 +75,8 @@
  * (device must be reinitialized at this point to use it again)
  *
  */
-#undef DEBUG
+//#undef DEBUG
+#define DEBUG

 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -114,7 +115,8 @@ static int _omap_device_activate(struct
omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;

-	pr_debug("omap_device: %s: activating\n", od->pdev.name);
+	if (strcmp(od->hwmods[0]->class->name, "uart"))
+		pr_debug("omap_device: %s: activating\n", od->pdev.name);

 	while (od->pm_lat_level > 0) {
 		struct omap_device_pm_latency *odpl;
@@ -138,25 +140,29 @@ static int _omap_device_activate(struct
omap_device *od, u8 ignore_lat)
 		c =3D timespec_sub(b, a);
 		act_lat =3D timespec_to_ns(&c);

-		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
-			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
-			 act_lat);
+		if (strcmp(od->hwmods[0]->class->name, "uart"))
+			pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
+				 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
+				 act_lat);

 		if (act_lat > odpl->activate_lat) {
 			odpl->activate_lat_worst =3D act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat =3D act_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
-					   "activate latency %d: %llu\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, act_lat);
-			} else
-				pr_warning("omap_device: %s.%d: activate "
-					   "latency %d higher than exptected. "
-					   "(%llu > %d)\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, act_lat,
-					   odpl->activate_lat);
+				if (strcmp(od->hwmods[0]->class->name, "uart"))
+					pr_warning("omap_device: %s.%d: new worst case "
+						"activate latency %d: %llu\n",
+						od->pdev.name, od->pdev.id,
+						od->pm_lat_level, act_lat);
+			} else {
+				if (strcmp(od->hwmods[0]->class->name, "uart"))
+					pr_warning("omap_device: %s.%d: activate "
+						"latency %d higher than exptected. "
+						"(%llu > %d)\n",
+						od->pdev.name, od->pdev.id,
+						od->pm_lat_level, act_lat,
+						odpl->activate_lat);
+			}
 		}

 		od->dev_wakeup_lat -=3D odpl->activate_lat;
@@ -183,7 +189,8 @@ static int _omap_device_deactivate(struct
omap_device *od, u8 ignore_lat)
 {
 	struct timespec a, b, c;

-	pr_debug("omap_device: %s: deactivating\n", od->pdev.name);
+	if (strcmp(od->hwmods[0]->class->name, "uart"))
+		pr_debug("omap_device: %s: deactivating\n", od->pdev.name);

 	while (od->pm_lat_level < od->pm_lats_cnt) {
 		struct omap_device_pm_latency *odpl;
@@ -206,25 +213,29 @@ static int _omap_device_deactivate(struct
omap_device *od, u8 ignore_lat)
 		c =3D timespec_sub(b, a);
 		deact_lat =3D timespec_to_ns(&c);

-		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
-			 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
-			 deact_lat);
+		if (strcmp(od->hwmods[0]->class->name, "uart"))
+			pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
+				 "%llu nsec\n", od->pdev.name, od->pm_lat_level,
+				 deact_lat);

 		if (deact_lat > odpl->deactivate_lat) {
 			odpl->deactivate_lat_worst =3D deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat =3D deact_lat;
-				pr_warning("omap_device: %s.%d: new worst case "
-					   "deactivate latency %d: %llu\n",
-					   od->pdev.name, od->pdev.id,
-					   od->pm_lat_level, deact_lat);
-			} else
-				pr_warning("omap_device: %s.%d: deactivate "
+				if (strcmp(od->hwmods[0]->class->name, "uart"))
+					pr_warning("omap_device: %s.%d: new worst case "
+						   "deactivate latency %d: %llu\n",
+						   od->pdev.name, od->pdev.id,
+						   od->pm_lat_level, deact_lat);
+			} else {
+				if (strcmp(od->hwmods[0]->class->name, "uart"))
+					pr_warning("omap_device: %s.%d: deactivate "
 					   "latency %d higher than exptected. "
 					   "(%llu > %d)\n",
 					   od->pdev.name, od->pdev.id,
 					   od->pm_lat_level, deact_lat,
 					   odpl->deactivate_lat);
+			}
 		}


<<SNIP>>


>
> either the above or something like:
>
> if (pm_runtime_suspended(dev))
> =A0 =A0 =A0 =A0return 0;
>
> on console_write() ??

Consider the scenario where after bootup uart is idled
with runtime auto suspend so now state of console
uart is RPM_SUSPENDED.

Now you connect a pendrive to ehci-port.

Missing critical usb host <-> device_enumeration prints?

uart_console rpm_suspended state ->

usb_device mass storage device found print ->

console_write -> return without printing.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
