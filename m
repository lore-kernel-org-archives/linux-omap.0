From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/1] thermal: core: call thermal_zone_device_update()
 after mode update
Date: Fri, 1 Jul 2016 13:53:31 -0700
Message-ID: <20160701205329.GB7814@localhost.localdomain>
References: <1466563538.2471.10.camel@intel.com>
 <1466571990-12346-1-git-send-email-edubezval@gmail.com>
 <CAJZ5v0hRosrpW50Jx3p6-yHmNFLEaHpf9htfevtunEa10Jo7Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hRosrpW50Jx3p6-yHmNFLEaHpf9htfevtunEa10Jo7Dg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 23, 2016 at 02:27:12PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 22, 2016 at 7:06 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> > Because several drivers do the following pattern:
> > .set_mode()
> >    ...
> >    local_data->mode = new_mode;
> >    thermal_zone_device_update(tz);
> >
> > makes sense to simply do the thermal_zone_device_update()
> > in thermal core, after setting the new mode.
> >
> > Also, this patch also remove deadlocks on drivers that
> > call thermal_zone_device_update() on .set_mode(),
> > as .set_mode()  is now called always with tz->lock held.
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

Yes this is correct. The optimization is simply a consequence of the bug
fix, as reported by Keerthy.

> 
> Thanks,
> Rafael
