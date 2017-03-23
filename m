From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/4] ARM: dm8168-evm: add SATA support
Date: Thu, 23 Mar 2017 14:00:05 -0700
Message-ID: <20170323210003.GR10760@atomide.com>
References: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489490055-2318-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170314 04:16]:
> This series implements support for the on-board SATA controller
> on the dm8168-evm board.
> 
> The first patch adds the clock domain and hwmod entries for the
> SATA module.
> 
> The second patch models the external reference clock used by SATA.
> 
> The third adds the SATA node to the SoC's device tree.
> 
> The fourth enables the SATA driver by default in omap2plus_defconfig.
> 
> Tested together with the series implementing the driver for
> ahci-dm816 on a DM8168-EVM board.
> 
> v1 -> v2:
>   PATCH 1/4:
>     - removed the unused define from cm81xx.h
>   PATCH 3/4:
>     - fixed the size of the mapped register region
> 
> Bartosz Golaszewski (3):
>   ARM: dts: dm8168-evm: add the external reference clock for SATA
>   ARM: dts: dm8168-evm: add SATA node
>   ARM: omap2plus_defconfig: enable ahci-dm816 module
> 
> Kevin Hilman (1):
>   ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

Applying all for for v4.12 into soc, dts-v2 and defconfig
branches.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
