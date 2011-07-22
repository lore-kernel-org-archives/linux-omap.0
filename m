From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
 platform_device from omap_device
Date: Thu, 21 Jul 2011 20:20:37 -0600
Message-ID: <CACxGe6uyXS3vBOebgcgx2+7qLHB-DsMT42aBWo3mR58MqddnTg@mail.gmail.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com> <1311292338-11830-9-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60574 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab1GVCU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 22:20:58 -0400
Received: by ywe9 with SMTP id 9so974846ywe.19
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 19:20:58 -0700 (PDT)
In-Reply-To: <1311292338-11830-9-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Thu, Jul 21, 2011 at 5:52 PM, Kevin Hilman <khilman@ti.com> wrote:
> Rather than embedding a struct platform_device inside a struct
> omap_device, decouple them, leaving only a pointer to the
> platform_device inside the omap_device.
>
> This patch uses devres to allocate and attach the omap_device to the
> struct device, so finding an omap_device from a struct device means
> using devres_find(), and the to_omap_device() helper function was
> modified accordingly.
>
> RFC/Hack alert:
>
> Currently the driver core (drivers/base/dd.c) doesn't expect any
> devres resources to exist before the driver's ->probe() is called. =A0=
In
> this patch, I just comment out the warning, but we'll need to
> understand why that limitation exists, and if it's a real limitation.
> A first glance suggests that it's not really needed. =A0If this is a
> true limitation, we'll need to find some way other than devres to
> attach an omap_device to a struct device.

The devres lifetime is scoped to binding a driver; it is added at
probe time and removed at release.  For this use-case, it needs to be
scoped to the lifetime of the struct device.  To make this work,
you'll need to add a flag to devres so that the driver core can
differentiate between driver-scoped and device-scoped lifetimes (which
I do think is the right thing to do).  Without fixing this, the driver
core will remove all the devres when a driver gets unbound, or if a
=2Eprobe() hook fails, which completely breaks the driver model.

g.

