From: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 0/6] ARM: OMAP2+: dts: cm-t335: initial support
Date: Wed, 11 Nov 2015 19:32:17 +0200
Message-ID: <56437BA1.8030807@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Gentle ping

On 27/10/15 14:14, Uri Mashiach wrote:
> Add basic support for CompuLab cm-t335 module based on AM335X SoC.
>
> CM-T335 is a tiny computer-on-module (CoM) / system-on-module (SoM)
> The module is built around the Texas Instruments Sitara AM3352/4
> system-on-chip.
>
> The CPU is supplemented with up-to 512MB DDR3 and up-to 1GB of on-board
> NAND storage, WiFi connected to SPI, Bluetooth, Analog audio, Gigabit
> Ethernet, CAN bus.
>
> Ilya Ledvich (6):
>    ARM: OMAP2+: dts: cm-t335: add initial support
>    ARM: OMAP2+: dts: cm-t335: add basic support for I2C
>    ARM: OMAP2+: dts: cm-t335: add support for NAND flash
>    ARM: OMAP2+: dts: cm-t335: add support for MMC
>    ARM: OMAP2+: dts: cm-t335: add support for network device
>    ARM: OMAP2+: dts: cm-t335: add support for PWM backlight
>
>   .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>   arch/arm/boot/dts/Makefile                         |   7 +-
>   arch/arm/boot/dts/am335x-cm-t335.dts               | 347 +++++++++++++++++++++
>   3 files changed, 354 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
