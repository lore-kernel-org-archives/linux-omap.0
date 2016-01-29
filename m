From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v12 2/4] PM / Domains: add setter for dev.pm_domain
Date: Fri, 29 Jan 2016 22:35:18 +0100
Message-ID: <1783906.XctYjeUNLr@vostro.rjw.lan>
References: <1452181575-9206-1-git-send-email-tomeu.vizoso@collabora.com> <CAHp75VdWPUZ8F5rsGn3M1e5Pgpcg1CErBej9PE_3+ZPke5CDFA@mail.gmail.com> <CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf9TS-AxJALQjiwNjMCT8ct5SBanYzrEsV9aj=DsUw-OA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, David Airlie <airlied@linux.ie>, Tomas Winkler <tomas.winkler@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday, January 29, 2016 06:35:49 PM Andy Shevchenko wrote:
> On Fri, Jan 29, 2016 at 5:51 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jan 29, 2016 at 5:38 PM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Thu, Jan 7, 2016 at 5:46 PM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> >>> Adds a function that sets the pointer to dev_pm_domain in struct device
> >>> and that warns if the device has already finished probing. The reason
> >>> why we want to enforce that is because in the general case that can
> >>> cause problems and also that we can simplify code quite a bit if we can
> >>> always assume that.
> >>>
> >>> This patch also changes all current code that directly sets the
> >>> dev.pm_domain pointer.
> >>
> >>
> >>> --- a/drivers/acpi/acpi_lpss.c
> >>> +++ b/drivers/acpi/acpi_lpss.c
> >>
> >>> @@ -875,13 +876,14 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
> >>>
> >>>         switch (action) {
> >>>         case BUS_NOTIFY_BIND_DRIVER:
> >>> -               pdev->dev.pm_domain = &acpi_lpss_pm_domain;
> >>> +               dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
> >>>                 break;
> >>>         case BUS_NOTIFY_DRIVER_NOT_BOUND:
> >>>         case BUS_NOTIFY_UNBOUND_DRIVER:
> >>>                 pdev->dev.pm_domain = NULL;
> >>
> >> Missed?
> >>
> >>>                 break;
> >>>         case BUS_NOTIFY_ADD_DEVICE:
> >>> +               dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
> >>>                 if (pdata->dev_desc->flags & LPSS_LTR)
> >>>                         return sysfs_create_group(&pdev->dev.kobj,
> >>>                                                   &lpss_attr_group);
> >>> @@ -889,6 +891,7 @@ static int acpi_lpss_platform_notify(struct notifier_block *nb,
> >>>         case BUS_NOTIFY_DEL_DEVICE:
> >>>                 if (pdata->dev_desc->flags & LPSS_LTR)
> >>>                         sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
> >>> +               dev_pm_domain_set(&pdev->dev, NULL);
> >>>                 break;
> >>>         default:
> >>>                 break;
> >>
> >> This looks wrong. I didn't test yet, but I have concerns here. Why did
> >> you add those calls?
> >
> >
> > Okay, for first glance it seems working on Intel Braswell.
> 
> One more test unveils this one
> 
> # modprobe -r sdhci-acpi
> [ 1289.909441] ------------[ cut here ]------------
> [ 1289.918205] WARNING: CPU: 1 PID: 4374 at
> /home/andy/prj/linux-otc/drivers/base/power/common.c:150
> dev_pm_domain_set+0x51/0x60()
> [ 1289.934681] PM domains can only be changed for unbound devices
> [ 1289.944843] Modules linked in: sdhci_acpi(-) sdhci mmc_core
> led_class [last unloaded: dw_dmac_core]
> [ 1289.958802] CPU: 1 PID: 4374 Comm: modprobe Not tainted 4.5.0-rc1+ #3
> [ 1289.969736]  ffffffff81c38330 ffff88007bb53d18 ffffffff8133162f
> ffff88007bb53d60
> [ 1289.981844]  ffff88007bb53d50 ffffffff8105cd12 ffff88017a007410
> 0000000000000000
> [ 1289.993996]  0000000000000001 0000000000000080 0000000000000000
> ffff88007bb53db0
> [ 1290.006123] Call Trace:
> [ 1290.012600]  [<ffffffff8133162f>] dump_stack+0x44/0x55
> [ 1290.022052]  [<ffffffff8105cd12>] warn_slowpath_common+0x82/0xc0
> [ 1290.032462]  [<ffffffff8105cd9c>] warn_slowpath_fmt+0x4c/0x50
> [ 1290.042589]  [<ffffffff814867c1>] dev_pm_domain_set+0x51/0x60
> [ 1290.052695]  [<ffffffff813a62a9>] acpi_dev_pm_detach+0x3f/0x84
> [ 1290.062910]  [<ffffffff81486747>] dev_pm_domain_detach+0x27/0x30
> [ 1290.073294]  [<ffffffff81480188>] platform_drv_remove+0x38/0x40
> [ 1290.083585]  [<ffffffff8147da51>] __device_release_driver+0xa1/0x160
> [ 1290.094335]  [<ffffffff8147e5a6>] driver_detach+0xa6/0xb0
> [ 1290.104009]  [<ffffffff8147d435>] bus_remove_driver+0x55/0xd0
> [ 1290.114053]  [<ffffffff8147eccc>] driver_unregister+0x2c/0x50
> [ 1290.124076]  [<ffffffff81480232>] platform_driver_unregister+0x12/0x20
> [ 1290.134957]  [<ffffffffa003681c>] sdhci_acpi_driver_exit+0x10/0x12
> [sdhci_acpi]
> [ 1290.146730]  [<ffffffff810ce0e9>] SyS_delete_module+0x199/0x240
> [ 1290.156907]  [<ffffffff8100219b>] ? exit_to_usermode_loop+0x8b/0x90
> [ 1290.167478]  [<ffffffff81002b83>] do_syscall_32_irqs_off+0x53/0xa0
> [ 1290.177949]  [<ffffffff818b7f9a>] entry_INT80_compat+0x2a/0x40
> [ 1290.187986] ---[ end trace a8351c0506ee239b ]---
> [ 1290.213855] mmc0: card 0001 removed
> 
> Which function is guilty?

acpi_dev_pm_detach() calls dev_pm_domain_set() to clear the pm_domain pointer.

One might argue that this is happening too early.

Thanks,
Rafael

