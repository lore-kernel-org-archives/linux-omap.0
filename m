From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 2/3] thermal/drivers/cpu_cooling: Unregister with the policy
Date: Fri, 28 Jun 2019 12:07:23 +0200
Message-ID: <CAJZ5v0iFk=M=0MQMb-XxR_1Vkh9J=TOG3TFBWREYLSNHFTnH-w@mail.gmail.com>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-2-daniel.lezcano@linaro.org> <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list:TI BANDG
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 28, 2019 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jun 27, 2019 at 11:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > Currently the function cpufreq_cooling_register() returns a cooling
> > device pointer which is used back as a pointer to call the function
> > cpufreq_cooling_unregister(). Even if it is correct, it would make
> > sense to not leak the structure inside a cpufreq driver and keep the
> > code thermal code self-encapsulate. Moreover, that forces to add an
> > extra variable in each driver using this function.
> >
> > Instead of passing the cooling device to unregister, pass the policy.
> >
> > Because the cpufreq_cooling_unregister() function uses the policy to
> > unregister itself. The only purpose of the cooling device pointer is
> > to unregister the cpu cooling device.
> >
> > As there is no more need of this pointer, remove it.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

[cut]

> > -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> > +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> >  {
> >         struct cpufreq_cooling_device *cpufreq_cdev;
>
> I would do
>
>         struct cpufreq_cooling_device *ccd, *cpufreq_cdev = NULL;
>
> and then ->

Not even that. ->

>
> >         bool last;
> >
> > -       if (!cdev)
> > -               return;
> > -
> > -       cpufreq_cdev = cdev->devdata;
> > -
> >         mutex_lock(&cooling_list_lock);
> > -       list_del(&cpufreq_cdev->node);
> > -       /* Unregister the notifier for the last cpufreq cooling device */
> > -       last = list_empty(&cpufreq_cdev_list);
> > +       list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
>
> -> list_for_each_entry(ccd, &cpufreq_cdev_list, node) {
>                 if (ccd->policy == policy) {
>
> > +               if (cpufreq_cdev->policy == policy) {
>
>                            cpufreq_cdev = ccd;
>
> > +                       list_del(&cpufreq_cdev->node);
> > +                       last = list_empty(&cpufreq_cdev_list);
> > +                       break;
> > +               }
> > +       }
> >         mutex_unlock(&cooling_list_lock);
>
> And here
>
> if (!cpufreq_cdev)
>         return;

-> It would be sufficient to simply do:

if (cpufreq_cdev->policy != policy)
        return;

here AFAICS.

>
> And that's it.  No new functions needed.
>
> > -       if (last)
> > -               cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
> > -                                           CPUFREQ_POLICY_NOTIFIER);
> > -
>
> And I don't that the above needs to be changed at all in any case.
>
>
> > -       thermal_cooling_device_unregister(cdev);
> > -       ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> > -       kfree(cpufreq_cdev->idle_time);
> > -       kfree(cpufreq_cdev);
> > +       if (cpufreq_cdev->policy == policy)
> > +               __cpufreq_cooling_unregister(cpufreq_cdev, last);
> >  }
