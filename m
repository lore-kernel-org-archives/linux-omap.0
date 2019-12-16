From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3] ARM: bcm: Add missing sentinel to bcm2711_compat[]
Date: Sun, 15 Dec 2019 19:32:30 -0800
Message-ID: <20191216033230.26652-1-f.fainelli@gmail.com>
References: <b8f2060dacd4c4f27e0e1791cb12462ce740927d.1576396141.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8f2060dacd4c4f27e0e1791cb12462ce740927d.1576396141.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com, "H. Nikolaus Schaller" <hns@goldelico.com>, Stefan Wahren <wahrenst@gmx.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux@armlinux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, arm-soc <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On Sun, 15 Dec 2019 08:49:02 +0100, "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> commit 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")
> 
> breaks boot of many other platforms (e.g. OMAP or i.MX6) if
> CONFIG_ARCH_BCM2835 is enabled in addition to some multiplatform
> config (e.g. omap2plus_defconfig). The symptom is that the OMAP
> based board does not show any activity beyond "Starting Kernel ..."
> even with earlycon.
> 
> Reverting the mentioned commit makes it work again.
> 
> The real fix is to add the missing NULL sentinel to the
> bcm2711_compat[] variable-length array.
> 
> Fixes: 781fa0a95424 ("ARM: bcm: Add support for BCM2711 SoC")
> Acked-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---

Applied to soc/fixes, thanks!
--
Florian
