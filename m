From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Sat, 4 Sep 2010 08:49:19 +0200
Message-ID: <20100904084919.0040faa0@hyperion.delvare>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
	<20100901104052.5967ca25@hyperion.delvare>
	<FCCFB4CDC6E5564B9182F639FC35608703114DA108@dbde02.ent.ti.com>
	<201009040110.10858.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201009040110.10858.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Sep 2010 01:10:10 +0200, Rafael J. Wysocki wrote:
> On Friday, September 03, 2010, Sripathy, Vishwanath wrote:
> > We are seeing one more issue even after making this fix. In summary, after first suspend/resume, CPU Idle no longer works since i2c module is active. 
> > Basically when the system resumed from the suspend, dpm layer (dpm_resume_end) calls device_resume which intern calls i2c_device_pm_resume (among many other calls). 
> > i2c_device_pm_resume calls pm_runtime_set_active which brings device to Active state and increases child_count of it's parent. Since the device is active and also it's parent child_count is non 0, these modules will prevent corresponding clock domains to go idle. This will break CPU Idle. This issue happens even if the module was in idle state before performing suspend/resume. In summary, the flow is 
> > 1. i2c module is idle (let's assume system is idle)
> > 2. system suspend is initiated by user
> > 3. i2c_device_pm_suspend gets called which tries to idle i2c, but it's already idled.
> > 4. system is suspended
> > 5. system resumed (because of user event/timers)
> > 6. dpm layer will call i2c_device_pm_resume
> > 7. i2c_device_pm_resume will enable i2c device by calling pm_runtime_set_active
> > So at the end of suspend/resume, a device that was idled before is getting enabled unnecessarily at the end.
> > 
> > SO I am just wondering is there any real need to call pm_runtime_set_active in resume and pm_runtime_set_suspened in suspend functions?
> > I just tried suspend/resume and CPU Idle after removing these calls in i2c and it seems to function perfectly fine on OMAP4.
> 
> Your analysis appears to be entirely correct.
> 
> So, instead of applying the $subject patch it might be better to remove the
> block that calls pm_runtime_set_active(dev) from i2c_device_pm_resume().
> 
> Are there any objections?

No objection. Just send an updated patch and I'll be happy to apply it.

-- 
Jean Delvare
