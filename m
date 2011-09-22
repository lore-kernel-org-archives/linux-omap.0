From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 09/12] OMAP: dmtimer: low-power mode support
Date: Thu, 22 Sep 2011 11:37:35 +0530
Message-ID: <CAC83ZvJau4bs5UiMeSrgyFw0KepSOgqNYsUXpZU_zYY9bdRvwA@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-10-git-send-email-tarun.kanti@ti.com>
	<20110922010015.GP2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110922010015.GP2937@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 22, 2011 at 6:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> Clock is enabled only when timer is started and disabled when the the ti=
mer
>> is stopped. Therefore before accessing registers in functions clock is e=
nabled
>> and then disabled back at the end of access. Context save is done dynami=
cally
>> whenever the registers are modified. Context restore is called when cont=
ext is
>> lost.
>
> I've updated this to use revision instead of tidr. Updated patch below.
Ok.
--
Tarun
>
> Regards,
>
> Tony
>
>
> From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Date: Tue, 20 Sep 2011 17:00:24 +0530
> Subject: [PATCH] ARM: OMAP: dmtimer: low-power mode support
>
> Clock is enabled only when timer is started and disabled when the the tim=
er
> is stopped. Therefore before accessing registers in functions clock is en=
abled
> and then disabled back at the end of access. Context save is done dynamic=
ally
> whenever the registers are modified. Context restore is called when conte=
xt is
> lost.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [tony@atomide.com: updated to use revision instead of tidr]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index f1e3ec1..1140e98 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -44,6 +44,9 @@
> =A0#include <plat/common.h>
> =A0#include <plat/omap_hwmod.h>
> =A0#include <plat/omap_device.h>
> +#include <plat/omap-pm.h>
> +
> +#include "powerdomain.h"
>
> =A0/* Parent clocks, eventually these will come from the clock framework =
*/
>
> @@ -433,6 +436,7 @@ static int __init omap_timer_init(struct omap_hwmod *=
oh, void *unused)
> =A0 =A0 =A0 =A0struct dmtimer_platform_data *pdata;
> =A0 =A0 =A0 =A0struct omap_device *od;
> =A0 =A0 =A0 =A0struct omap_timer_capability_dev_attr *timer_dev_attr;
> + =A0 =A0 =A0 struct powerdomain *pwrdm;
>
> =A0 =A0 =A0 =A0pr_debug("%s: %s\n", __func__, oh->name);
>
> @@ -467,6 +471,11 @@ static int __init omap_timer_init(struct omap_hwmod =
*oh, void *unused)
> =A0 =A0 =A0 =A0if ((sys_timer_reserved >> (id - 1)) & 0x1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->reserved =3D 1;
>
> + =A0 =A0 =A0 pwrdm =3D omap_hwmod_get_pwrdm(oh);
> + =A0 =A0 =A0 pdata->loses_context =3D pwrdm_can_ever_lose_context(pwrdm);
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 pdata->get_context_loss_count =3D omap_pm_get_dev_context_l=
oss_count;
> +#endif
> =A0 =A0 =A0 =A0od =3D omap_device_build(name, id, oh, pdata, sizeof(*pdat=
a),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_dmtimer_latency,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(omap2_dmtimer_l=
atency),
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index c8df3c3..43eb750 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -77,6 +77,29 @@ static void omap_dm_timer_write_reg(struct omap_dm_tim=
er *timer, u32 reg,
> =A0 =A0 =A0 =A0__omap_dm_timer_write(timer, reg, value, timer->posted);
> =A0}
>
> +static void omap_timer_restore_context(struct omap_dm_timer *timer)
> +{
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_OFFSET,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tiocp_cfg);
> + =A0 =A0 =A0 if (timer->revision > 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(timer->context.tistat, timer->=
sys_stat);
> +
> + =A0 =A0 =A0 __raw_writel(timer->context.tisr, timer->irq_stat);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.twer);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tcrr);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tldr);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tmar);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tsicr);
> + =A0 =A0 =A0 __raw_writel(timer->context.tier, timer->irq_ena);
> + =A0 =A0 =A0 omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->cont=
ext.tclr);
> +}
> +
> =A0static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
> =A0{
> =A0 =A0 =A0 =A0int c;
> @@ -96,12 +119,14 @@ static void omap_dm_timer_wait_for_reset(struct omap=
_dm_timer *timer)
>
> =A0static void omap_dm_timer_reset(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0if (timer->pdev->id !=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_=
IF_CTRL_REG, 0x06);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_wait_for_reset(timer);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0__omap_dm_timer_reset(timer, 0, 0);
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0 =A0 =A0 =A0timer->posted =3D 1;
> =A0}
>
> @@ -117,8 +142,6 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap_dm_timer_enable(timer);
> -
> =A0 =A0 =A0 =A0if (pdata->needs_manual_reset)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_reset(timer);
>
> @@ -193,7 +216,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
>
> =A0void omap_dm_timer_free(struct omap_dm_timer *timer)
> =A0{
> - =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0 =A0 =A0 =A0clk_put(timer->fclk);
>
> =A0 =A0 =A0 =A0WARN_ON(!timer->reserved);
> @@ -275,6 +297,11 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
>
> =A0void omap_dm_timer_trigger(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: timer%d not enabled.\n", __func=
__, timer->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_trigger);
> @@ -283,11 +310,23 @@ void omap_dm_timer_start(struct omap_dm_timer *time=
r)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> +
> + =A0 =A0 =A0 if (timer->loses_context) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctx_loss_cnt_after =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss_cou=
nt(&timer->pdev->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctx_loss_cnt_after !=3D timer->ctx_loss=
_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_timer_restore_context(=
timer);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0if (!(l & OMAP_TIMER_CTRL_ST)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_ST;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_=
CTRL_REG, l);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_start);
>
> @@ -311,9 +350,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *ti=
mer, int source)
> =A0 =A0 =A0 =A0if (source < 0 || source >=3D 3)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0 =A0 =A0 =A0ret =3D pdata->set_timer_src(timer->pdev, source);
> - =A0 =A0 =A0 omap_dm_timer_enable(timer);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -324,6 +361,7 @@ void omap_dm_timer_set_load(struct omap_dm_timer *tim=
er, int autoreload,
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0if (autoreload)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_AR;
> @@ -333,6 +371,10 @@ void omap_dm_timer_set_load(struct omap_dm_timer *ti=
mer, int autoreload,
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
>
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> + =A0 =A0 =A0 timer->context.tldr =3D load;
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_load);
>
> @@ -342,6 +384,15 @@ void omap_dm_timer_set_load_start(struct omap_dm_tim=
er *timer, int autoreload,
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> +
> + =A0 =A0 =A0 if (timer->loses_context) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctx_loss_cnt_after =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->get_context_loss_cou=
nt(&timer->pdev->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ctx_loss_cnt_after !=3D timer->ctx_loss=
_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_timer_restore_context(=
timer);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0if (autoreload) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_AR;
> @@ -352,6 +403,11 @@ void omap_dm_timer_set_load_start(struct omap_dm_tim=
er *timer, int autoreload,
> =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_ST;
>
> =A0 =A0 =A0 =A0__omap_dm_timer_load_start(timer, l, load, timer->posted);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> + =A0 =A0 =A0 timer->context.tldr =3D load;
> + =A0 =A0 =A0 timer->context.tcrr =3D load;
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_load_start);
>
> @@ -360,6 +416,7 @@ void omap_dm_timer_set_match(struct omap_dm_timer *ti=
mer, int enable,
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0if (enable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_CE;
> @@ -367,6 +424,11 @@ void omap_dm_timer_set_match(struct omap_dm_timer *t=
imer, int enable,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~OMAP_TIMER_CTRL_CE;
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match=
);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> + =A0 =A0 =A0 timer->context.tmar =3D match;
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_match);
>
> @@ -375,6 +437,7 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *time=
r, int def_on,
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0l &=3D ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_TIMER_CTRL_PT | (0x03 << 10));
> @@ -384,6 +447,10 @@ void omap_dm_timer_set_pwm(struct omap_dm_timer *tim=
er, int def_on,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D OMAP_TIMER_CTRL_PT;
> =A0 =A0 =A0 =A0l |=3D trigger << 10;
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_pwm);
>
> @@ -391,6 +458,7 @@ void omap_dm_timer_set_prescaler(struct omap_dm_timer=
 *timer, int prescaler)
> =A0{
> =A0 =A0 =A0 =A0u32 l;
>
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> =A0 =A0 =A0 =A0l &=3D ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
> =A0 =A0 =A0 =A0if (prescaler >=3D 0x00 && prescaler <=3D 0x07) {
> @@ -398,13 +466,23 @@ void omap_dm_timer_set_prescaler(struct omap_dm_tim=
er *timer, int prescaler)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D prescaler << 2;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tclr =3D l;
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_prescaler);
>
> =A0void omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsign=
ed int value)
> =A0{
> + =A0 =A0 =A0 omap_dm_timer_enable(timer);
> =A0 =A0 =A0 =A0__omap_dm_timer_int_enable(timer, value);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tier =3D value;
> + =A0 =A0 =A0 timer->context.twer =3D value;
> + =A0 =A0 =A0 omap_dm_timer_disable(timer);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
>
> @@ -412,6 +490,11 @@ unsigned int omap_dm_timer_read_status(struct omap_d=
m_timer *timer)
> =A0{
> =A0 =A0 =A0 =A0unsigned int l;
>
> + =A0 =A0 =A0 if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: timer%d not enabled.\n", __func=
__, timer->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0l =3D __raw_readl(timer->irq_stat);
>
> =A0 =A0 =A0 =A0return l;
> @@ -421,18 +504,33 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_read_status);
> =A0void omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned =
int value)
> =A0{
> =A0 =A0 =A0 =A0__omap_dm_timer_write_status(timer, value);
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tisr =3D value;
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_write_status);
>
> =A0unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: timer%d not enabled.\n", __func=
__, timer->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return __omap_dm_timer_read_counter(timer, timer->posted);
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
>
> =A0void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned=
 int value)
> =A0{
> + =A0 =A0 =A0 if (unlikely(pm_runtime_suspended(&timer->pdev->dev))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: timer%d not enabled.\n", __func=
__, timer->id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, val=
ue);
> +
> + =A0 =A0 =A0 /* Save the context */
> + =A0 =A0 =A0 timer->context.tcrr =3D value;
> =A0}
> =A0EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
>
> @@ -511,6 +609,8 @@ static int __devinit omap_dm_timer_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0timer->irq =3D irq->start;
> =A0 =A0 =A0 =A0timer->reserved =3D pdata->reserved;
> =A0 =A0 =A0 =A0timer->pdev =3D pdev;
> + =A0 =A0 =A0 timer->loses_context =3D pdata->loses_context;
> + =A0 =A0 =A0 timer->get_context_loss_count =3D pdata->get_context_loss_c=
ount;
>
> =A0 =A0 =A0 =A0/* Skip pm_runtime_enable for OMAP1 */
> =A0 =A0 =A0 =A0if (!pdata->needs_manual_reset) {
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-om=
ap/include/plat/dmtimer.h
> index 29764c3..9519d87 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -73,11 +73,38 @@ struct omap_timer_capability_dev_attr {
> =A0struct omap_dm_timer;
> =A0struct clk;
>
> +struct timer_regs {
> + =A0 =A0 =A0 u32 tidr;
> + =A0 =A0 =A0 u32 tiocp_cfg;
> + =A0 =A0 =A0 u32 tistat;
> + =A0 =A0 =A0 u32 tisr;
> + =A0 =A0 =A0 u32 tier;
> + =A0 =A0 =A0 u32 twer;
> + =A0 =A0 =A0 u32 tclr;
> + =A0 =A0 =A0 u32 tcrr;
> + =A0 =A0 =A0 u32 tldr;
> + =A0 =A0 =A0 u32 ttrg;
> + =A0 =A0 =A0 u32 twps;
> + =A0 =A0 =A0 u32 tmar;
> + =A0 =A0 =A0 u32 tcar1;
> + =A0 =A0 =A0 u32 tsicr;
> + =A0 =A0 =A0 u32 tcar2;
> + =A0 =A0 =A0 u32 tpir;
> + =A0 =A0 =A0 u32 tnir;
> + =A0 =A0 =A0 u32 tcvr;
> + =A0 =A0 =A0 u32 tocr;
> + =A0 =A0 =A0 u32 towr;
> +};
> +
> =A0struct dmtimer_platform_data {
> =A0 =A0 =A0 =A0int (*set_timer_src)(struct platform_device *pdev, int sou=
rce);
> =A0 =A0 =A0 =A0int timer_ip_version;
> =A0 =A0 =A0 =A0u32 needs_manual_reset:1;
> =A0 =A0 =A0 =A0bool reserved;
> +
> + =A0 =A0 =A0 bool loses_context;
> +
> + =A0 =A0 =A0 u32 (*get_context_loss_count)(struct device *dev);
> =A0};
>
> =A0struct omap_dm_timer *omap_dm_timer_request(void);
> @@ -245,8 +272,14 @@ struct omap_dm_timer {
> =A0 =A0 =A0 =A0unsigned long rate;
> =A0 =A0 =A0 =A0unsigned reserved:1;
> =A0 =A0 =A0 =A0unsigned posted:1;
> + =A0 =A0 =A0 struct timer_regs context;
> + =A0 =A0 =A0 bool loses_context;
> + =A0 =A0 =A0 int ctx_loss_count;
> + =A0 =A0 =A0 int revision;
> =A0 =A0 =A0 =A0struct platform_device *pdev;
> =A0 =A0 =A0 =A0struct list_head node;
> +
> + =A0 =A0 =A0 u32 (*get_context_loss_count)(struct device *dev);
> =A0};
>
> =A0int omap_dm_timer_prepare(struct omap_dm_timer *timer);
> @@ -278,6 +311,7 @@ static inline void __omap_dm_timer_init_regs(struct o=
map_dm_timer *timer)
> =A0 =A0 =A0 =A0/* Assume v1 ip if bits [31:16] are zero */
> =A0 =A0 =A0 =A0tidr =3D __raw_readl(timer->io_base);
> =A0 =A0 =A0 =A0if (!(tidr >> 16)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->revision =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->sys_stat =3D timer->io_base +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_TIMER=
_V1_SYS_STAT_OFFSET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->irq_stat =3D timer->io_base + OMAP_=
TIMER_V1_STAT_OFFSET;
> @@ -286,6 +320,7 @@ static inline void __omap_dm_timer_init_regs(struct o=
map_dm_timer *timer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->pend =3D timer->io_base + _OMAP_TIM=
ER_WRITE_PEND_OFFSET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->func_base =3D timer->io_base;
> =A0 =A0 =A0 =A0} else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->revision =3D 2;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->sys_stat =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->irq_stat =3D timer->io_base + OMAP_=
TIMER_V2_IRQSTATUS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timer->irq_ena =3D timer->io_base + OMAP_T=
IMER_V2_IRQENABLE_SET;
>
