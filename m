From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
Date: Thu, 7 Jan 2016 15:47:01 +0100
Message-ID: <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
 <1445956731-6304-3-git-send-email-tomeu.vizoso@collabora.com> <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Tomas Winkler <tomas.winkler@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10 November 2015 at 10:33, Daniel Kurtz <djkurtz@chromium.org> wrote:
[snip]
>
> The problem appears to be that:
>   * On boot, platform_drv_probe() calls dev_pm_domain_attach() before
> drv->probe(); thus, it calls dev_pm_domain_attach() while the device
> is unbound.
>
>  * However, for a platform_device, the reboot path calls
> device_shutdown(), but not __device_release_driver():
> device_shutdown()
>   dev->driver->shutdown => platform_drv_shutdown()
>     dev_pm_domain_detach()
>        dev->pm_domain->detach() => genpd_dev_pm_detach()
>          pm_genpd_remove_device()
>             dev_pm_domain_set(dev, NULL);
>
> So, for a platform_device in a genpd power domain with .shutdown
> installed, platform_drv_shutdown() calls dev_pm_domain_detach() while
> the device is still bound, which triggers the WARN().

Hi Rafael, Alan and Ulf,

do you have any suggestion about this? I don't really understand why
the device is detached from the domain on shutdown.

Thanks,

Tomeu

> Thanks,
> -Dan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
