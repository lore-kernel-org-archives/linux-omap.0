From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 04/19] OMAP2+: voltage: start towards a new
 voltagedomain layer
Date: Fri, 25 Mar 2011 09:59:52 +0100
Message-ID: <AANLkTik6uz+SUHsZXzhJ8c6G7EdOt3ZjCWw2JUOPuZii@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57417 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab1CYI7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 04:59:53 -0400
Received: by qyg14 with SMTP id 14so543079qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 01:59:52 -0700 (PDT)
In-Reply-To: <1300924833-26745-5-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> Start cleaning up the voltage layer to have a voltage domain layer
> that resembles thae structure of the existing clock and power domain
s/thae/the

> layers. =A0To that end:
Extra space

>
> - move the 'struct voltagedomain' out of 'struct omap_vdd_info' to
> =A0become the primary data structure.
>
> - convert any functions taking a pointer to struct omap_vdd_info into
> =A0functions taking a struct voltagedomain pointer.
>
> - convert the register & initialize of voltage domains to look like
> =A0that of powerdomains
>
> - convert omap_voltage_domain_lookup() to voltdm_lookup(), modeled
> =A0after the current powerdomain and clockdomain lookup functions.
>
> - omap_voltage_late_init(): only configure VDD info when
> =A0the vdd_info struct is non-NULL
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A03 +
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 +-
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
257 ++++++++++++++-----------
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 27 ++--
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 34 ++--
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 44 ++--
> =A08 files changed, 207 insertions(+), 172 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 441e79d..44c2c3e 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -38,6 +38,7 @@
> =A0#include "io.h"
>
> =A0#include <plat/omap-pm.h>
> +#include "voltage.h"
> =A0#include "powerdomain.h"
>
> =A0#include "clockdomain.h"
> @@ -363,10 +364,12 @@ void __init omap2_init_common_infrastructure(vo=
id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2xxx_clockdomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2430_hwmod_init();
> =A0 =A0 =A0 =A0} else if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3xxx_voltagedomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3xxx_powerdomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3xxx_clockdomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3xxx_hwmod_init();
> =A0 =A0 =A0 =A0} else if (cpu_is_omap44xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap44xx_voltagedomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap44xx_powerdomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap44xx_clockdomains_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap44xx_hwmod_init();
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 0a8e74e..287aef2 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -250,13 +250,13 @@ int __init omap4_twl_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap44xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("mpu");
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup("mpu");
> =A0 =A0 =A0 =A0omap_voltage_register_pmic(voltdm, &omap4_mpu_volt_inf=
o);
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("iva");
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup("iva");
> =A0 =A0 =A0 =A0omap_voltage_register_pmic(voltdm, &omap4_iva_volt_inf=
o);
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("core");
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup("core");
> =A0 =A0 =A0 =A0omap_voltage_register_pmic(voltdm, &omap4_core_volt_in=
fo);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -288,10 +288,10 @@ int __init omap3_twl_init(void)
> =A0 =A0 =A0 =A0if (!twl_sr_enable_autoinit)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_twl_set_sr_bit(true);
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("mpu");
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup("mpu");
> =A0 =A0 =A0 =A0omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_inf=
o);
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup("core");
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup("core");
> =A0 =A0 =A0 =A0omap_voltage_register_pmic(voltdm, &omap3_core_volt_in=
fo);
>
> =A0 =A0 =A0 =A0return 0;
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 49486f5..917e1e3 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -181,7 +181,7 @@ static int __init omap2_set_init_voltage(char *vd=
d_name, char *clk_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 voltdm =3D omap_voltage_domain_lookup(vdd_name);
> + =A0 =A0 =A0 voltdm =3D voltdm_lookup(vdd_name);
> =A0 =A0 =A0 =A0if (IS_ERR(voltdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Unable to get vdd=
 pointer for vdd_%s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, vdd_name);
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr=
_device.c
> index 10d3c5e..2782d3f 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -102,7 +102,7 @@ static int sr_dev_init(struct omap_hwmod *oh, voi=
d *user)
> =A0 =A0 =A0 =A0sr_data->senn_mod =3D 0x1;
> =A0 =A0 =A0 =A0sr_data->senp_mod =3D 0x1;
>
> - =A0 =A0 =A0 sr_data->voltdm =3D omap_voltage_domain_lookup(oh->vdd_=
name);
> + =A0 =A0 =A0 sr_data->voltdm =3D voltdm_lookup(oh->vdd_name);
> =A0 =A0 =A0 =A0if (IS_ERR(sr_data->voltdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Unable to get voltage doma=
in pointer for VDD %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, oh->vdd_name=
);
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index 15a9cb8..f995003 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -40,20 +40,13 @@
> =A0#include "vc.h"
> =A0#include "vp.h"
>
> -#define VOLTAGE_DIR_SIZE =A0 =A0 =A0 16
> -
> -
> -static struct omap_vdd_info **vdd_info;
> -
> -/*
> - * Number of scalable voltage domains.
> - */
> -static int nr_scalable_vdd;
> +static LIST_HEAD(voltdm_list);
>
> +#define VOLTAGE_DIR_SIZE =A0 =A0 =A0 16
> =A0static struct dentry *voltage_dir;
>
> =A0/* Init function pointers */
> -static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
> +static int vp_forceupdate_scale_voltage(struct voltagedomain *voltdm=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned long target_volt);
>
> =A0static u32 omap3_voltage_read_reg(u16 mod, u8 offset)
> @@ -77,11 +70,12 @@ static void omap4_voltage_write_reg(u32 val, u16 =
mod, u8 offset)
> =A0 =A0 =A0 =A0omap4_prminst_write_inst_reg(val, OMAP4430_PRM_PARTITI=
ON, mod, offset);
> =A0}
>
> -static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
> +static int __init _config_common_vdd_data(struct voltagedomain *volt=
dm)
> =A0{
> =A0 =A0 =A0 =A0char *sys_ck_name;
> =A0 =A0 =A0 =A0struct clk *sys_ck;
> =A0 =A0 =A0 =A0u32 sys_clk_speed, timeout_val, waittime;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * XXX Clockfw should handle this, or this should be i=
n a
> @@ -101,7 +95,7 @@ static int __init _config_common_vdd_data(struct o=
map_vdd_info *vdd)
> =A0 =A0 =A0 =A0sys_ck =3D clk_get(NULL, sys_ck_name);
> =A0 =A0 =A0 =A0if (IS_ERR(sys_ck)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Could not get the sys =
clk to calculate"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "various vdd_%s params\=
n", __func__, vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "various vdd_%s params\=
n", __func__, voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0sys_clk_speed =3D clk_get_rate(sys_ck);
> @@ -135,7 +129,8 @@ static int __init _config_common_vdd_data(struct =
omap_vdd_info *vdd)
> =A0/* Voltage debugfs support */
> =A0static int vp_volt_debug_get(void *data, u64 *val)
> =A0{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D (struct omap_vdd_info *) =
data;
> + =A0 =A0 =A0 struct voltagedomain *voltdm =3D (struct voltagedomain =
*)data;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u8 vsel;
>
> =A0 =A0 =A0 =A0if (!vdd) {
> @@ -157,14 +152,14 @@ static int vp_volt_debug_get(void *data, u64 *v=
al)
>
> =A0static int nom_volt_debug_get(void *data, u64 *val)
> =A0{
> - =A0 =A0 =A0 struct omap_vdd_info *vdd =3D (struct omap_vdd_info *) =
data;
> + =A0 =A0 =A0 struct voltagedomain *voltdm =3D (struct voltagedomain =
*)data;
>
> - =A0 =A0 =A0 if (!vdd) {
> + =A0 =A0 =A0 if (!voltdm) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("Wrong paramater passed\n")=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 *val =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> + =A0 =A0 =A0 *val =3D omap_voltage_get_nom_volt(voltdm);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -172,16 +167,17 @@ static int nom_volt_debug_get(void *data, u64 *=
val)
> =A0DEFINE_SIMPLE_ATTRIBUTE(vp_volt_debug_fops, vp_volt_debug_get, NUL=
L, "%llu\n");
> =A0DEFINE_SIMPLE_ATTRIBUTE(nom_volt_debug_fops, nom_volt_debug_get, N=
ULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%llu\n");
> -static void vp_latch_vsel(struct omap_vdd_info *vdd)
> +static void vp_latch_vsel(struct voltagedomain *voltdm)
> =A0{
> =A0 =A0 =A0 =A0u32 vpconfig;
> =A0 =A0 =A0 =A0unsigned long uvdc;
> =A0 =A0 =A0 =A0char vsel;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
>
> - =A0 =A0 =A0 uvdc =3D omap_voltage_get_nom_volt(&vdd->voltdm);
> + =A0 =A0 =A0 uvdc =3D omap_voltage_get_nom_volt(voltdm);
> =A0 =A0 =A0 =A0if (!uvdc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: unable to find current=
 voltage for vdd_%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -209,13 +205,14 @@ static void vp_latch_vsel(struct omap_vdd_info =
*vdd)
> =A0}
>
> =A0/* Generic voltage init functions */
> -static void __init vp_init(struct omap_vdd_info *vdd)
> +static void __init vp_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u32 vp_val;
>
> =A0 =A0 =A0 =A0if (!vdd->read_reg || !vdd->write_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read/write API for acce=
ssing vdd_%s regs\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -246,25 +243,26 @@ static void __init vp_init(struct omap_vdd_info=
 *vdd)
> =A0 =A0 =A0 =A0vdd->write_reg(vp_val, vdd->vp_data->vp_common->prm_mo=
d, vdd->vp_data->vlimitto);
> =A0}
>
> -static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
> +static void __init vdd_debugfs_init(struct voltagedomain *voltdm)
> =A0{
> =A0 =A0 =A0 =A0char *name;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0name =3D kzalloc(VOLTAGE_DIR_SIZE, GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Unable to allocate mem=
ory for debugfs"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" directory name for v=
dd_%s",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0strcpy(name, "vdd_");
> - =A0 =A0 =A0 strcat(name, vdd->voltdm.name);
> + =A0 =A0 =A0 strcat(name, voltdm->name);
>
> =A0 =A0 =A0 =A0vdd->debug_dir =3D debugfs_create_dir(name, voltage_di=
r);
> =A0 =A0 =A0 =A0kfree(name);
> =A0 =A0 =A0 =A0if (IS_ERR(vdd->debug_dir)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: Unable to create debug=
fs directory for"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " vdd_%s\n", __func__, =
vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " vdd_%s\n", __func__, =
voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vdd->debug_dir =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -288,16 +286,17 @@ static void __init vdd_debugfs_init(struct omap=
_vdd_info *vdd)
> =A0 =A0 =A0 =A0(void) debugfs_create_x16("vp_timeout", S_IRUGO, vdd->=
debug_dir,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&(vdd-=
>vp_rt_data.vlimitto_timeout));
> =A0 =A0 =A0 =A0(void) debugfs_create_file("curr_vp_volt", S_IRUGO, vd=
d->debug_dir,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *=
) vdd, &vp_volt_debug_fops);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *=
) voltdm, &vp_volt_debug_fops);
> =A0 =A0 =A0 =A0(void) debugfs_create_file("curr_nominal_volt", S_IRUG=
O,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->de=
bug_dir, (void *) vdd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd->de=
bug_dir, (void *) voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&nom_v=
olt_debug_fops);
> =A0}
>
> =A0/* Voltage scale and accessory APIs */
> -static int _pre_volt_scale(struct omap_vdd_info *vdd,
> +static int _pre_volt_scale(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 *target_=
vsel, u8 *current_vsel)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0struct omap_volt_data *volt_data;
> =A0 =A0 =A0 =A0const struct omap_vc_common_data *vc_common;
> =A0 =A0 =A0 =A0const struct omap_vp_common_data *vp_common;
> @@ -309,25 +308,25 @@ static int _pre_volt_scale(struct omap_vdd_info=
 *vdd,
> =A0 =A0 =A0 =A0/* Check if suffiecient pmic info is available for thi=
s vdd */
> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Insufficient pmic info to =
scale the vdd_%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!vdd->pmic_info->uv_to_vsel) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC function to convert v=
oltage in uV to"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"vsel not registered. =
Hence unable to scale voltage"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for vdd_%s\n", __func_=
_, vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for vdd_%s\n", __func_=
_, voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODATA;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!vdd->read_reg || !vdd->write_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read/write API for acce=
ssing vdd_%s regs\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Get volt_data corresponding to target_volt */
> - =A0 =A0 =A0 volt_data =3D omap_voltage_get_voltdata(&vdd->voltdm, t=
arget_volt);
> + =A0 =A0 =A0 volt_data =3D omap_voltage_get_voltdata(voltdm, target_=
volt);
> =A0 =A0 =A0 =A0if (IS_ERR(volt_data))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0volt_data =3D NULL;
>
> @@ -355,9 +354,10 @@ static int _pre_volt_scale(struct omap_vdd_info =
*vdd,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void _post_volt_scale(struct omap_vdd_info *vdd,
> +static void _post_volt_scale(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt, u8 target_v=
sel, u8 current_vsel)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u32 smps_steps =3D 0, smps_delay =3D 0;
>
> =A0 =A0 =A0 =A0smps_steps =3D abs(target_vsel - current_vsel);
> @@ -370,15 +370,16 @@ static void _post_volt_scale(struct omap_vdd_in=
fo *vdd,
> =A0}
>
> =A0/* vc_bypass_scale_voltage - VC bypass method of voltage scaling *=
/
> -static int vc_bypass_scale_voltage(struct omap_vdd_info *vdd,
> +static int vc_bypass_scale_voltage(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u32 loop_cnt =3D 0, retries_cnt =3D 0;
> =A0 =A0 =A0 =A0u32 vc_valid, vc_bypass_val_reg, vc_bypass_value;
> =A0 =A0 =A0 =A0u8 target_vsel, current_vsel;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 ret =3D _pre_volt_scale(vdd, target_volt, &target_vsel,=
 &current_vsel);
> + =A0 =A0 =A0 ret =3D _pre_volt_scale(voltdm, target_volt, &target_vs=
el, &current_vsel);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> @@ -417,19 +418,20 @@ static int vc_bypass_scale_voltage(struct omap_=
vdd_info *vdd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0vc_bypass_val_reg);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 _post_volt_scale(vdd, target_volt, target_vsel, current=
_vsel);
> + =A0 =A0 =A0 _post_volt_scale(voltdm, target_volt, target_vsel, curr=
ent_vsel);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0/* VP force update method of voltage scaling */
> -static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
> +static int vp_forceupdate_scale_voltage(struct voltagedomain *voltdm=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u32 vpconfig;
> =A0 =A0 =A0 =A0u8 target_vsel, current_vsel;
> =A0 =A0 =A0 =A0int ret, timeout =3D 0;
>
> - =A0 =A0 =A0 ret =3D _pre_volt_scale(vdd, target_volt, &target_vsel,=
 &current_vsel);
> + =A0 =A0 =A0 ret =3D _pre_volt_scale(voltdm, target_volt, &target_vs=
el, &current_vsel);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> @@ -447,7 +449,7 @@ static int vp_forceupdate_scale_voltage(struct om=
ap_vdd_info *vdd,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (timeout >=3D VP_TRANXDONE_TIMEOUT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s TRANXDONE timeo=
ut exceeded."
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Voltage change aborted=
", __func__, vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Voltage change aborted=
", __func__, voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ETIMEDOUT;
> =A0 =A0 =A0 =A0}
>
> @@ -480,9 +482,9 @@ static int vp_forceupdate_scale_voltage(struct om=
ap_vdd_info *vdd,
> =A0 =A0 =A0 =A0if (timeout >=3D VP_TRANXDONE_TIMEOUT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: vdd_%s TRANXDONE timeout e=
xceeded."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"TRANXDONE never got s=
et after the voltage update\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
>
> - =A0 =A0 =A0 _post_volt_scale(vdd, target_volt, target_vsel, current=
_vsel);
> + =A0 =A0 =A0 _post_volt_scale(voltdm, target_volt, target_vsel, curr=
ent_vsel);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Disable TransactionDone interrupt , clear all statu=
s, clear
> @@ -501,7 +503,7 @@ static int vp_forceupdate_scale_voltage(struct om=
ap_vdd_info *vdd,
> =A0 =A0 =A0 =A0if (timeout >=3D VP_TRANXDONE_TIMEOUT)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: vdd_%s TRANXDONE timeo=
ut exceeded while trying"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"to clear the TRANXDON=
E status\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
>
> =A0 =A0 =A0 =A0vpconfig =3D vdd->read_reg(vdd->vp_data->vp_common->pr=
m_mod, vdd->vp_data->vpconfig);
> =A0 =A0 =A0 =A0/* Clear initVDD copy trigger bit */
> @@ -514,8 +516,10 @@ static int vp_forceupdate_scale_voltage(struct o=
map_vdd_info *vdd,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void __init omap3_vfsm_init(struct omap_vdd_info *vdd)
> +static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Voltage Manager FSM parameters init
> =A0 =A0 =A0 =A0 * XXX This data should be passed in from the board fi=
le
> @@ -527,8 +531,9 @@ static void __init omap3_vfsm_init(struct omap_vd=
d_info *vdd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP3_PRM_VOLTSETUP2_OFFS=
ET);
> =A0}
>
> -static void __init omap3_vc_init(struct omap_vdd_info *vdd)
> +static void __init omap3_vc_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0static bool is_initialized;
> =A0 =A0 =A0 =A0u8 on_vsel, onlp_vsel, ret_vsel, off_vsel;
> =A0 =A0 =A0 =A0u32 vc_val;
> @@ -556,15 +561,16 @@ static void __init omap3_vc_init(struct omap_vd=
d_info *vdd)
> =A0 =A0 =A0 =A0vdd->write_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN_MA=
SK, vdd->vc_data->vc_common->prm_mod,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3_PRM_VC_I2C_CFG_O=
=46FSET);
>
> - =A0 =A0 =A0 omap3_vfsm_init(vdd);
> + =A0 =A0 =A0 omap3_vfsm_init(voltdm);
>
> =A0 =A0 =A0 =A0is_initialized =3D true;
> =A0}
>
>
> =A0/* OMAP4 specific voltage init functions */
> -static void __init omap4_vc_init(struct omap_vdd_info *vdd)
> +static void __init omap4_vc_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0static bool is_initialized;
> =A0 =A0 =A0 =A0u32 vc_val;
>
> @@ -589,20 +595,21 @@ static void __init omap4_vc_init(struct omap_vd=
d_info *vdd)
> =A0 =A0 =A0 =A0is_initialized =3D true;
> =A0}
>
> -static void __init omap_vc_init(struct omap_vdd_info *vdd)
> +static void __init omap_vc_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0u32 vc_val;
>
> =A0 =A0 =A0 =A0if (!vdd->pmic_info || !vdd->pmic_info->uv_to_vsel) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to conf=
igure vc for"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"vdd_%s not populated.=
Hence cannot initialize vc\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!vdd->read_reg || !vdd->write_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read/write API for acce=
ssing vdd_%s regs\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -630,23 +637,24 @@ static void __init omap_vc_init(struct omap_vdd=
_info *vdd)
> =A0 =A0 =A0 =A0vdd->write_reg(vc_val, vdd->vc_data->vc_common->prm_mo=
d, vdd->vfsm->voltsetup_reg);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_vc_init(vdd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_vc_init(voltdm);
> =A0 =A0 =A0 =A0else if (cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vc_init(vdd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_vc_init(voltdm);
> =A0}
>
> -static int __init omap_vdd_data_configure(struct omap_vdd_info *vdd)
> +static int __init omap_vdd_data_configure(struct voltagedomain *volt=
dm)
> =A0{
> + =A0 =A0 =A0 struct omap_vdd_info *vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0int ret =3D -EINVAL;
>
> =A0 =A0 =A0 =A0if (!vdd->pmic_info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: PMIC info requried to conf=
igure vdd_%s not"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"populated.Hence canno=
t initialize vdd_%s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, vdd->voltdm.n=
ame, vdd->voltdm.name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name,=
 voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto ovdc_out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (IS_ERR_VALUE(_config_common_vdd_data(vdd)))
> + =A0 =A0 =A0 if (IS_ERR_VALUE(_config_common_vdd_data(voltdm)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto ovdc_out;
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx()) {
> @@ -680,7 +688,7 @@ unsigned long omap_voltage_get_nom_volt(struct vo=
ltagedomain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0return vdd->curr_volt;
> =A0}
> @@ -701,7 +709,7 @@ unsigned long omap_vp_get_curr_volt(struct voltag=
edomain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0if (!vdd->read_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read API for reading vd=
d_%s regs\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->name=
);
> @@ -736,7 +744,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0if (!vdd->read_reg || !vdd->write_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read/write API for acce=
ssing vdd_%s regs\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->name=
);
> @@ -747,7 +755,7 @@ void omap_vp_enable(struct voltagedomain *voltdm)
> =A0 =A0 =A0 =A0if (vdd->vp_enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 vp_latch_vsel(vdd);
> + =A0 =A0 =A0 vp_latch_vsel(voltdm);
>
> =A0 =A0 =A0 =A0/* Enable VP */
> =A0 =A0 =A0 =A0vpconfig =3D vdd->read_reg(vdd->vp_data->vp_common->pr=
m_mod, vdd->vp_data->vpconfig);
> @@ -774,7 +782,7 @@ void omap_vp_disable(struct voltagedomain *voltdm=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
> =A0 =A0 =A0 =A0if (!vdd->read_reg || !vdd->write_reg) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No read/write API for acce=
ssing vdd_%s regs\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, voltdm->name=
);
> @@ -827,7 +835,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *=
voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0if (!vdd->volt_scale) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: No voltage scale API regis=
tered for vdd_%s\n",
> @@ -835,7 +843,7 @@ int omap_voltage_scale_vdd(struct voltagedomain *=
voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODATA;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return vdd->volt_scale(vdd, target_volt);
> + =A0 =A0 =A0 return vdd->volt_scale(voltdm, target_volt);
> =A0}
>
> =A0/**
> @@ -888,7 +896,7 @@ void omap_voltage_get_volttable(struct voltagedom=
ain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0*volt_data =3D vdd->volt_data;
> =A0}
> @@ -919,7 +927,7 @@ struct omap_volt_data *omap_voltage_get_voltdata(=
struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0if (!vdd->volt_data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: voltage table does not=
 exist for vdd_%s\n",
> @@ -957,7 +965,7 @@ int omap_voltage_register_pmic(struct voltagedoma=
in *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0vdd->pmic_info =3D pmic_info;
>
> @@ -984,7 +992,7 @@ struct dentry *omap_voltage_get_dbgdir(struct vol=
tagedomain *voltdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0return vdd->debug_dir;
> =A0}
> @@ -1009,7 +1017,7 @@ void omap_change_voltscale_method(struct voltag=
edomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 vdd =3D container_of(voltdm, struct omap_vdd_info, volt=
dm);
> + =A0 =A0 =A0 vdd =3D voltdm->vdd;
>
> =A0 =A0 =A0 =A0switch (voltscale_method) {
> =A0 =A0 =A0 =A0case VOLTSCALE_VPFORCEUPDATE:
> @@ -1025,38 +1033,6 @@ void omap_change_voltscale_method(struct volta=
gedomain *voltdm,
> =A0}
>
> =A0/**
> - * omap_voltage_domain_lookup() - API to get the voltage domain poin=
ter
> - * @name: =A0 =A0 =A0Name of the voltage domain
> - *
> - * This API looks up in the global vdd_info struct for the
> - * existence of voltage domain <name>. If it exists, the API returns
> - * a pointer to the voltage domain structure corresponding to the
> - * VDD<name>. Else retuns error pointer.
> - */
> -struct voltagedomain *omap_voltage_domain_lookup(char *name)
> -{
> - =A0 =A0 =A0 int i;
> -
> - =A0 =A0 =A0 if (!vdd_info) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Voltage driver init not yet=
 happened.Faulting!\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (!name) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No name to get the votage d=
omain!\n", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 for (i =3D 0; i < nr_scalable_vdd; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(strcmp(name, vdd_info[i]->voltdm.=
name)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &vdd_info[i]->vo=
ltdm;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> -}
> -
> -/**
> =A0* omap_voltage_late_init() - Init the various voltage parameters
> =A0*
> =A0* This API is to be called in the later stages of the
> @@ -1065,9 +1041,9 @@ struct voltagedomain *omap_voltage_domain_looku=
p(char *name)
> =A0*/
> =A0int __init omap_voltage_late_init(void)
> =A0{
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct voltagedomain *voltdm;
>
> - =A0 =A0 =A0 if (!vdd_info) {
> + =A0 =A0 =A0 if (list_empty(&voltdm_list)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Voltage driver support not=
 added\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1077,22 +1053,81 @@ int __init omap_voltage_late_init(void)
> =A0 =A0 =A0 =A0if (IS_ERR(voltage_dir))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Unable to create voltage d=
ebugfs main dir\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> - =A0 =A0 =A0 for (i =3D 0; i < nr_scalable_vdd; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vdd_data_configure(vdd_info[i]=
))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vc_init(vdd_info[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init(vdd_info[i]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_debugfs_init(vdd_info[i]);
> + =A0 =A0 =A0 list_for_each_entry(voltdm, &voltdm_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (voltdm->vdd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vdd_data_confi=
gure(voltdm))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vc_init(voltdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vp_init(voltdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd_debugfs_init(voltdm=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/* XXX document */
> -int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_ar=
ray[],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u8 omap_vdd_count)
> +static struct voltagedomain *_voltdm_lookup(const char *name)
> =A0{
> - =A0 =A0 =A0 vdd_info =3D omap_vdd_array;
> - =A0 =A0 =A0 nr_scalable_vdd =3D omap_vdd_count;
> + =A0 =A0 =A0 struct voltagedomain *voltdm, *temp_voltdm;
> +
> + =A0 =A0 =A0 voltdm =3D NULL;
> +
> + =A0 =A0 =A0 list_for_each_entry(temp_voltdm, &voltdm_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(name, temp_voltdm->name)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm =3D temp_voltdm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return voltdm;
> +}
> +
> +static int _voltdm_register(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 if (!voltdm || !voltdm->name)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 list_add(&voltdm->node, &voltdm_list);
> +
> + =A0 =A0 =A0 pr_debug("voltagedomain: registered %s\n", voltdm->name=
);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +/**
> + * voltdm_lookup - look up a voltagedomain by name, return a pointer
> + * @name: name of voltagedomain
> + *
> + * Find a registered voltagedomain by its name @name. =A0Returns a p=
ointer
> + * to the struct voltagedomain if found, or NULL otherwise.
> + */
> +struct voltagedomain *voltdm_lookup(const char *name)
> +{
> + =A0 =A0 =A0 struct voltagedomain *voltdm ;
> +
> + =A0 =A0 =A0 if (!name)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 voltdm =3D _voltdm_lookup(name);
> +
> + =A0 =A0 =A0 return voltdm;
> +}
> +
> +/**
> + * voltdm_init - set up the voltagedomain layer
> + * @voltdm_list: array of struct voltagedomain pointers to register
> + *
> + * Loop through the array of voltagedomains @voltdm_list, registerin=
g all
> + * that are available on the current CPU. If voltdm_list is supplied
> + * and not null, all of the referenced voltagedomains will be
> + * registered. =A0No return value.
> + */
> +void voltdm_init(struct voltagedomain **voltdms)
> +{
> + =A0 =A0 =A0 struct voltagedomain **v;
> +
> + =A0 =A0 =A0 if (voltdms) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (v =3D voltdms; *v; v++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _voltdm_register(*v);
> + =A0 =A0 =A0 }
> +}
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index db23d49..5440298 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -31,6 +31,8 @@
> =A0#define OMAP3_VOLTOFFSET =A0 =A0 =A0 0xff
> =A0#define OMAP3_VOLTSETUP2 =A0 =A0 =A0 0xff
>
> +struct omap_vdd_info;
> +
> =A0/**
> =A0* struct omap_vfsm_instance_data - per-voltage manager FSM registe=
r/bitfield
> =A0* data
> @@ -50,11 +52,14 @@ struct omap_vfsm_instance_data {
>
> =A0/**
> =A0* struct voltagedomain - omap voltage domain global structure.
> - * @name: =A0 =A0 =A0Name of the voltage domain which can be used as=
 a unique
> - * =A0 =A0 =A0 =A0 =A0 =A0 identifier.
> + * @name: Name of the voltage domain which can be used as a unique i=
dentifier.
> + * @node: list_head linking all voltage domains
> + * @vdd: to be removed
> =A0*/
> =A0struct voltagedomain {
> =A0 =A0 =A0 =A0char *name;
> + =A0 =A0 =A0 struct list_head node;
> + =A0 =A0 =A0 struct omap_vdd_info *vdd;
> =A0};
>
> =A0/**
> @@ -116,7 +121,6 @@ struct omap_volt_pmic_info {
> =A0* @vc_data =A0 =A0 =A0 =A0 =A0 =A0: structure containing various v=
arious vc registers,
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shifts, masks etc.
> =A0* @vfsm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: voltage manager FSM data
> - * @voltdm =A0 =A0 =A0 =A0 =A0 =A0 : pointer to the voltage domain s=
tructure
> =A0* @debug_dir =A0 =A0 =A0 =A0 =A0: debug directory for this voltage=
 domain.
> =A0* @curr_volt =A0 =A0 =A0 =A0 =A0: current voltage for this vdd.
> =A0* @prm_irqst_mod =A0 =A0 =A0 : PRM module id used for PRM IRQ stat=
us register access
> @@ -130,7 +134,6 @@ struct omap_vdd_info {
> =A0 =A0 =A0 =A0struct omap_vp_runtime_data vp_rt_data;
> =A0 =A0 =A0 =A0struct omap_vc_instance_data *vc_data;
> =A0 =A0 =A0 =A0const struct omap_vfsm_instance_data *vfsm;
> - =A0 =A0 =A0 struct voltagedomain voltdm;
> =A0 =A0 =A0 =A0struct dentry *debug_dir;
> =A0 =A0 =A0 =A0u32 curr_volt;
> =A0 =A0 =A0 =A0bool vp_enabled;
> @@ -139,7 +142,7 @@ struct omap_vdd_info {
> =A0 =A0 =A0 =A0u8 prm_irqst_reg;
> =A0 =A0 =A0 =A0u32 (*read_reg) (u16 mod, u8 offset);
> =A0 =A0 =A0 =A0void (*write_reg) (u32 val, u16 mod, u8 offset);
> - =A0 =A0 =A0 int (*volt_scale) (struct omap_vdd_info *vdd,
> + =A0 =A0 =A0 int (*volt_scale) (struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long target_volt);
> =A0};
>
> @@ -155,16 +158,11 @@ struct omap_volt_data *omap_voltage_get_voltdat=
a(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long volt);
> =A0unsigned long omap_voltage_get_nom_volt(struct voltagedomain *volt=
dm);
> =A0struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltd=
m);
> -int __init omap_voltage_early_init(struct omap_vdd_info *omap_vdd_ar=
ray[],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u8 omap_vdd_count);
> =A0#ifdef CONFIG_PM
> =A0int omap_voltage_register_pmic(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_pmic_info *pmic_info)=
;
> =A0void omap_change_voltscale_method(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int voltscale_method);
> -/* API to get the voltagedomain pointer */
> -struct voltagedomain *omap_voltage_domain_lookup(char *name);
> -
> =A0int omap_voltage_late_init(void);
> =A0#else
> =A0static inline int omap_voltage_register_pmic(struct voltagedomain =
*voltdm,
> @@ -178,10 +176,11 @@ static inline int omap_voltage_late_init(void)
> =A0{
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
> -static inline struct voltagedomain *omap_voltage_domain_lookup(char =
*name)
> -{
> - =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> -}
> =A0#endif
>
> +extern void omap3xxx_voltagedomains_init(void);
> +extern void omap44xx_voltagedomains_init(void);
> +
> +struct voltagedomain *voltdm_lookup(const char *name);
> +void voltdm_init(struct voltagedomain **voltdm_list);
> =A0#endif
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm=
/mach-omap2/voltagedomains3xxx_data.c
> index f831f9a..4bee412 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -43,9 +43,6 @@ static struct omap_vdd_info omap3_vdd1_info =3D {
> =A0 =A0 =A0 =A0.vp_data =3D &omap3_vp1_data,
> =A0 =A0 =A0 =A0.vc_data =3D &omap3_vc1_data,
> =A0 =A0 =A0 =A0.vfsm =3D &omap3_vdd1_vfsm_data,
> - =A0 =A0 =A0 .voltdm =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mpu",
> - =A0 =A0 =A0 },
> =A0};
>
> =A0static const struct omap_vfsm_instance_data omap3_vdd2_vfsm_data =3D=
 {
> @@ -60,23 +57,26 @@ static struct omap_vdd_info omap3_vdd2_info =3D {
> =A0 =A0 =A0 =A0.vp_data =3D &omap3_vp2_data,
> =A0 =A0 =A0 =A0.vc_data =3D &omap3_vc2_data,
> =A0 =A0 =A0 =A0.vfsm =3D &omap3_vdd2_vfsm_data,
> - =A0 =A0 =A0 .voltdm =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "core",
> - =A0 =A0 =A0 },
> =A0};
>
> -/* OMAP3 VDD structures */
> -static struct omap_vdd_info *omap3_vdd_info[] =3D {
> - =A0 =A0 =A0 &omap3_vdd1_info,
> - =A0 =A0 =A0 &omap3_vdd2_info,
> +static struct voltagedomain omap3_voltdm_mpu =3D {
> + =A0 =A0 =A0 .name =3D "mpu",
> + =A0 =A0 =A0 .vdd =3D &omap3_vdd1_info,
> =A0};
>
> -/* OMAP3 specific voltage init functions */
> -static int __init omap3xxx_voltage_early_init(void)
> -{
> - =A0 =A0 =A0 if (!cpu_is_omap34xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +static struct voltagedomain omap3_voltdm_core =3D {
> + =A0 =A0 =A0 .name =3D "core",
> + =A0 =A0 =A0 .vdd =3D &omap3_vdd2_info,
> +};
>
> +static struct voltagedomain *voltagedomains_omap3[] __initdata =3D {
> + =A0 =A0 =A0 &omap3_voltdm_mpu,
> + =A0 =A0 =A0 &omap3_voltdm_core,
> + =A0 =A0 =A0 NULL,
> +};
> +
> +void __init omap3xxx_voltagedomains_init(void)
> +{
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * XXX Will depend on the process, validation, and bin=
ning
> =A0 =A0 =A0 =A0 * for the currently-running IC
> @@ -89,7 +89,5 @@ static int __init omap3xxx_voltage_early_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_vdd2_info.volt_data =3D omap34xx=
_vddcore_volt_data;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return omap_voltage_early_init(omap3_vdd_info,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ARRAY_SIZE(omap3_vdd_info));
> + =A0 =A0 =A0 voltdm_init(voltagedomains_omap3);
> =A0};
> -core_initcall(omap3xxx_voltage_early_init);
> diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm=
/mach-omap2/voltagedomains44xx_data.c
> index 85da60c..068a5e7 100644
> --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> @@ -42,9 +42,6 @@ static struct omap_vdd_info omap4_vdd_mpu_info =3D =
{
> =A0 =A0 =A0 =A0.vp_data =3D &omap4_vp_mpu_data,
> =A0 =A0 =A0 =A0.vc_data =3D &omap4_vc_mpu_data,
> =A0 =A0 =A0 =A0.vfsm =3D &omap4_vdd_mpu_vfsm_data,
> - =A0 =A0 =A0 .voltdm =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mpu",
> - =A0 =A0 =A0 },
> =A0};
>
> =A0static const struct omap_vfsm_instance_data omap4_vdd_iva_vfsm_dat=
a =3D {
> @@ -57,9 +54,6 @@ static struct omap_vdd_info omap4_vdd_iva_info =3D =
{
> =A0 =A0 =A0 =A0.vp_data =3D &omap4_vp_iva_data,
> =A0 =A0 =A0 =A0.vc_data =3D &omap4_vc_iva_data,
> =A0 =A0 =A0 =A0.vfsm =3D &omap4_vdd_iva_vfsm_data,
> - =A0 =A0 =A0 .voltdm =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "iva",
> - =A0 =A0 =A0 },
> =A0};
>
> =A0static const struct omap_vfsm_instance_data omap4_vdd_core_vfsm_da=
ta =3D {
> @@ -72,24 +66,32 @@ static struct omap_vdd_info omap4_vdd_core_info =3D=
 {
> =A0 =A0 =A0 =A0.vp_data =3D &omap4_vp_core_data,
> =A0 =A0 =A0 =A0.vc_data =3D &omap4_vc_core_data,
> =A0 =A0 =A0 =A0.vfsm =3D &omap4_vdd_core_vfsm_data,
> - =A0 =A0 =A0 .voltdm =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "core",
> - =A0 =A0 =A0 },
> =A0};
>
> -/* OMAP4 VDD structures */
> -static struct omap_vdd_info *omap4_vdd_info[] =3D {
> - =A0 =A0 =A0 &omap4_vdd_mpu_info,
> - =A0 =A0 =A0 &omap4_vdd_iva_info,
> - =A0 =A0 =A0 &omap4_vdd_core_info,
> +static struct voltagedomain omap4_voltdm_mpu =3D {
> + =A0 =A0 =A0 .name =3D "mpu",
> + =A0 =A0 =A0 .vdd =3D &omap4_vdd_mpu_info,
> =A0};
>
> -/* OMAP4 specific voltage init functions */
> -static int __init omap44xx_voltage_early_init(void)
> -{
> - =A0 =A0 =A0 if (!cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +static struct voltagedomain omap4_voltdm_iva =3D {
> + =A0 =A0 =A0 .name =3D "iva",
> + =A0 =A0 =A0 .vdd =3D &omap4_vdd_iva_info,
> +};
> +
> +static struct voltagedomain omap4_voltdm_core =3D {
> + =A0 =A0 =A0 .name =3D "core",
> + =A0 =A0 =A0 .vdd =3D &omap4_vdd_core_info,
> +};
>
> +static struct voltagedomain *voltagedomains_omap4[] __initdata =3D {
> + =A0 =A0 =A0 &omap4_voltdm_mpu,
> + =A0 =A0 =A0 &omap4_voltdm_iva,
> + =A0 =A0 =A0 &omap4_voltdm_core,
> + =A0 =A0 =A0 NULL,
> +};
> +
> +void __init omap44xx_voltagedomains_init(void)
> +{
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * XXX Will depend on the process, validation, and bin=
ning
> =A0 =A0 =A0 =A0 * for the currently-running IC
> @@ -98,7 +100,5 @@ static int __init omap44xx_voltage_early_init(void=
)
> =A0 =A0 =A0 =A0omap4_vdd_iva_info.volt_data =3D omap44xx_vdd_iva_volt=
_data;
> =A0 =A0 =A0 =A0omap4_vdd_core_info.volt_data =3D omap44xx_vdd_core_vo=
lt_data;
>
> - =A0 =A0 =A0 return omap_voltage_early_init(omap4_vdd_info,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ARRAY_SIZE(omap4_vdd_info));
> + =A0 =A0 =A0 voltdm_init(voltagedomains_omap4);
> =A0};
> -core_initcall(omap44xx_voltage_early_init);
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
