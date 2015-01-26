From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/13] ARM: dts: omap3-gta04: Various DT fixes
Date: Mon, 26 Jan 2015 12:51:55 -0800
Message-ID: <20150126205155.GG28663@atomide.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek@goldelico.com> [150122 12:41]:
> This series contains fixes for gta04 devicetree. I collected patches
> from H. Nikolaus Schaller + NeilBrown and myself. Patches contains mostly fixes
> + adding new nodes and comments. All changes tested on gta04a4 board.
> 
> H. Nikolaus Schaller (5):
>   ARM: dts: omap3-gta04: Fix backup-battery charging in devicetree file.
>   ARM: dts: omap3-gta04: Fix audio node malformatting
>   ARM: dts: omap3-gta04: Enable mcbps2 necessary for audio
>   ARM: dts: omap3-gta04: Enable twl audio vibra support
>   ARM: dts: omap3-gta04: Enable power-off using twl4030
> 
> Marek Belisko (2):
>   ARM: dts: omap3-gta04: Fix a GPIO line for bma180 node
>   ARM: dts: omap3-gta04: Add ramp value for twl4030 audio
> 
> NeilBrown (6):
>   ARM: dts: omap3-gta04: add comments about gpios
>   ARM: dts: omap3-gta04: enable power-off for wifi card.
>   ARM: dts: omap3-gta04: add gyroscope
>   ARM: dts: omap3-gta04: only power DSS when necessary.
>   ARM: dts: omap3-gta04: uart4 is not connected, so mark it "disabled"

Applying all except the uart4 "disabled" patch into omap-for-v3.20/dt
thanks.

Tony

>   ARM: dts: omap3-gta04: Disable keypad
> 
>  arch/arm/boot/dts/omap3-gta04.dtsi | 54 +++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> -- 
> 1.9.1
> 
