From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Wed, 23 Jan 2013 07:24:33 -0600
Message-ID: <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
	<1358894185-21617-2-git-send-email-robdclark@gmail.com>
	<20130123104216.1de2eee1@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:33402 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab3AWNYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jan 2013 08:24:35 -0500
Received: by mail-vb0-f50.google.com with SMTP id ft2so7135205vbb.9
        for <linux-omap@vger.kernel.org>; Wed, 23 Jan 2013 05:24:34 -0800 (PST)
In-Reply-To: <20130123104216.1de2eee1@armhf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> =
wrote:
> Hi Rob,
>
> As I wanted to re-use your nxp-tda998x driver for the Marvell Dove So=
C,
> I had a look at your IT LCD driver. Comments below.

Just fyi, you can re-use the nxp-tda998x part independently of tilcdc
(just in case that wasn't clear).

It may be that we need to add some configuration info struct, if for
example there are some differences in video signal mux on the dove
board, but that shouldn't be a big deal.  I figure we can see what is
needed as others start to use it and add as needed.

> On Tue, 22 Jan 2013 16:36:22 -0600
> Rob Clark <robdclark@gmail.com> wrote:
>
>> A simple DRM/KMS driver for the TI LCD Controller found in various
>> smaller TI parts (AM33xx, OMAPL138, etc).  This driver uses the
>> CMA helpers.  Currently only the TFP410 DVI encoder is supported
>> (tested with beaglebone + DVI cape).  There are also various LCD
>> displays, for which support can be added (as I get hw to test on),
>> and an external i2c HDMI encoder found on some boards.
>>
>> The display controller supports a single CRTC.  And the encoder+
>> connector are split out into sub-devices.  Depending on which LCD
>> or external encoder is actually present, the appropriate output
>> module(s) will be loaded.
>>
>> v1: original
>> v2: fix fb refcnting and few other cleanups
>> v3: get +/- vsync/hsync from timings rather than panel-info, add
>>     option DT max-bandwidth field so driver doesn't attempt to
>>     pick a display mode with too high memory bandwidth, and other
>>     small cleanups
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/gpu/drm/Kconfig                |   2 +
>>  drivers/gpu/drm/Makefile               |   1 +
>>  drivers/gpu/drm/tilcdc/Kconfig         |  10 +
>>  drivers/gpu/drm/tilcdc/Makefile        |   8 +
>>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 597 ++++++++++++++++++++++=
++++++++++
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 605 ++++++++++++++++++++++=
+++++++++++
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    | 159 +++++++++
>>  drivers/gpu/drm/tilcdc/tilcdc_regs.h   | 154 +++++++++
>>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 423 ++++++++++++++++++++++=
+
>>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.h |  26 ++
>>  10 files changed, 1985 insertions(+)
>>  create mode 100644 drivers/gpu/drm/tilcdc/Kconfig
>>  create mode 100644 drivers/gpu/drm/tilcdc/Makefile
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.c
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.h
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_regs.h
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
>>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h
>         [snip]
>> diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc=
/Kconfig
>> new file mode 100644
>> index 0000000..ee9b592
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tilcdc/Kconfig
>> @@ -0,0 +1,10 @@
>> +config DRM_TILCDC
>> +     tristate "DRM Support for TI LCDC Display Controller"
>> +     depends on DRM && OF
>> +     select DRM_KMS_HELPER
>> +     select DRM_KMS_CMA_HELPER
>> +     select DRM_GEM_CMA_HELPER
>> +     help
>> +       Choose this option if you have an TI SoC with LCDC display
>> +       controller, for example AM33xx in beagle-bone, DA8xx, or
>> +       OMAP-L1xx.  This driver replaces the FB_DA8XX fbdev driver.
>> diff --git a/drivers/gpu/drm/tilcdc/Makefile b/drivers/gpu/drm/tilcd=
c/Makefile
>> new file mode 100644
>> index 0000000..1359cc2
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tilcdc/Makefile
>> @@ -0,0 +1,8 @@
>> +ccflags-y :=3D -Iinclude/drm -Werror
>> +
>> +tilcdc-y :=3D \
>> +     tilcdc_crtc.o \
>> +     tilcdc_tfp410.o \
>> +     tilcdc_drv.o
>
> As I understand, this means that the 3 objects will go into the
> resident kernel.
>
> I though that the device tree was created for Linux distributors who
> might generate generic ARM kernels, the choice of the drivers being
> done according the local device tree.
>
> From this point of vue, it would be nicer to have 2 separate modules:
> tilcdc and tfp410, tilcdc_crtc being included in one of these ones
> (I did not look deep enough at the code to know which).

drv and crtc are the "core" driver... arguably the tfp410 part could
be optional.  I'd prefer *not* as a separate module, as this implies
some independence of module lifetime, which is not true.  I generally
prefer to start simple and add complexity later if someone really
thinks they need it, which is why I avoided adding a bunch of kconfig
options to start with.

>         [snip]
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/t=
ilcdc/tilcdc_drv.c
>> new file mode 100644
>> index 0000000..cf1fddc
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> @@ -0,0 +1,605 @@
>         [snip]
>> +static struct drm_driver tilcdc_driver =3D {
>> +     .driver_features    =3D DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_=
MODESET,
>> +     .load               =3D tilcdc_load,
>> +     .unload             =3D tilcdc_unload,
>> +     .preclose           =3D tilcdc_preclose,
>> +     .lastclose          =3D tilcdc_lastclose,
>> +     .irq_handler        =3D tilcdc_irq,
>> +     .irq_preinstall     =3D tilcdc_irq_preinstall,
>> +     .irq_postinstall    =3D tilcdc_irq_postinstall,
>> +     .irq_uninstall      =3D tilcdc_irq_uninstall,
>> +     .get_vblank_counter =3D drm_vblank_count,
>> +     .enable_vblank      =3D tilcdc_enable_vblank,
>> +     .disable_vblank     =3D tilcdc_disable_vblank,
>> +     .gem_free_object    =3D drm_gem_cma_free_object,
>> +     .gem_vm_ops         =3D &drm_gem_cma_vm_ops,
>> +     .dumb_create        =3D drm_gem_cma_dumb_create,
>> +     .dumb_map_offset    =3D drm_gem_cma_dumb_map_offset,
>> +     .dumb_destroy       =3D drm_gem_cma_dumb_destroy,
>> +#ifdef CONFIG_DEBUG_FS
>> +     .debugfs_init       =3D tilcdc_debugfs_init,
>> +     .debugfs_cleanup    =3D tilcdc_debugfs_cleanup,
>> +#endif
>> +     .fops               =3D &fops,
>> +     .name               =3D "tilcdc",
>> +     .desc               =3D "TI LCD Controller DRM",
>> +     .date               =3D "20121205",
>> +     .major              =3D 1,
>> +     .minor              =3D 0,
>> +};
>> +
>> +/*
>> + * Power management:
>> + */
>> +
>> +#if CONFIG_PM_SLEEP
>
> Should be:
>
> #ifdef CONFIG_PM_SLEEP
>
>         [snip]
>> +static struct of_device_id tilcdc_of_match[] =3D {
>> +             { .compatible =3D "ti,am33xx-tilcdc", },
>> +             { },
>> +};
>> +MODULE_DEVICE_TABLE(of, tilcdc_of_match);
>> +
>> +static struct platform_driver tilcdc_platform_driver =3D {
>> +     .probe      =3D tilcdc_pdev_probe,
>> +     .remove     =3D tilcdc_pdev_remove,
>> +     .driver     =3D {
>> +             .owner  =3D THIS_MODULE,
>> +             .name   =3D "tilcdc",
>> +             .pm     =3D &tilcdc_pm_ops,
>> +             .of_match_table =3D tilcdc_of_match,
>> +     },
>> +};
>> +
>> +static int __init tilcdc_drm_init(void)
>> +{
>> +     DBG("init");
>> +     tilcdc_tfp410_init();
>
> This function may be called twice if "tilcdc,tfp410" is in the DT.

hmm, I don't think it was but I'll have to double check that.  At
least if it was it wasn't seeming to cause anything bad, because I did
have "tilcdc,tfp410" in DT..

BR,
-R

>> +     return platform_driver_register(&tilcdc_platform_driver);
>> +}
>> +
>> +static void __exit tilcdc_drm_fini(void)
>> +{
>> +     DBG("fini");
>> +     tilcdc_tfp410_fini();
>> +     platform_driver_unregister(&tilcdc_platform_driver);
>> +}
>> +
>> +module_init(tilcdc_drm_init);
>> +module_exit(tilcdc_drm_fini);
>> +
>> +MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
>> +MODULE_DESCRIPTION("TI LCD Controller DRM Driver");
>> +MODULE_LICENSE("GPL");
>
>
> --
> Ken ar c'henta=F1 |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
