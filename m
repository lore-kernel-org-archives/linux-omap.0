From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v5 0/8] omap: dmtimer: Move driver out of plat-omap
Date: Mon, 18 Dec 2017 12:16:10 +0100
Message-ID: <20171218111610.GA16906@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org

Keerthy,

On Tue, Dec 12, 2017 at 11:42:09AM +0530, Keerthy wrote:
> The series moves dmtimer out of plat-omap to drivers/clocksource.
> The series also does a bunch of changes to pwm-omap-dmtimer code
> to adapt to the driver migration and clean up plat specific
> pdata-quirks and use the dmtimer platform data.

thanks for nice work. I'll send two more patches as a reply to this
one. I'd be glad if you could make them part of your serie. One of
them would be nice to have for pwm driver prescaler fix which will
be send independently.
Also, if that helps you can have my
Tested-by: Ladislav Michl <ladis@linux-mips.org>
on IGEPv2 (OMAP3430 based)

> Boot tested on DRA7-EVM and AM437X-GP-EVM.

I guess PWM driver was not tested, right? See comment to PATCH 7/8.

> Compile tested omap1_defconfig.

Thank you,
	ladis
