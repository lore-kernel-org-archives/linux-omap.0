From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: dts: tps65217: Add power button interrupt to
 the common tps65217.dtsi file
Date: Tue, 13 Jun 2017 00:35:20 -0700
Message-ID: <20170613073519.GA3730@atomide.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
 <20170612212412.22719-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170612212412.22719-2-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, grygorii.strashko@ti.com, javier@dowhile0.org
List-Id: linux-omap@vger.kernel.org

* Enric Balletbo i Serra <enric.balletbo@collabora.com> [170612 14:28]:
> The interrupt for power button is static data that comes from the
> datasheet, there is no reason to need to define this value on every
> board so seams reasonable put this information into the common tps65217
> file.

I think there's a problem with these patches where we no longer know
if the interrupts are wired up on a board. For example, if the USB PHY
VBUS interrupt is not connected, the phy driver needs poll the
cable state.

And on some PMICs some pins can be muxed to GPIO mode, don't
remember if that can be done with tps65217.

Regards,

Tony
