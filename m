From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v4 0/3] mfd: tps65217: Add power-button and IRQ
 support
Date: Fri, 2 Sep 2016 08:30:32 -0700
Message-ID: <20160902153032.lhkqvnomx5vineoc@atomide.com>
References: <20160902103526.5050-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160902103526.5050-1-m.niestroj@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Bin Liu <b-liu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Marcin Niestroj <m.niestroj@grinn-global.com> [160902 03:36]:
> Hi,
> 
> This is a resend of v4, rebased on v4.8-rc4, with dropped two patches:
>  * "power_supply: tps65217-charger: Fix NULL deref during property export"
>    (already in mainline)
>  * "power_supply: tps65217-charger: Add support for IRQs" (queued into
>    power-supply's -next branch)
> 
> The following patches add tps65217 power button support and make it usable
> with am335x boards.

Cool this series should also allow using the USB cable detect
interrupt on am335x for one of the USB ports. Will give it a try
using the drivers/phy driver I have in works here for am335x
USB PHY.

Regards,

Tony
