From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 01/23] ARM: am335x: Add missing memory node in sl50 board
Date: Wed, 31 Aug 2016 15:09:17 +0200
Message-ID: <CAFqH_51F-1n3mp8_Ags4LSCR5DX10vDVEvLCXpnWvHY=Mi0cTA@mail.gmail.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com> <1472639737-17586-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472639737-17586-2-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-omap@vger.kernel.org

2016-08-31 12:35 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> The skeleton.dtsi file was removed in ARM64 for different reasons as
> explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").
>
> These also applies to ARM and it will also allow to get rid of the
> following DTC warnings in the future:
>
> "Node /memory has a reg or ranges property, but no unit name"
>
> But the sl50 board doesn't have a, so removing the  skeleton.dtsi
> inclusion from am33xx.dtsi will cause a change in the compiled DTB.
>
> The board has 512 MiB of RAM and its starting address is 0x80000000,
> so add a proper memory device node in the DTS.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  arch/arm/boot/dts/am335x-sl50.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
> index f802adb23ff9..e3be7a6bf8f1 100644
> --- a/arch/arm/boot/dts/am335x-sl50.dts
> +++ b/arch/arm/boot/dts/am335x-sl50.dts
> @@ -19,6 +19,11 @@
>                 };
>         };
>
> +       memory {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>; /* 512 MB */
> +       };
> +
>         chosen {
>                 stdout-path = &uart0;
>         };
> --
> 2.7.4
>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric
