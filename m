From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH v4 11/18] input: Add initial support for TWL6040 vibrator
Date: Mon, 13 Jun 2011 12:51:16 +0300
Message-ID: <1530216.k8lJ4nKZ1s@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com> <1307706876-4768-12-git-send-email-peter.ujfalusi@ti.com> <20110611231854.GA3979@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110611231854.GA3979@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 12 June 2011 01:18:54 Dmitry Torokhov wrote:
> > +static void twl6040_vibra_enable(struct vibra_info *info)
> > +{
> > +     struct twl6040 *twl6040 =3D info->twl6040;
> > +     int ret =3D 0;
>=20
> Initialization is not needed.

True.

> > +static void vibra_play_work(struct work_struct *work)
> > +{
> > +     struct vibra_info *info =3D container_of(work,
> > +                             struct vibra_info, play_work);
> > +
> > +     mutex_lock(&info->mutex);
> > +
> > +     if (info->weak_speed || info->strong_speed) {
> > +             if (!info->enabled)
> > +                     twl6040_vibra_enable(info);
> > +
> > +             twl6040_vibra_set_effect(info);
> > +     } else if (info->enabled)
> > +             twl6040_vibra_disable(info);
>=20
> Why do we play with enabling/disabling the device here? Nobody can
> request playing of an effect unless the device has been opened so if =
we
> manage power state in open/close methods we should not be doing it he=
re
> I think.

We want to preserve as much power as we can.
So if application opens the driver, but it is not requesting to play an=
y=20
effect we still keep the device turned off.
When application request for stopping the effect without closing the de=
vice,=20
we turn off things in a similar way.
The twl4030-vibra driver has been implemented in this way as well.

> > +
> > +     mutex_unlock(&info->mutex);
> > +}

=2E..

> > +static int twl6040_vibra_open(struct input_dev *input)
> > +{
> > +     struct vibra_info *info =3D input_get_drvdata(input);
> > +
> > +     info->workqueue =3D create_singlethread_workqueue("vibra");
> > +     if (info->workqueue =3D=3D NULL) {
> > +             dev_err(&input->dev, "couldn't create workqueue\n");
> > +             return -ENOMEM;
> > +     }
>=20
> Why do we need to create a separate workqueue? With arrival of CWQ
> it looks like we should be able to use one of the system-wide
> workqueues for this.

The reason for this is to ensure that we have the lowest latency as pos=
sible=20
in most case. In the embedded devices we use the vibra for tactile type=
 of=20
feedbacks as well, where few tens of ms delay can be felt.

> > +
> > +     return 0;
> > +}
> > +
> > +static void twl6040_vibra_close(struct input_dev *input)
> > +{
> > +     struct vibra_info *info =3D input_get_drvdata(input);
> > +
> > +     cancel_work_sync(&info->play_work);
> > +     INIT_WORK(&info->play_work, vibra_play_work);
> > +     destroy_workqueue(info->workqueue);
> > +     info->workqueue =3D NULL;
> > +
> > +     mutex_lock(&info->mutex);
> > +
> > +     if (info->enabled)
> > +             twl6040_vibra_disable(info);
> > +
> > +     mutex_unlock(&info->mutex);
> > +}
> > +
> > +#if CONFIG_PM
>=20
> CONFIG_PM_SLEEP.

OK, will be fixed.

> > +static int twl6040_vibra_suspend(struct device *dev)
> > +{
> > +     struct platform_device *pdev =3D to_platform_device(dev);
> > +     struct vibra_info *info =3D platform_get_drvdata(pdev);
> > +
> > +     mutex_lock(&info->mutex);
> > +
> > +     if (info->enabled)
> > +             twl6040_vibra_disable(info);
> > +
> > +     mutex_unlock(&info->mutex);
> > +
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops,
> > +                      twl6040_vibra_suspend, NULL);
>=20
> Move twl6040_vibra_pm_ops definition out of the #ifdef block so you
> won't need to protect it use with ifdefs later.

Thanks, I have change this.
=20
> > +#endif

=2E..

> > +static int __devexit twl6040_vibra_remove(struct platform_device *=
pdev)
> > +{
> > +     struct vibra_info *info =3D platform_get_drvdata(pdev);
> > +
> > +     twl6040_power(info->twl6040, 0);
>=20
> If we ensure that device is powered off until open() is called, and
> also powered off when close() is called, then we do not need to switc=
h
> off power here.

True, removed.

> Thanks.
>=20
> --
> Dmitry

Thanks for the comments. I will update the series.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
