From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/3] Add more device nodes for am43x gp evm.
Date: Thu, 5 Dec 2013 15:18:41 +0530
Message-ID: <52A04BF9.5030604@ti.com>
References: <1385537479-6959-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab3LEJsu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Dec 2013 04:48:50 -0500
In-Reply-To: <1385537479-6959-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>, bcousson@baylibre.com
Cc: rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, devicetree@vger.kernel.org, tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com

Hi Benoit,
On Wednesday 27 November 2013 01:01 PM, Sourav Poddar wrote:
> The patch series adds support for enabling gpio, pwm backlight and
> matrix gpio keys on am43x-gp-evm.
>
> Done on top of 3.13-rc1 + tero clock series(1) + Afzal's basic gp support(2).
>
> [1]: https://patchwork.kernel.org/patch/3009541/
> [2]: https://patchwork.kernel.org/patch/3171761/
>
> Tested on am43x-gp-evm.
>
> There is a some bug while using regulators through backlight
> driver on 3.13-rc1. So, tested pwm part with this patch[3].
>
> [3]: http://www.spinics.net/lists/arm-kernel/msg288215.html
>
> Sourav Poddar (3):
>    arm: dts: am437x-gp-evm: Enable gpio.
>    ARM: dts: am43x-gp-evm: Add matrix gpio keys.
>    ARM: dts: am437x-gp-evm: Add pwm backlight support.
>
>   arch/arm/boot/dts/am437x-gp-evm.dts |   53 +++++++++++++++++++++++++++++++++++
>   1 files changed, 53 insertions(+), 0 deletions(-)
>
Gentle pIng on this.
