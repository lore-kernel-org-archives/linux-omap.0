From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Add USB nodes for am43xx epos and gp evm
Date: Wed, 5 Mar 2014 11:42:19 -0800
Message-ID: <20140305194219.GD7599@atomide.com>
References: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393854834-23810-1-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, anatol.pomozov@gmail.com, gregkh@linuxfoundation.org, balbi@ti.com, rogerq@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

* George Cherian <george.cherian@ti.com> [140303 05:58]:
> The patch series adds USB dt nodes for am43xx epos and gp evm
> 
> Boot tested with  Benoit's for_3.15 + following patches
> 
> https://patchwork.kernel.org/patch/3600821/
> https://patchwork.kernel.org/patch/3600831/
> https://patchwork.kernel.org/patch/3600851/
> https://patchwork.kernel.org/patch/3600841/

Roger, care to look through these and ack if OK?

Regards,

Tony

> George Cherian (5):
>   ARM: dts: am43xx clock data
>   ARM: dts: AM4372: Add USB nodes
>   ARM: dts: am437x-gp-evm: Enable USB
>   ARM: dts: am43x-epos-evm: Enable USB
>   doc: Add "ti,am437x-dwc3" comaptible for dwc3 glue
> 
>  Documentation/devicetree/bindings/usb/omap-usb.txt |  4 +-
>  arch/arm/boot/dts/am4372.dtsi                      | 99 ++++++++++++++++++++++
>  arch/arm/boot/dts/am437x-gp-evm.dts                | 44 ++++++++++
>  arch/arm/boot/dts/am43x-epos-evm.dts               | 44 ++++++++++
>  arch/arm/boot/dts/am43xx-clocks.dtsi               | 17 ++++
>  5 files changed, 207 insertions(+), 1 deletion(-)
> 
> -- 
> 1.8.3.1
> 
