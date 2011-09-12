From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCHv2 09/15] OMAP: DSS2: HDMI: implement detect()
Date: Mon, 12 Sep 2011 18:54:33 +0530
Message-ID: <CAP5A+B9_Jsg23oR49q2bkBGVLDWHBiBZj_=_G1SRf7ftrMt_iw@mail.gmail.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com> <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:60537 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755885Ab1ILNYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 09:24:54 -0400
In-Reply-To: <1315818818-18733-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

Hi Tomi,

On Mon, Sep 12, 2011 at 2:43 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Implement detect() by checking the hot plug detect status.
>
> The implementation is not very good, as it always turns on the HDMI
> output to get the detection working. HDMI driver needs improvements s=
o
> that we could enable only core parts of it.
>
> Cc: Mythri P K <mythripk@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/video/omap2/dss/dss_features.c =A0 =A0| =A0 =A01 +
> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +++=
++++++++++++++
> =A0drivers/video/omap2/dss/hdmi_panel.c =A0 =A0 =A0| =A0 25 +++++++++=
++++++++++++++++
> =A0drivers/video/omap2/dss/ti_hdmi.h =A0 =A0 =A0 =A0 | =A0 =A03 +++
> =A0drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c | =A0 12 ++++++++++++
> =A06 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/=
dss.h
> index 2e7799c..f58c302 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -495,6 +495,7 @@ void omapdss_hdmi_display_set_timing(struct omap_=
dss_device *dssdev);
> =A0int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssd=
ev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct omap_video_timings *timings);
> =A0int omapdss_hdmi_read_edid(u8 *buf, int len);
> +bool omapdss_hdmi_detect(void);
> =A0int hdmi_panel_init(void);
> =A0void hdmi_panel_exit(void);
>
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/o=
map2/dss/dss_features.c
> index 076f399..ab41665 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -440,6 +440,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_fun=
ctions =3D {
> =A0 =A0 =A0 =A0.phy_enable =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti=
_hdmi_4xxx_phy_enable,
> =A0 =A0 =A0 =A0.phy_disable =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti=
_hdmi_4xxx_phy_disable,
> =A0 =A0 =A0 =A0.read_edid =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 =
ti_hdmi_4xxx_read_edid,
> + =A0 =A0 =A0 .detect =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0=
 ti_hdmi_4xxx_detect,
> =A0 =A0 =A0 =A0.pll_enable =A0 =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti=
_hdmi_4xxx_pll_enable,
> =A0 =A0 =A0 =A0.pll_disable =A0 =A0 =A0 =A0 =A0 =A0=3D =A0 =A0 =A0 ti=
_hdmi_4xxx_pll_disable,
> =A0 =A0 =A0 =A0.video_enable =A0 =A0 =A0 =A0 =A0 =3D =A0 =A0 =A0 ti_h=
dmi_4xxx_wp_video_start,
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss=
/hdmi.c
> index fb85ce5..7818670 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -449,6 +449,23 @@ int omapdss_hdmi_read_edid(u8 *buf, int len)
> =A0 =A0 =A0 =A0return r;
> =A0}
>
> +bool omapdss_hdmi_detect(void)
> +{
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 mutex_lock(&hdmi.lock);
> +
> + =A0 =A0 =A0 r =3D hdmi_runtime_get();
> + =A0 =A0 =A0 BUG_ON(r);
> +
> + =A0 =A0 =A0 r =3D hdmi.ip_data.ops->detect(&hdmi.ip_data);
> +
> + =A0 =A0 =A0 hdmi_runtime_put();
> + =A0 =A0 =A0 mutex_unlock(&hdmi.lock);
> +
> + =A0 =A0 =A0 return r =3D=3D 1;
> +}
> +
> =A0int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r =3D 0;
> diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/oma=
p2/dss/hdmi_panel.c
> index 71aa813..533d5dc 100644
> --- a/drivers/video/omap2/dss/hdmi_panel.c
> +++ b/drivers/video/omap2/dss/hdmi_panel.c
> @@ -25,6 +25,7 @@
> =A0#include <linux/mutex.h>
> =A0#include <linux/module.h>
> =A0#include <video/omapdss.h>
> +#include <linux/slab.h>
>
> =A0#include "dss.h"
>
> @@ -198,6 +199,29 @@ err:
> =A0 =A0 =A0 =A0return r;
> =A0}
>
> +static bool hdmi_detect(struct omap_dss_device *dssdev)
> +{
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 mutex_lock(&hdmi.hdmi_lock);
> +
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapdss_hdmi_display_enable(dssde=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 r =3D omapdss_hdmi_detect();
> +
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_DISABLED ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dssdev->state =3D=3D OM=
AP_DSS_DISPLAY_SUSPENDED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omapdss_hdmi_display_disable(dssdev);
> +err:
> + =A0 =A0 =A0 mutex_unlock(&hdmi.hdmi_lock);
> +
> + =A0 =A0 =A0 return r;
> +}
> +
> =A0static struct omap_dss_driver hdmi_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D hdmi_panel_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D hdmi_panel_remove,
> @@ -209,6 +233,7 @@ static struct omap_dss_driver hdmi_driver =3D {
> =A0 =A0 =A0 =A0.set_timings =A0 =A0=3D hdmi_set_timings,
> =A0 =A0 =A0 =A0.check_timings =A0=3D hdmi_check_timings,
> =A0 =A0 =A0 =A0.read_edid =A0 =A0 =A0=3D hdmi_read_edid,
> + =A0 =A0 =A0 .detect =A0 =A0 =A0 =A0 =3D hdmi_detect,
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "hdmi_panel",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/=
dss/ti_hdmi.h
> index 390cd85b..d48603c 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -94,6 +94,8 @@ struct ti_hdmi_ip_ops {
>
> =A0 =A0 =A0 =A0int (*read_edid)(struct hdmi_ip_data *ip_data, u8 *edi=
d, int len);
>
> + =A0 =A0 =A0 bool (*detect)(struct hdmi_ip_data *ip_data);
> +
> =A0 =A0 =A0 =A0int (*pll_enable)(struct hdmi_ip_data *ip_data);
>
> =A0 =A0 =A0 =A0void (*pll_disable)(struct hdmi_ip_data *ip_data);
> @@ -114,6 +116,7 @@ struct hdmi_ip_data {
> =A0int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
> =A0void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> =A0int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *ip_data, u8 *edid,=
 int len);
> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data);
> =A0void ti_hdmi_4xxx_wp_video_start(struct hdmi_ip_data *ip_data, boo=
l start);
> =A0int ti_hdmi_4xxx_pll_enable(struct hdmi_ip_data *ip_data);
> =A0void ti_hdmi_4xxx_pll_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/vide=
o/omap2/dss/ti_hdmi_4xxx_ip.c
> index e9885dc..da7fe50 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -416,6 +416,18 @@ int ti_hdmi_4xxx_read_edid(struct hdmi_ip_data *=
ip_data,
> =A0 =A0 =A0 =A0return l;
> =A0}
>
> +bool ti_hdmi_4xxx_detect(struct hdmi_ip_data *ip_data)
> +{
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 void __iomem *base =3D hdmi_core_sys_base(ip_data);
> +
> + =A0 =A0 =A0 /* HPD */
> + =A0 =A0 =A0 r =3D REG_GET(base, HDMI_CORE_SYS_SYS_STAT, 1, 1);
> +
> + =A0 =A0 =A0 return r =3D=3D 1;
> +}
> +
=46or HPD the probe should also be on the core interrupt first , and th=
e
detect should be dynamic, ie based on the cable connect and disconnect
event.So this approach for HPD is not really the way.
Also that should be based on the GPIO(63) , I am planning to push a
patch on that shortly.

> =A0static void hdmi_core_init(struct hdmi_core_video_config *video_cf=
g,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hdmi_core_infof=
rame_avi *avi_cfg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hdmi_core_packe=
t_enable_repeat *repeat_cfg)
> --
> 1.7.4.1
>
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
