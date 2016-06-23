From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 1/1] thermal: core: call thermal_zone_device_update()
 after mode update
Date: Thu, 23 Jun 2016 18:07:58 +0530
Message-ID: <576BD826.6030007@ti.com>
References: <1466563538.2471.10.camel@intel.com>
 <1466571990-12346-1-git-send-email-edubezval@gmail.com>
 <CAJZ5v0hRosrpW50Jx3p6-yHmNFLEaHpf9htfevtunEa10Jo7Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hRosrpW50Jx3p6-yHmNFLEaHpf9htfevtunEa10Jo7Dg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Thursday 23 June 2016 05:57 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 22, 2016 at 7:06 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
>> Because several drivers do the following pattern:
>> .set_mode()
>>     ...
>>     local_data->mode = new_mode;
>>     thermal_zone_device_update(tz);
>>
>> makes sense to simply do the thermal_zone_device_update()
>> in thermal core, after setting the new mode.
>>
>> Also, this patch also remove deadlocks on drivers that
>> call thermal_zone_device_update() on .set_mode(),
>> as .set_mode()  is now called always with tz->lock held.
>
> To me, this part of the patch is way more important than the
> optimization mentioned before.
>
> Apparently, the problem is that drivers deadlock, because the
> thermal_zone_device_update() invoked from ->set_mode() is called under
> tz->lock.
>
> So to address that problem you make the core call
> thermal_zone_device_update() after ->set_mode() outside of tz->lock
> and the drivers don't have to do it any more.
>
> Is that correct?

Rafael,

On my set up, mode_store locks tz->lock and eventually ends up calling 
of_thermal_set_mode before releasing tz->lock which again tries to lock 
tz->lock and ends up in a deadlock.

http://pastebin.ubuntu.com/17687601/

Regards,
Keerthy
>
> Thanks,
> Rafael
>
