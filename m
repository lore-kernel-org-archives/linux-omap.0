From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [PATCH] RTC: rtc-twl: Convert to module_platform_driver() and
 relocate reg_map init
Date: Tue, 16 Apr 2013 11:10:56 +0300
Message-ID: <516D0790.7090902@iki.fi>
References: <1366098262-20726-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366098262-20726-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 2013-04-16 10:44, Peter Ujfalusi wrote:
> Convert the driver to use module_platform_driver() to register the platform
> driver and relocate the rtc_reg_map initialization to platform driver's
> probe function.
> In this way we can make sure that the twl-core has been already probed since
> the core driver will create the device at the end of it's probe function.
> 
> Reported-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I think there are two distinct things here. The actual fix for the
regmap, and a module_platform_driver cleanup. I would suggest having
them in separate patches.

And even if these are combined, I think the patch subject and
description should talk about fixing the regmap bug. Now it's rather
unclear that an actual bug is being fixed.

 Tomi
