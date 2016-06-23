From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] thermal: core: call thermal_zone_device_update()
 after mode update
Date: Thu, 23 Jun 2016 14:27:12 +0200
Message-ID: <CAJZ5v0hRosrpW50Jx3p6-yHmNFLEaHpf9htfevtunEa10Jo7Dg@mail.gmail.com>
References: <1466563538.2471.10.camel@intel.com> <1466571990-12346-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1466571990-12346-1-git-send-email-edubezval@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2016 at 7:06 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> Because several drivers do the following pattern:
> .set_mode()
>    ...
>    local_data->mode = new_mode;
>    thermal_zone_device_update(tz);
>
> makes sense to simply do the thermal_zone_device_update()
> in thermal core, after setting the new mode.
>
> Also, this patch also remove deadlocks on drivers that
> call thermal_zone_device_update() on .set_mode(),
> as .set_mode()  is now called always with tz->lock held.

To me, this part of the patch is way more important than the
optimization mentioned before.

Apparently, the problem is that drivers deadlock, because the
thermal_zone_device_update() invoked from ->set_mode() is called under
tz->lock.

So to address that problem you make the core call
thermal_zone_device_update() after ->set_mode() outside of tz->lock
and the drivers don't have to do it any more.

Is that correct?

Thanks,
Rafael