>
> On OMAP, we will need an omap_device attached to a struct device
> before probe because device HW may be disabled in probe and drivers
> are expected to use runtime PM in ->probe() to activate the hardware
> before access. =A0Because the runtime PM API calls use omap_device (v=
ia
> our PM domain layer), we need omap_device attached to a
> platform_device before probe.
> ---
> =A0arch/arm/mach-omap2/opp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A04 +-
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
78 +++++++++++++++----------
> =A0drivers/base/dd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
> =A04 files changed, 50 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index ab8b35b..9262a6b 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -69,7 +69,7 @@ int __init omap_init_opp_table(struct omap_opp_def =
*opp_def,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0opp_de=
f->hwmod_name, i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D &oh->od->pdev.dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D &oh->od->pdev->dev;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r =3D opp_add(dev, opp_def->freq, opp_=
def->u_volt);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (r) {
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm=
/plat-omap/include/plat/omap_device.h
> index 7a3ec4f..6bd4f6f 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -64,7 +64,7 @@ extern struct device omap_device_parent;
> =A0*
> =A0*/
> =A0struct omap_device {
> - =A0 =A0 =A0 struct platform_device =A0 =A0 =A0 =A0 =A0pdev;
> + =A0 =A0 =A0 struct platform_device =A0 =A0 =A0 =A0 =A0*pdev;
> =A0 =A0 =A0 =A0struct omap_hwmod =A0 =A0 =A0 =A0 =A0 =A0 =A0 **hwmods=
;
> =A0 =A0 =A0 =A0struct omap_device_pm_latency =A0 *pm_lats;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_wakeup_lat;
> @@ -142,6 +142,6 @@ struct omap_device_pm_latency {
> =A0#define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
>
> =A0/* Get omap_device pointer from platform_device pointer */
> -#define to_omap_device(x) container_of((x), struct omap_device, pdev=
)
> +struct omap_device *to_omap_device(struct platform_device *pdev);
>
> =A0#endif
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index c420b94..52ce013 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -117,7 +117,7 @@ static int _omap_device_activate(struct omap_devi=
ce *od, u8 ignore_lat)
> =A0{
> =A0 =A0 =A0 =A0struct timespec a, b, c;
>
> - =A0 =A0 =A0 dev_dbg(&od->pdev.dev, "omap_device: activating\n");
> + =A0 =A0 =A0 dev_dbg(&od->pdev->dev, "omap_device: activating\n");
>
> =A0 =A0 =A0 =A0while (od->pm_lat_level > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_device_pm_latency *odpl;
> @@ -141,7 +141,7 @@ static int _omap_device_activate(struct omap_devi=
ce *od, u8 ignore_lat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D timespec_sub(b, a);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0act_lat =3D timespec_to_ns(&c);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap_device: pm_lat %=
d: activate: elapsed time "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%llu nsec\n", od->pm_=
lat_level, act_lat);
>
> @@ -149,12 +149,12 @@ static int _omap_device_activate(struct omap_de=
vice *od, u8 ignore_lat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0odpl->activate_lat_wor=
st =3D act_lat;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (odpl->flags & OMAP=
_DEVICE_LATENCY_AUTO_ADJUST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0odpl->=
activate_lat =3D act_lat;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "new worst case activate latency "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%d: %llu\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 od->pm_lat_level, act_lat);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "activate latency %d "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "higher than exptected. (%llu > %d)\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 od->pm_lat_level, act_lat,
> @@ -185,7 +185,7 @@ static int _omap_device_deactivate(struct omap_de=
vice *od, u8 ignore_lat)
> =A0{
> =A0 =A0 =A0 =A0struct timespec a, b, c;
>
> - =A0 =A0 =A0 dev_dbg(&od->pdev.dev, "omap_device: deactivating\n");
> + =A0 =A0 =A0 dev_dbg(&od->pdev->dev, "omap_device: deactivating\n");
>
> =A0 =A0 =A0 =A0while (od->pm_lat_level < od->pm_lats_cnt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_device_pm_latency *odpl;
> @@ -208,7 +208,7 @@ static int _omap_device_deactivate(struct omap_de=
vice *od, u8 ignore_lat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c =3D timespec_sub(b, a);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0deact_lat =3D timespec_to_ns(&c);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap_device: pm_lat %=
d: deactivate: elapsed time "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%llu nsec\n", od->pm_=
lat_level, deact_lat);
>
> @@ -216,12 +216,12 @@ static int _omap_device_deactivate(struct omap_=
device *od, u8 ignore_lat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0odpl->deactivate_lat_w=
orst =3D deact_lat;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (odpl->flags & OMAP=
_DEVICE_LATENCY_AUTO_ADJUST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0odpl->=
deactivate_lat =3D deact_lat;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "new worst case deactivate latency "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%d: %llu\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 od->pm_lat_level, deact_lat);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "deactivate latency %d "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "higher than exptected. (%llu > %d)\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 od->pm_lat_level, deact_lat,
> @@ -245,11 +245,11 @@ static void _add_clkdev(struct omap_device *od,=
 const char *clk_alias,
> =A0 =A0 =A0 =A0if (!clk_alias || !clk_name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 dev_dbg(&od->pdev.dev, "Creating %s -> %s\n", clk_alias=
, clk_name);
> + =A0 =A0 =A0 dev_dbg(&od->pdev->dev, "Creating %s -> %s\n", clk_alia=
s, clk_name);
>
> - =A0 =A0 =A0 r =3D clk_get_sys(dev_name(&od->pdev.dev), clk_alias);
> + =A0 =A0 =A0 r =3D clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
> =A0 =A0 =A0 =A0if (!IS_ERR(r)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "alias %s already exi=
sts\n", clk_alias);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(r);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -257,14 +257,14 @@ static void _add_clkdev(struct omap_device *od,=
 const char *clk_alias,
>
> =A0 =A0 =A0 =A0r =3D omap_clk_get_by_name(clk_name);
> =A0 =A0 =A0 =A0if (IS_ERR(r)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap_clk_get_by_name =
for %s failed\n", clk_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 l =3D clkdev_alloc(r, clk_alias, dev_name(&od->pdev.dev=
));
> + =A0 =A0 =A0 l =3D clkdev_alloc(r, clk_alias, dev_name(&od->pdev->de=
v));
> =A0 =A0 =A0 =A0if (!l) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"clkdev_alloc for %s f=
ailed\n", clk_alias);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -351,7 +351,7 @@ static int omap_device_count_resources(struct oma=
p_device *od)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c +=3D omap_hwmod_count_resources(od->=
hwmods[i]);
>
> =A0 =A0 =A0 =A0pr_debug("omap_device: %s: counted %d total resources =
across %d "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hwmods\n", od->pdev.name, c, od->hw=
mods_cnt);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hwmods\n", od->pdev->name, c, od->h=
wmods_cnt);
>
> =A0 =A0 =A0 =A0return c;
> =A0}
> @@ -388,6 +388,21 @@ static int omap_device_fill_resources(struct oma=
p_device *od,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void _od_dr_release(struct device *dev, void *res)
> +{
> + =A0 =A0 =A0 kfree(res);
> +}
> +
> +struct omap_device *to_omap_device(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 void *res;
> +
> + =A0 =A0 =A0 res =3D devres_find(&pdev->dev, _od_dr_release, NULL, N=
ULL);
> + =A0 =A0 =A0 WARN_ON(!res);
> +
> + =A0 =A0 =A0 return (struct omap_device *)res;
> +}
> +
> =A0/**
> =A0* omap_device_build - build and register an omap_device with one o=
map_hwmod
> =A0* @pdev_name: name of the platform_device driver to use
> @@ -445,8 +460,8 @@ struct platform_device *omap_device_build_ss(cons=
t char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int pm_lats_cnt, int is_early_device)
> =A0{
> =A0 =A0 =A0 =A0int ret =3D -ENOMEM;
> + =A0 =A0 =A0 struct platform_device *pdev;
> =A0 =A0 =A0 =A0struct omap_device *od;
> - =A0 =A0 =A0 char *pdev_name2;
> =A0 =A0 =A0 =A0struct resource *res =3D NULL;
> =A0 =A0 =A0 =A0int i, res_count;
> =A0 =A0 =A0 =A0struct omap_hwmod **hwmods;
> @@ -460,7 +475,8 @@ struct platform_device *omap_device_build_ss(cons=
t char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0pr_debug("omap_device: %s: building with %d hwmods\n",=
 pdev_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_cnt);
>
> - =A0 =A0 =A0 od =3D kzalloc(sizeof(struct omap_device), GFP_KERNEL);
> + =A0 =A0 =A0 od =3D devres_alloc(_od_dr_release, sizeof(struct omap_=
device),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!od)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOMEM);
>
> @@ -474,13 +490,9 @@ struct platform_device *omap_device_build_ss(con=
st char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_c=
nt);
> =A0 =A0 =A0 =A0od->hwmods =3D hwmods;
>
> - =A0 =A0 =A0 pdev_name2 =3D kzalloc(strlen(pdev_name) + 1, GFP_KERNE=
L);
> - =A0 =A0 =A0 if (!pdev_name2)
> + =A0 =A0 =A0 pdev =3D platform_device_alloc(pdev_name, pdev_id);
> + =A0 =A0 =A0 if (!pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto odbs_exit2;
> - =A0 =A0 =A0 strcpy(pdev_name2, pdev_name);
> -
> - =A0 =A0 =A0 od->pdev.name =3D pdev_name2;
> - =A0 =A0 =A0 od->pdev.id =3D pdev_id;
>
> =A0 =A0 =A0 =A0res_count =3D omap_device_count_resources(od);
> =A0 =A0 =A0 =A0if (res_count > 0) {
> @@ -490,35 +502,37 @@ struct platform_device *omap_device_build_ss(co=
nst char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0omap_device_fill_resources(od, res);
>
> - =A0 =A0 =A0 od->pdev.num_resources =3D res_count;
> - =A0 =A0 =A0 od->pdev.resource =3D res;
> + =A0 =A0 =A0 pdev->num_resources =3D res_count;
> + =A0 =A0 =A0 pdev->resource =3D res;
>
> - =A0 =A0 =A0 ret =3D platform_device_add_data(&od->pdev, pdata, pdat=
a_len);
> + =A0 =A0 =A0 ret =3D platform_device_add_data(pdev, pdata, pdata_len=
);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto odbs_exit4;
>
> =A0 =A0 =A0 =A0od->pm_lats =3D pm_lats;
> =A0 =A0 =A0 =A0od->pm_lats_cnt =3D pm_lats_cnt;
>
> - =A0 =A0 =A0 if (is_early_device)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_early_device_register(&od-=
>pdev);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_register(&od->pdev)=
;
> + =A0 =A0 =A0 od->pdev =3D pdev;
> + =A0 =A0 =A0 devres_add(&pdev->dev, od);
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < oh_cnt; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hwmods[i]->od =3D od;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_add_hwmod_clocks_clkdev(od, hwmods[i]=
);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (is_early_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_early_device_register(pdev=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_register(pdev);
> +
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto odbs_exit4;
>
> - =A0 =A0 =A0 return &od->pdev;
> + =A0 =A0 =A0 return pdev;
>
> =A0odbs_exit4:
> =A0 =A0 =A0 =A0kfree(res);
> =A0odbs_exit3:
> - =A0 =A0 =A0 kfree(pdev_name2);
> =A0odbs_exit2:
> =A0 =A0 =A0 =A0kfree(hwmods);
> =A0odbs_exit1:
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 6658da7..9289dac 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -112,7 +112,7 @@ static int really_probe(struct device *dev, struc=
t device_driver *drv)
> =A0 =A0 =A0 =A0atomic_inc(&probe_count);
> =A0 =A0 =A0 =A0pr_debug("bus: '%s': %s: probing driver %s with device=
 %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->bus->name, __func__, drv->name, =
dev_name(dev));
> - =A0 =A0 =A0 WARN_ON(!list_empty(&dev->devres_head));
> + =A0 =A0 =A0 /* WARN_ON(!list_empty(&dev->devres_head)); */
>
> =A0 =A0 =A0 =A0dev->driver =3D drv;
> =A0 =A0 =A0 =A0if (driver_sysfs_add(dev)) {
> --
> 1.7.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
