From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP4: crypto support
Date: Tue, 13 Jun 2017 16:49:18 +0300
Message-ID: <ab778bfd-9397-4cb0-0741-557da57bba83@ti.com>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/06/17 12:28, Sebastian Reichel wrote:
> Hi,
> 
> This adds crypto support for OMAP4, which was missing for some reason.
> This fixes error about missing hwmod on Droid 4. IP-Cores for AES and
> DES are working according to selftest.
> 
> Changes since PATCHv1:
>   * remove patch adding des_fck to DT
>   * add patch removing aes[12]_fck from DT
>   * add patch renaming hwmod aes to aes1 in DT
>   * update hwmod patches according to feedback from Tero
>   * add patch for aes2 hwmod
> 
> -- Sebastian

I just posted a few extra patches on top of this series, for adding the 
missing dts data for aes2 and adding sham accelerator also. The dts data 
should be applied first if you want to avoid any issues with hwmod core 
complaining about missing DT data, so the sequencing of this series and 
mine need to be done carefully.

The patches themselves in this series look fine now, so:

Acked-by: Tero Kristo <t-kristo@ti.com>

> 
> Sebastian Reichel (5):
>    ARM: dts: omap4: Fix aes entry
>    ARM: dts: omap4.dtsi: remove aes[12]_fck
>    ARM: OMAP4: hwmod data: add aes1
>    ARM: OMAP4: hwmod data: add aes2
>    ARM: OMAP4: hwmod data: add des
> 
>   arch/arm/boot/dts/omap4.dtsi               |   4 +-
>   arch/arm/boot/dts/omap44xx-clocks.dtsi     |  16 -----
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 100 +++++++++++++++++++++++++++++
>   3 files changed, 102 insertions(+), 18 deletions(-)
> 
