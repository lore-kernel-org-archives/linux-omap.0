From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/5] arm: dts: complete dm816x device tree
Date: Thu, 12 Nov 2015 09:47:06 -0800
Message-ID: <20151112174706.GN3218@atomide.com>
References: <56449D1D.4030803@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56449D1D.4030803@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Neil Armstrong <narmstrong@baylibre.com> [151112 06:08]:
> In order to fix support for the dm816x platform, add missing bits in
> the dm816x dtsi and cleanup OCP.

Which ones are needed as fixes for the v4.4-rc kernel?

Regards,

Tony

> The last patch adds support for the omap4-hwspinlock.
> 
> v2: add ocp hwmod cleanup
> 
> Neil Armstrong (5):
>   arm: dts: add dm816x missing #mbox-cells
>   arm: dts: add dm816x missing spi DT dma handles
>   arm: dts: add dm816x pwm property to timers
>   arm: dts: remove dm816x invalid DT l3_main hwmod
>   arm: dts: Add omap4-hwspinlock support in dm816x
> 
>  arch/arm/boot/dts/dm816x.dtsi | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> -- 
> 1.9.1
