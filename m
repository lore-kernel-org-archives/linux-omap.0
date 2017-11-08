From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/7] omap: dmtimer: Move driver out of plat-omap
Date: Wed, 8 Nov 2017 14:57:12 -0800
Message-ID: <20171108225712.GX28152@atomide.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: aaro.koskinen@iki.fi, thierry.reding@gmail.com, khilman@kernel.org, daniel.lezcano@linaro.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [171108 04:30]:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.
> 
> Boot tested on DRA7-EVM and AM437X-GP-EVM.
> 
> More testing would be of great help. 
> 
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

OK Cool.

Thierry, can you please take a look at the driver code and see if
you want other clean-ups done before moving this to drivers?

For merging, I can set up an immutable branch for this against
v4.15-rc1 when it's out and no more comments. That way we both
can then merge it in as needed.

Regards,

Tony
