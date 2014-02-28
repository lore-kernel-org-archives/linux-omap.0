From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Add more device nodes for am43x-epos-evm
Date: Fri, 28 Feb 2014 14:04:54 -0800
Message-ID: <20140228220453.GG13624@atomide.com>
References: <1385537447-6922-1-git-send-email-sourav.poddar@ti.com>
 <52A04C11.1030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56256 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751729AbaB1WFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 17:05:09 -0500
Content-Disposition: inline
In-Reply-To: <52A04C11.1030007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: bcousson@baylibre.com, rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com

* Sourav Poddar <sourav.poddar@ti.com> [131205 01:50]:
> On Wednesday 27 November 2013 01:00 PM, Sourav Poddar wrote:
> >The patch series adds support for enabling pwm backlight, i2c2, spi and
> >matrix gpio keys on am43x-gp-evm.
> >
> >Done on top of 3.13-rc1 + tero clock series(1)
> >
> >[1]: https://patchwork.kernel.org/patch/3009541/
> >
> >Tested on am43x-gp-evm.
> >
> >There is a some bug while using regulators through backlight
> >driver on 3.13-rc1. So, tested pwm part with this temporary patch[2].
> >
> >[2]: http://www.spinics.net/lists/arm-kernel/msg288215.html
> >
> >Darren Etheridge (1):
> >   pinctrl: am43xx: dt-bindings: add MUX_MODE8
> >
> >Sourav Poddar (4):
> >   arm: dts: am4372: Add pwm-cellsproperty for ecap device.
> >   arm: dts: am43x-epos-evm: Add I2C data.
> >   arm: dts: am43x-epos-evm: Add SPI data.
> >   ARM: dts: am43x-epos-evm: Add pwm backlight support.
> >
> >  arch/arm/boot/dts/am4372.dtsi        |    9 +++++
> >  arch/arm/boot/dts/am43x-epos-evm.dts |   67 ++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/pinctrl/am43xx.h |    1 +
> >  3 files changed, 77 insertions(+), 0 deletions(-)
> >
> gentle ping on this..

FYI at least I don't even have these patches in my inbox any longer,
so hopefully Benoit queues them.

Regards,

Tony
