From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Remove unused
 omap_dm_timer_set_load_start
Date: Thu, 4 Apr 2019 07:15:13 -0700
Message-ID: <20190404141513.GD49658@atomide.com>
References: <20190404063536.23958-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404063536.23958-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190404 06:35]:
> omap_dm_timer_set_load_start is no longer used hence delete the
> function and remove the below warning.
> 
> drivers/clocksource/timer-ti-dm.c:589:12:
> warning: ‘omap_dm_timer_set_load_start’ defined but not used

Hmm see earlier "[PATCH] clocksource/drivers/timer-ti-dm: Remove
omap_dm_timer_set_load_start", I think this is a duplicate.

Regards,

Tony
