From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 9/9] OMAP: omap_device: decouple platform_device from omap_device
Date: Sat, 6 Aug 2011 09:33:58 +0100
Message-ID: <CACxGe6sZMu9FxmVOLWYHb9gd67Ffyqa2=j0kr4MJPpTyFy0oWQ@mail.gmail.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com> <1312589965-19416-10-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52606 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1HFIeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Aug 2011 04:34:21 -0400
Received: by eyx24 with SMTP id 24so1716327eyx.19
        for <linux-omap@vger.kernel.org>; Sat, 06 Aug 2011 01:34:20 -0700 (PDT)
In-Reply-To: <1312589965-19416-10-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Yes, I think this is the right thing to do.  It will certainly make it
possible to keep omap-specific hooks out of the device tree
of_platform_populate() path by using a notifier to attach hwmod data
instead.

Lightly-glanced-at-by: Grant Likely <grant.likely@secretlab.ca>

g.

On Sat, Aug 6, 2011 at 1:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Rather than embedding a struct platform_device inside a struct
> omap_device, decouple them, leaving only a pointer to the
> platform_device inside the omap_device.
>
> Use the arch-specific data field of the platform_device (pdev_archdat=
a)
> to add an omap_device pointer after the platform_device has been crea=
ted.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/opp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A02 +-
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A07 +-
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
00 +++++++++++++------------
> =A03 files changed, 58 insertions(+), 51 deletions(-)
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
> index 4f98770..d4d9b96 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -68,7 +68,7 @@ extern struct device omap_device_parent;
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
> @@ -146,7 +146,10 @@ struct omap_device_pm_latency {
> =A0#define OMAP_DEVICE_LATENCY_AUTO_ADJUST BIT(1)
>
> =A0/* Get omap_device pointer from platform_device pointer */
> -#define to_omap_device(x) container_of((x), struct omap_device, pdev=
)
> +static inline struct omap_device *to_omap_device(struct platform_dev=
ice *pdev)
> +{
> + =A0 =A0 =A0 return pdev ? pdev->archdata.od : NULL;
> +}
>
> =A0static inline
> =A0void omap_device_disable_idle_on_suspend(struct platform_device *p=
dev)
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index 351df31..d8f2299 100644
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"new worst case activate latency "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"%d: %llu\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0od->pm_lat_level, act_lat);
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
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg=
(&od->pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"new worst case deactivate latency "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"%d: %llu\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0od->pm_lat_level, deact_lat);
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
> @@ -445,8 +445,8 @@ struct platform_device *omap_device_build_ss(cons=
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
> @@ -457,72 +457,76 @@ struct platform_device *omap_device_build_ss(co=
nst char *pdev_name, int pdev_id,
> =A0 =A0 =A0 =A0if (!pdata && pdata_len > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-EINVAL);
>
> + =A0 =A0 =A0 pdev =3D platform_device_alloc(pdev_name, pdev_id);
> + =A0 =A0 =A0 if (!pdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0pr_debug("omap_device: %s: building with %d hwmods\n",=
 pdev_name,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh_cnt);
>
> =A0 =A0 =A0 =A0od =3D kzalloc(sizeof(struct omap_device), GFP_KERNEL)=
;
> - =A0 =A0 =A0 if (!od)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> -
> + =A0 =A0 =A0 if (!od) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit1;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0od->hwmods_cnt =3D oh_cnt;
>
> =A0 =A0 =A0 =A0hwmods =3D kzalloc(sizeof(struct omap_hwmod *) * oh_cn=
t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!hwmods)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit2;
>
> =A0 =A0 =A0 =A0memcpy(hwmods, ohs, sizeof(struct omap_hwmod *) * oh_c=
nt);
> =A0 =A0 =A0 =A0od->hwmods =3D hwmods;
> -
> - =A0 =A0 =A0 pdev_name2 =3D kzalloc(strlen(pdev_name) + 1, GFP_KERNE=
L);
> - =A0 =A0 =A0 if (!pdev_name2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit2;
> - =A0 =A0 =A0 strcpy(pdev_name2, pdev_name);
> -
> - =A0 =A0 =A0 od->pdev.name =3D pdev_name2;
> - =A0 =A0 =A0 od->pdev.id =3D pdev_id;
> + =A0 =A0 =A0 od->pdev =3D pdev;
>
> =A0 =A0 =A0 =A0res_count =3D omap_device_count_resources(od);
> =A0 =A0 =A0 =A0if (res_count > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res =3D kzalloc(sizeof(struct resource=
) * res_count, GFP_KERNEL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto odbs_exit3;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 omap_device_fill_resources(od, res);
>
> - =A0 =A0 =A0 od->pdev.num_resources =3D res_count;
> - =A0 =A0 =A0 od->pdev.resource =3D res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_device_fill_resources(od, res);
>
> - =A0 =A0 =A0 ret =3D platform_device_add_data(&od->pdev, pdata, pdat=
a_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D platform_device_add_resources(p=
dev, res, res_count);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(res);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D platform_device_add_data(pdev, pdata, pdata_len=
);
> =A0 =A0 =A0 =A0if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit3;
>
> - =A0 =A0 =A0 od->pm_lats =3D pm_lats;
> - =A0 =A0 =A0 od->pm_lats_cnt =3D pm_lats_cnt;
> + =A0 =A0 =A0 pdev->archdata.od =3D od;
>
> =A0 =A0 =A0 =A0if (is_early_device)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_early_device_register(&od-=
>pdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_early_device_register(pdev=
);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_register(&od->pdev)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_register(pdev);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit3;
> +
> + =A0 =A0 =A0 od->pm_lats =3D pm_lats;
> + =A0 =A0 =A0 od->pm_lats_cnt =3D pm_lats_cnt;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < oh_cnt; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hwmods[i]->od =3D od;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_add_hwmod_clocks_clkdev(od, hwmods[i]=
);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto odbs_exit4;
> -
> - =A0 =A0 =A0 return &od->pdev;
> + =A0 =A0 =A0 return pdev;
>
> -odbs_exit4:
> - =A0 =A0 =A0 kfree(res);
> =A0odbs_exit3:
> - =A0 =A0 =A0 kfree(pdev_name2);
> -odbs_exit2:
> =A0 =A0 =A0 =A0kfree(hwmods);
> -odbs_exit1:
> +odbs_exit2:
> =A0 =A0 =A0 =A0kfree(od);
> +odbs_exit1:
> + =A0 =A0 =A0 platform_device_put(pdev);
> +odbs_exit:
>
> =A0 =A0 =A0 =A0pr_err("omap_device: %s: build failed (%d)\n", pdev_na=
me, ret);
>
> @@ -640,7 +644,7 @@ static int omap_device_register(struct platform_d=
evice *pdev)
>
> =A0 =A0 =A0 =A0pdev->dev.parent =3D &omap_device_parent;
> =A0 =A0 =A0 =A0pdev->dev.pm_domain =3D &omap_device_pm_domain;
> - =A0 =A0 =A0 return platform_device_register(pdev);
> + =A0 =A0 =A0 return platform_device_add(pdev);
> =A0}
>
>
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
