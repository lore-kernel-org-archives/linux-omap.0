From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv8 3/5] OMAP: I2C: Reset support
Date: Fri, 16 Dec 2011 09:26:10 -0800
Message-ID: <20111216172610.GA32251@atomide.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
 <4EEB068C.3010501@ti.com>
 <4EEB07FA.1020100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EEB07FA.1020100-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> [111216 00:25]:
> Hi Benoit,
> 
> On Friday 16 December 2011 02:21 PM, Cousson, Benoit wrote:
> > Hi Shubhro,
> >
> > On 12/13/2011 11:55 AM, Shubhrajyoti D wrote:
> >> Under some error conditions the i2c driver may do a reset.
> >> Adding a reset field and support in the device-specific code to aid
> >> error-recovery.
> >>
> >> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
> >> ---
> >>   arch/arm/plat-omap/i2c.c |    2 ++
> >>   include/linux/i2c-omap.h |    1 +
> >>   2 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> >> index db071bc..6cddde2 100644
> >> --- a/arch/arm/plat-omap/i2c.c
> >> +++ b/arch/arm/plat-omap/i2c.c
> >> @@ -179,6 +179,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
> >>        */
> >>       if (cpu_is_omap34xx())
> >>           pdata->set_mpu_wkup_lat =
> >> omap_pm_set_max_mpu_wakeup_lat_compat;
> >> +
> >> +    pdata->device_reset = omap_device_reset;
> >
> > We should avoid introducing any new pdata function pointers since we
> > are in the process of removing them for DT support.
> However if the driver has to do a reset due to some error what is the
> recommended way?
> Currently we used to access the SYSC directly I am removing the same and
> introducing this  function pointer.

Sounds like this sould be possible to handle with pm_runtime
calls from the driver which should end up making the right
hwmod calls.

Regards,

Tony
