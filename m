From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change state
Date: Tue, 26 Jun 2012 20:19:05 +0530
Message-ID: <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	<1340605221.12683.30.camel@lappyti>
	<CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	<1340616643.3395.19.camel@deskari>
	<CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	<1340628094.3395.63.camel@deskari>
	<CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	<1340632161.3395.100.camel@deskari>
	<CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	<1340695166.2093.22.camel@lappyti>
	<CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	<1340701660.24530.17.camel@deskari>
	<CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	<1340712213.24530.21.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49994 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914Ab2FZOtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:49:07 -0400
Received: by bkcji2 with SMTP id ji2so4257122bkc.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 07:49:05 -0700 (PDT)
In-Reply-To: <1340712213.24530.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com

On 26 June 2012 17:33, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Tue, 2012-06-26 at 15:27 +0530, Jassi Brar wrote:
>
>> Seems similar, but I only tested OMAP4 HDMI.
>
> Would something like this one below work for you? It fixes the issues=
 on
> my overo board.
>
I think this should work too (I will get to test it only tomorrow).

Though I don't think it'll fix stack spew when run without
CONFIG_PM_RUNTIME. Maybe we could simply remove the WARN_ON in the
xxx_runtime_put() as Alan noted?

-j

> Instead of using omapdss device's suspend/resume callbacks, this one
> uses PM notifier calls which happen before suspend and after resume.
>
> I still think the suspend handling is wrong, omapdss shouldn't be
> enabling and disabling panel devices like that, but this one should
> remove the biggest issues with the current suspend method.
>
> =C2=A0Tomi
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss=
/core.c
> index 5066eee..c35a248 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -32,6 +32,7 @@
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/suspend.h>
>
> =C2=A0#include <video/omapdss.h>
>
> @@ -201,6 +202,30 @@ int dss_debugfs_create_file(const char *name, vo=
id (*write)(struct seq_file *))
> =C2=A0#endif /* CONFIG_DEBUG_FS && CONFIG_OMAP2_DSS_DEBUG_SUPPORT */
>
> =C2=A0/* PLATFORM DEVICE */
> +static int omap_dss_pm_notif(struct notifier_block *b, unsigned long=
 v, void *d)
> +{
> + =C2=A0 =C2=A0 =C2=A0 DSSDBG("pm notif %lu\n", v);
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (v)
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 case PM_SUSPEND_PREPARE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSSDBG("suspending=
 displays\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return dss_suspend=
_all_devices();
> +
> + =C2=A0 =C2=A0 =C2=A0 case PM_POST_SUSPEND:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DSSDBG("resuming d=
isplays\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return dss_resume_=
all_devices();
> +
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> +static struct notifier_block omap_dss_pm_notif_block =3D
> +{
> + =C2=A0 =C2=A0 =C2=A0 .notifier_call =3D omap_dss_pm_notif,
> +};
> +
> =C2=A0static int __init omap_dss_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_dss_board_info *pdata =3D pdev=
->dev.platform_data;
> @@ -224,6 +249,8 @@ static int __init omap_dss_probe(struct platform_=
device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (pdata->default_device)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0core.default_d=
isplay_name =3D pdata->default_device->name;
>
> + =C2=A0 =C2=A0 =C2=A0 register_pm_notifier(&omap_dss_pm_notif_block)=
;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> =C2=A0err_debugfs:
> @@ -233,6 +260,8 @@ err_debugfs:
>
> =C2=A0static int omap_dss_remove(struct platform_device *pdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 unregister_pm_notifier(&omap_dss_pm_notif_bloc=
k);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dss_uninitialize_debugfs();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dss_uninit_overlays(pdev);
> @@ -247,25 +276,9 @@ static void omap_dss_shutdown(struct platform_de=
vice *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dss_disable_all_devices();
> =C2=A0}
>
> -static int omap_dss_suspend(struct platform_device *pdev, pm_message=
_t state)
> -{
> - =C2=A0 =C2=A0 =C2=A0 DSSDBG("suspend %d\n", state.event);
> -
> - =C2=A0 =C2=A0 =C2=A0 return dss_suspend_all_devices();
> -}
> -
> -static int omap_dss_resume(struct platform_device *pdev)
> -{
> - =C2=A0 =C2=A0 =C2=A0 DSSDBG("resume\n");
> -
> - =C2=A0 =C2=A0 =C2=A0 return dss_resume_all_devices();
> -}
> -
> =C2=A0static struct platform_driver omap_dss_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D om=
ap_dss_remove,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.shutdown =C2=A0 =C2=A0 =C2=A0 =3D omap_ds=
s_shutdown,
> - =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D omap_d=
ss_suspend,
> - =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D omap_d=
ss_resume,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D=
 "omapdss",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =C2=A0=3D=
 THIS_MODULE,
>



--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106 =C2=A0-
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
