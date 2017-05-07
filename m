From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 1/2] thermal: core: Allow orderly_poweroff to be
 called only once
Date: Sun, 7 May 2017 23:02:19 +0200
Message-ID: <20170507210219.GB25628@atrey.karlin.mff.cuni.cz>
References: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

> thermal_zone_device_check --> thermal_zone_device_update -->
> handle_thermal_trip --> handle_critical_trips --> orderly_poweroff
> 
> The above sequence happens every 250/500 mS based on the configuration.
> The orderly_poweroff function is getting called every 250/500 mS.
> With a full fledged file system it takes at least 5-10 Seconds to
> power off gracefully.
> 
> In that period due to the thermal_zone_device_check triggering
> periodically the thermal work queues bombard with
> orderly_poweroff calls multiple times eventually leading to
> failures in gracefully powering off the system.
> 
> Make sure that orderly_poweroff is called only once.

Pretty please, can we do it in the core code, not in thermal/? There
are other reasons kernel may want to shut the system down, like for
example critical battery, and if both thermal _and_ bad battery
happen, we want just one shutdown...

> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

And here probably we need your full name.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
