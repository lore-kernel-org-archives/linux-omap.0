From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
Date: Mon, 11 Jan 2016 22:09:58 +0100
Message-ID: <CAPDyKFqGU64o+ov5r1pHRHb1QdaR2ZTY1Yfbi+HsoTyVPYhTLw@mail.gmail.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
	<CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
	<CAOMZO5A7p6iZTdnZtnzMPED1e7rPp=1Q9UiZ_598QNTWSL5jMw@mail.gmail.com>
	<2574144.OjYZBRkjZl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2574144.OjYZBRkjZl@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fabio Estevam <festevam@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Daniel Kurtz <djkurtz@chromium.org>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Tomas Winkler <tomas.winkler@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

[...]

>> >
>> > Hi Rafael, Alan and Ulf,
>> >
>> > do you have any suggestion about this? I don't really understand why
>> > the device is detached from the domain on shutdown.

Sorry for the delay.

I fully agree with you Rafael, it shouldn't be detached. It's a bug.

>>
>> I am running linux-next and this commit causes the same problem for me
>> on a mx6 after running a 'reboot' command:
>>
>> Requesting system reboot
>> [   15.058782] ------------[ cut here ]------------
>> [   15.063459] WARNING: CPU: 3 PID: 1122 at
>> drivers/base/power/common.c:150 dev_pm_domain_set+0x4c/0x58()
>> [   15.072838] PM domains can only be changed for unbound devices
>> [   15.078735] Modules linked in:
>> [   15.081849] CPU: 3 PID: 1122 Comm: init Not tainted
>> 4.4.0-rc8-next-20160111-dirty #207
>> [   15.089826] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [   15.096375] Backtrace:
>> [   15.098941] [<c00136d8>] (dump_backtrace) from [<c0013874>]
>> (show_stack+0x18/0x1c)
>> [   15.106532]  r6:00000096 r5:00000000 r4:00000000 r3:00000000
>> [   15.112390] [<c001385c>] (show_stack) from [<c02de89c>]
>> (dump_stack+0x88/0xa4)
>> [   15.119708] [<c02de814>] (dump_stack) from [<c002bcac>]
>> (warn_slowpath_common+0x80/0xbc)
>> [   15.127860]  r5:c03da810 r4:ee63bd68
>> [   15.131533] [<c002bc2c>] (warn_slowpath_common) from [<c002bd8c>]
>> (warn_slowpath_fmt+0x38/0x40)
>> [   15.140292]  r8:eea01db0 r7:c0b0f87c r6:eea01d80 r5:00000000 r4:ef181410
>> [   15.147165] [<c002bd58>] (warn_slowpath_fmt) from [<c03da810>]
>> (dev_pm_domain_set+0x4c/0x58)
>> [   15.155661]  r3:c0b0f7f0 r2:c09e82dc
>> [   15.159373] [<c03da7c4>] (dev_pm_domain_set) from [<c03e4e5c>]
>> (genpd_free_dev_data+0x20/0x50)
>> [   15.168065]  r5:ef1814a0 r4:ef181410
>> [   15.171737] [<c03e4e3c>] (genpd_free_dev_data) from [<c03e5fe4>]
>> (pm_genpd_remove_device+0xb4/0xe0)
>> [   15.180842]  r6:ef181410 r5:eea01d80 r4:c0b0f7f0 r3:00000000
>> [   15.186644] [<c03e5f30>] (pm_genpd_remove_device) from [<c03e6040>]
>> (genpd_dev_pm_detach+0x30/0xac)
>> [   15.195743]  r8:c0b0f7f0 r7:c1379734 r6:00000001 r5:c0b209c4
>> r4:ef181410 r3:00000000
>> [   15.203694] [<c03e6010>] (genpd_dev_pm_detach) from [<c03da7c0>]
>> (dev_pm_domain_detach+0x28/0x2c)
>> [   15.212621]  r10:ef181444 r8:c0b6f560 r7:c1379734 r6:ef181410
>> r5:ef173c10 r4:ef181410
>> [   15.220683] [<c03da798>] (dev_pm_domain_detach) from [<c03d3ea0>]
>> (platform_drv_shutdown+0x34/0x38)
>> [   15.229817] [<c03d3e6c>] (platform_drv_shutdown) from [<c03d05b0>]
>> (device_shutdown+0x3c/0x194)
>
> OK, so does the appended patch help?
>
> Rafael
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] platform: Do not detach from PM domains on shutdown
>
> Shutdown is carried out when the driver is still bound to the
> device, so it is incorrect to detach it from a PM domain (if any)
> at this point.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/platform.c |    1 -
>  1 file changed, 1 deletion(-)
>
> Index: linux-pm/drivers/base/platform.c
> ===================================================================
> --- linux-pm.orig/drivers/base/platform.c
> +++ linux-pm/drivers/base/platform.c
> @@ -577,7 +577,6 @@ static void platform_drv_shutdown(struct
>
>         if (drv->shutdown)
>                 drv->shutdown(dev);
> -       dev_pm_domain_detach(_dev, true);
>  }
>
>  /**
>
