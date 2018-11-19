From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Fix comment block
Date: Mon, 19 Nov 2018 10:27:24 -0800
Message-ID: <20181119182724.GV53235@atomide.com>
References: <20181018004816.6627-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181018004816.6627-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:48]:
> When compiling the kernel with Clang, the following warning appears:
> 
> arch/arm/boot/dts/omap3-gta04.dtsi:385:56: warning: '/*' within block comment [-Wcomment]
>                         /* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)     /* mcbsp_clks.mcbsp_clks */

Applying into omap-for-v4.21/dt thanks.

Tony
