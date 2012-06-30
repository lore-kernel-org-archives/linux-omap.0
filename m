From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 4/4] memory: emif: add device tree support to emif driver
Date: Sat, 30 Jun 2012 09:38:41 +0530
Message-ID: <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com> <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:44064 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750699Ab2F3EJH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Jun 2012 00:09:07 -0400
Received: by qabj34 with SMTP id j34so1007720qab.4
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 21:09:03 -0700 (PDT)
In-Reply-To: <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com

(+ Greg, By mistake the your name got dropped cc from list)

On Fri, Jun 29, 2012 at 7:13 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> From: Aneesh V <aneesh@ti.com>
>
> Device tree support for the EMIF driver.
>
> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> [santosh.shilimkar@ti.com: Rebased against 3.5-rc]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0drivers/memory/emif.c | =A0291 +++++++++++++++++++++++++++++++++++=
+++++++++++++-
> =A01 file changed, 290 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
> index 33a4396..101997b 100644
> --- a/drivers/memory/emif.c
> +++ b/drivers/memory/emif.c
> @@ -18,6 +18,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/slab.h>
> +#include <linux/of.h>
> =A0#include <linux/debugfs.h>
> =A0#include <linux/seq_file.h>
> =A0#include <linux/module.h>
> @@ -49,6 +50,7 @@
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frequenc=
y in effect at the moment)
> =A0* @plat_data: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Pointer to saved pla=
tform data.
> =A0* @debugfs_root: =A0 =A0 =A0 =A0 =A0 =A0 =A0dentry to the root fol=
der for EMIF in debugfs
> + * @np_ddr: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pointer to ddr de=
vice tree node
> =A0*/
> =A0struct emif_data {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0duplicate;
> @@ -63,6 +65,7 @@ struct emif_data {
> =A0 =A0 =A0 =A0struct emif_regs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*curr_=
regs;
> =A0 =A0 =A0 =A0struct emif_platform_data =A0 =A0 =A0 *plat_data;
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deb=
ugfs_root;
> + =A0 =A0 =A0 struct device_node =A0 =A0 =A0 =A0 =A0 =A0 =A0*np_ddr;
> =A0};
>
> =A0static struct emif_data *emif1;
> @@ -1148,6 +1151,278 @@ static int is_custom_config_valid(struct emif=
_custom_configs *cust_cfgs,
> =A0 =A0 =A0 =A0return valid;
> =A0}
>
> +#if defined(CONFIG_OF)
> +static void __init_or_module of_get_custom_configs(struct device_nod=
e *np_emif,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct emif_data *emif)
> +{
> + =A0 =A0 =A0 struct emif_custom_configs =A0 =A0 =A0*cust_cfgs =3D NU=
LL;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 len;
> + =A0 =A0 =A0 const int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *=
lpmode, *poll_intvl;
> +
> + =A0 =A0 =A0 lpmode =3D of_get_property(np_emif, "low-power-mode", &=
len);
> + =A0 =A0 =A0 poll_intvl =3D of_get_property(np_emif, "temp-alert-pol=
l-interval", &len);
> +
> + =A0 =A0 =A0 if (lpmode || poll_intvl)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cust_cfgs =3D devm_kzalloc(emif->dev, s=
izeof(*cust_cfgs),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> +
> + =A0 =A0 =A0 if (!cust_cfgs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (lpmode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cust_cfgs->mask |=3D EMIF_CUSTOM_CONFIG=
_LPMODE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cust_cfgs->lpmode =3D *lpmode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np_emif,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "low-po=
wer-mode-timeout-performance",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cust_c=
fgs->lpmode_timeout_performance);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np_emif,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "low-po=
wer-mode-timeout-power",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cust_c=
fgs->lpmode_timeout_power);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(np_emif,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "low-po=
wer-mode-freq-threshold",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cust_c=
fgs->lpmode_freq_threshold);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (poll_intvl) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cust_cfgs->mask |=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EMIF_CU=
STOM_CONFIG_TEMP_ALERT_POLL_INTERVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cust_cfgs->temp_alert_poll_interval_ms =
=3D *poll_intvl;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!is_custom_config_valid(cust_cfgs, emif->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(emif->dev, cust_cfgs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 emif->plat_data->custom_configs =3D cust_cfgs;
> +}
> +
> +static void __init_or_module of_get_min_tck(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct emif_data *emif)
> +{
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 struct lpddr2_min_tck =A0 *min;
> +
> + =A0 =A0 =A0 min =3D devm_kzalloc(emif->dev, sizeof(*min), GFP_KERNE=
L);
> + =A0 =A0 =A0 if (!min)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto default_min_tck;
> +
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRPab-min-tck", &min=
->tRPab);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRCD-min-tck", &min-=
>tRCD);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tWR-min-tck", &min->=
tWR);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRASmin-min-tck", &m=
in->tRASmin);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRRD-min-tck", &min-=
>tRRD);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tWTR-min-tck", &min-=
>tWTR);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tXP-min-tck", &min->=
tXP);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRTP-min-tck", &min-=
>tRTP);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tCKE-min-tck", &min-=
>tCKE);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tCKESR-min-tck", &mi=
n->tCKESR);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tFAW-min-tck", &min-=
>tFAW);
> +
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kfree(emif->dev, min);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto default_min_tck;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 emif->plat_data->min_tck =3D min;
> + =A0 =A0 =A0 return;
> +
> +default_min_tck:
> + =A0 =A0 =A0 dev_warn(emif->dev, "%s: using default min-tck values\n=
", __func__);
> + =A0 =A0 =A0 emif->plat_data->min_tck =3D &lpddr2_jedec_min_tck;
> +}
> +
> +static int __init_or_module of_do_get_timings(struct device_node *np=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct lpddr2_timings *tim)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D of_property_read_u32(np, "max-freq", &tim->max_=
freq);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "min-freq", &tim->min=
_freq);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRPab", &tim->tRPab)=
;
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRCD", &tim->tRCD);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tWR", &tim->tWR);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRAS-min", &tim->tRA=
S_min);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRRD", &tim->tRRD);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tWTR", &tim->tWTR);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tXP", &tim->tXP);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRTP", &tim->tRTP);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tCKESR", &tim->tCKES=
R);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tDQSCK-max", &tim->t=
DQSCK_max);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tFAW", &tim->tFAW);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tZQCS", &tim->tZQCS)=
;
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tZQCL", &tim->tZQCL)=
;
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tZQinit", &tim->tZQi=
nit);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tRAS-max-ns", &tim->=
tRAS_max_ns);
> + =A0 =A0 =A0 ret |=3D of_property_read_u32(np, "tDQSCK-max-derated",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 &tim->tDQSCK_max_derated);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void __init_or_module of_get_ddr_timings(struct device_node *=
np_ddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct emif_data *emif)
> +{
> + =A0 =A0 =A0 struct lpddr2_timings =A0 *timings =3D NULL;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arr_sz =3D =
0, i =3D 0;
> + =A0 =A0 =A0 struct device_node =A0 =A0 =A0*np_tim;
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*tim_compat=
;
> +
> + =A0 =A0 =A0 switch (emif->plat_data->device_info->type) {
> + =A0 =A0 =A0 case DDR_TYPE_LPDDR2_S2:
> + =A0 =A0 =A0 case DDR_TYPE_LPDDR2_S4:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tim_compat =3D "jedec,lpddr2-timings";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(emif->dev, "%s: un-supported m=
emory type\n", __func__);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for_each_child_of_node(np_ddr, np_tim)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(np_tim, tim=
_compat))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arr_sz++;
> +
> + =A0 =A0 =A0 if (arr_sz)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings =3D devm_kzalloc(emif->dev, siz=
eof(*timings) * arr_sz,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> +
> + =A0 =A0 =A0 if (!timings)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto default_timings;
> +
> + =A0 =A0 =A0 for_each_child_of_node(np_ddr, np_tim) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(np_tim, tim=
_compat)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_do_get_timings(n=
p_tim, &timings[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devm_kf=
ree(emif->dev, timings);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto de=
fault_timings;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 emif->plat_data->timings =3D timings;
> + =A0 =A0 =A0 emif->plat_data->timings_arr_size =3D arr_sz;
> +
> + =A0 =A0 =A0 return;
> +
> +default_timings:
> + =A0 =A0 =A0 get_default_timings(emif);
> +
> + =A0 =A0 =A0 return;
> +}
> +
> +static void __init_or_module of_get_ddr_info(struct device_node *np_=
emif,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np_ddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ddr_device_info *dev_info)
> +{
> + =A0 =A0 =A0 u32 density =3D 0, io_width =3D 0;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 if (of_find_property(np_emif, "cs1-used", &len))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->cs1_used =3D true;
> +
> + =A0 =A0 =A0 if (of_find_property(np_emif, "cal-resistor-per-cs", &l=
en))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->cal_resistors_per_cs =3D true=
;
> +
> + =A0 =A0 =A0 if (of_device_is_compatible(np_ddr , "jedec,lpddr2-s4")=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->type =3D DDR_TYPE_LPDDR2_S4;
> + =A0 =A0 =A0 else if (of_device_is_compatible(np_ddr , "jedec,lpddr2=
-s2"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->type =3D DDR_TYPE_LPDDR2_S2;
> +
> + =A0 =A0 =A0 of_property_read_u32(np_ddr, "density", &density);
> + =A0 =A0 =A0 of_property_read_u32(np_ddr, "io-width", &io_width);
> +
> + =A0 =A0 =A0 /* Convert from density in Mb to the density encoding i=
n jedc_ddr.h */
> + =A0 =A0 =A0 if (density & (density - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->density =3D 0;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->density =3D __fls(density) - =
5;
> +
> + =A0 =A0 =A0 /* Convert from io_width in bits to io_width encoding i=
n jedc_ddr.h */
> + =A0 =A0 =A0 if (io_width & (io_width - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->io_width =3D 0;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info->io_width =3D __fls(io_width) =
- 1;
> +}
> +
> +static struct emif_data * __init_or_module of_get_device_details(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np_emif, struct dev=
ice *dev)
> +{
> + =A0 =A0 =A0 struct emif_data =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*emif =3D=
 NULL;
> + =A0 =A0 =A0 struct ddr_device_info =A0 =A0 =A0 =A0 =A0*dev_info =3D=
 NULL;
> + =A0 =A0 =A0 struct emif_platform_data =A0 =A0 =A0 *pd =3D NULL;
> + =A0 =A0 =A0 struct device_node =A0 =A0 =A0 =A0 =A0 =A0 =A0*np_ddr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 len;
> +
> + =A0 =A0 =A0 np_ddr =3D of_parse_phandle(np_emif, "device-handle", 0=
);
> + =A0 =A0 =A0 if (!np_ddr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 emif =A0 =A0=3D devm_kzalloc(dev, sizeof(struct emif_da=
ta), GFP_KERNEL);
> + =A0 =A0 =A0 pd =A0 =A0 =A0=3D devm_kzalloc(dev, sizeof(*pd), GFP_KE=
RNEL);
> + =A0 =A0 =A0 dev_info =3D devm_kzalloc(dev, sizeof(*dev_info), GFP_K=
ERNEL);
> +
> + =A0 =A0 =A0 if (!emif || !pd || !dev_info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: of_get_device_details=
() failure!!\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 emif->plat_data =A0 =A0 =A0 =A0 =3D pd;
> + =A0 =A0 =A0 pd->device_info =A0 =A0 =A0 =A0 =3D dev_info;
> + =A0 =A0 =A0 emif->dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D dev;
> + =A0 =A0 =A0 emif->np_ddr =A0 =A0 =A0 =A0 =A0 =A0=3D np_ddr;
> + =A0 =A0 =A0 emif->temperature_level =3D SDRAM_TEMP_NOMINAL;
> +
> + =A0 =A0 =A0 if (of_device_is_compatible(np_emif, "ti,emif-4d"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif->plat_data->ip_rev =3D EMIF_4D;
> + =A0 =A0 =A0 else if (of_device_is_compatible(np_emif, "ti,emif-4d5"=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif->plat_data->ip_rev =3D EMIF_4D5;
> +
> + =A0 =A0 =A0 of_property_read_u32(np_emif, "phy-type", &pd->phy_type=
);
> +
> + =A0 =A0 =A0 if (of_find_property(np_emif, "hw-caps-ll-interface", &=
len))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->hw_caps |=3D EMIF_HW_CAPS_LL_INTERF=
ACE;
> +
> + =A0 =A0 =A0 of_get_ddr_info(np_emif, np_ddr, dev_info);
> + =A0 =A0 =A0 if (!is_dev_data_valid(pd->device_info->type, pd->devic=
e_info->density,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->device_info->io_wid=
th, pd->phy_type, pd->ip_rev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "%s: invalid device data!!=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For EMIF instances other than EMIF1 see if the dev=
ices connected
> + =A0 =A0 =A0 =A0* are exactly same as on EMIF1(which is typically th=
e case). If so,
> + =A0 =A0 =A0 =A0* mark it as a duplicate of EMIF1. This will save so=
me memory and
> + =A0 =A0 =A0 =A0* computation.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (emif1 && emif1->np_ddr =3D=3D np_ddr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif->duplicate =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 } else if (emif1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(emif->dev, "%s: Non-symmetric =
DDR geometry\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 of_get_custom_configs(np_emif, emif);
> + =A0 =A0 =A0 of_get_ddr_timings(np_ddr, emif);
> + =A0 =A0 =A0 of_get_min_tck(np_ddr, emif);
> + =A0 =A0 =A0 goto out;
> +
> +error:
> + =A0 =A0 =A0 return NULL;
> +out:
> + =A0 =A0 =A0 return emif;
> +}
> +
> +#else
> +
> +static struct emif_data * __init_or_module of_get_device_details(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np_emif, struct dev=
ice *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +#endif
> +
> =A0static struct emif_data *__init_or_module get_device_details(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct platform_device *pdev)
> =A0{
> @@ -1267,7 +1542,11 @@ static int __init_or_module emif_probe(struct =
platform_device *pdev)
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *res;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>
> - =A0 =A0 =A0 emif =3D get_device_details(pdev);
> + =A0 =A0 =A0 if (pdev->dev.of_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif =3D of_get_device_details(pdev->de=
v.of_node, &pdev->dev);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 emif =3D get_device_details(pdev);
> +
> =A0 =A0 =A0 =A0if (!emif) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: error getting device data\=
n", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error;
> @@ -1644,11 +1923,21 @@ static void __attribute__((unused)) freq_post=
_notify_handling(void)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&emif_lock, irq_state);
> =A0}
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id emif_of_match[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,emif-4d" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { .compatible =3D "ti,emif-4d5" },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, emif_of_match);
> +#endif
> +
> =A0static struct platform_driver emif_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __exit_p(emif_remove),
> =A0 =A0 =A0 =A0.shutdown =A0 =A0 =A0 =3D emif_shutdown,
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "emif",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D of_match_ptr(emif_o=
f_match),
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
