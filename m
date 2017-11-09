From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] arm: omap: Move dmtimer.h out of plat-omap
Date: Thu, 9 Nov 2017 06:52:23 -0800
Message-ID: <20171109145223.GB28152@atomide.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-3-git-send-email-j-keerthy@ti.com>
 <20171108164221.GV28152@atomide.com>
 <6ca9c73a-95a1-2466-151e-cdba64c3c478@ti.com>
 <008c2d8b-6f76-882d-fc70-8fd4204c49d5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008c2d8b-6f76-882d-fc70-8fd4204c49d5@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [171109 08:09]:
> 
> 
> On Thursday 09 November 2017 09:55 AM, Keerthy wrote:
> > 
> > 
> > On Wednesday 08 November 2017 10:12 PM, Tony Lindgren wrote:
> >> * Keerthy <j-keerthy@ti.com> [171108 12:31]:
> >>> The header file is currently under plat-omap directory
> >>> under arch/omap. Move this out to an accessible place.
> >>>
> >>> No Code changes done to the header file.
> >>
> >> Some of the dmtimer functions are in this header to optimize the
> >> size of the system timer code. Can you please check if some of them
> >> can be left out of dmtimer.h and be made private to mach-omap1/timer.c
> >> and mach-omap2/timer.c?
> > 
> > Okay. I will try to clean that as well.
> 
> Tony,
> 
> Only function that i could push out of dmtimer.h was
> __omap_dm_timer_override_errata
> 
> which is being currently called by mach-omap2/timer.c alone.

Hmm OK thanks for checking.

> Rest all are used both my dmtimer.c as well as mach-omap2/timer.c.
> Here is the list:
> 
> __omap_dm_timer_read
> __omap_dm_timer_write
> __omap_dm_timer_init_regs
> __omap_dm_timer_enable_posted
> __omap_dm_timer_stop
> __omap_dm_timer_load_start
> __omap_dm_timer_int_enable
> __omap_dm_timer_read_counter
> __omap_dm_timer_write_status
> 
> Any preferences on moving them to dmtimer.c or leaving them in header file?

How about we make the system timer functions and these header
functions private to the dmtimer.c. Then we can have the SoC specific
system timer functions be selected based on comaptible value like
drivers typically do :)

I think only the SoC specific init code should be left in
arch/arm/mach-omap[12]/timer.c.

Regards,

Tony
