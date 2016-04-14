From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: Add support for dra72-evm rev C (SR2.0)
Date: Thu, 14 Apr 2016 13:44:53 -0700
Message-ID: <20160414204452.GO5995@atomide.com>
References: <1460655958-4639-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460655958-4639-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160414 10:47]:
> DRA72-EVM now has an upgrade to Rev C with SR2.0 silicon. As part of
> this change, a few updates were factored in that were software
> incompatible with previous board in few areas:
> - We now use DP83867 ethernet phy instead of older DP838865 which fails
>   in certain use cases.
> - Two Ethernet ports now instead of the single one in rev B.
> - polarities changed for certain pcf gpios
> - Due to SoC phy current requirements, VDDA supplies are split between
>  ldo3 and ldo2 (ldo2 was previously unused). NOTE: DSS (VDDA_VIDEO) is
>  still supplied by ldo5, HDMI is now supplied by LDO2 instead of using
>  LDO3.
> 
> NOTE: It does not make much sense to spin off a new board compatible
> flag since there is no real benefit for the same.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Updates in v2:
>  - minor fixes + rebase to
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>   omap-for-v4.7/dt   4cb53a2308a9 ARM: dts: omap3-beagle: Provide NAND ready pin

Thanks for updating this, applying into omap-for-v4.7/dt.

Tony
