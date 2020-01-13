From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: Move am33xx and am43xx mmc nodes to sdhci-omap
 driver
Date: Mon, 13 Jan 2020 10:44:44 -0800
Message-ID: <20200113184444.GO5885@atomide.com>
References: <20200106111517.15158-1-faiz_abbas@ti.com>
 <ab908007-fd7d-9dd5-c822-f4058c793d7d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab908007-fd7d-9dd5-c822-f4058c793d7d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, bcousson@baylibre.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Faiz Abbas <faiz_abbas@ti.com> [200109 13:57]:
> Hi,
> 
> On 06/01/20 4:45 pm, Faiz Abbas wrote:
> > Move mmc nodes to be compatible with the sdhci-omap driver. The following
> > modifications are required for omap_hsmmc specific properties:
> > 
> > ti,non-removable: convert to the generic mmc non-removable
> > ti,needs-special-reset:  co-opted into the sdhci-omap driver
> > ti,dual-volt: removed. Legacy property not used in am335x or am43xx
> > ti,needs-special-hs-handling: removed. Legacy property not used in am335x or am43xx
> > 
> > Also since the sdhci-omap driver does not support runtime PM, explicitly
> > disable the mmc3 instance in the dtsi.
> > 
> > Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> > ---
> > 
> > Driver modifications have been posted separately:
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=224053
> > 
> > Tested on: am335x-evm, am335x-boneblack, am335x-sk, am335x-bone, am437x-idk,
> > am43xx-gp-evm, am43xx-epos-evm.
> > 
> > I need some help with testing all other am335x variants and SDIO cards.
> > 
> > Here's a branch for testing: https://github.com/faizinator/linux/tree/sdhci-omap_v4_2
> > 
> 
> Tony, can you help test some of these boards?

I have your branch above a quick boot test on bbb and am437x-idk and both
detected MMC just fine :)

I guess up to Dave and Keerthy to check if this conversion can be done
without missing runtime PM support, any comments?

I guess it should not be hard implement runtime PM support for
autosuspend in sdhci-omap.c?

Regards,

Tony
