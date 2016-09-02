From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: Introduce support for rev BeagleBoard-X15
 B1
Date: Fri, 2 Sep 2016 04:14:52 -0500
Message-ID: <d4234395-a53f-4482-b7d1-c74e90cf8351@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160902090600.27262-1-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/02/2016 04:05 AM, Nishanth Menon wrote:
>
> Hi,
>
> Please find the series to cleanup and support Production version of
> Beagleboard-X15 rev B1 support.
>
> More  details can be found at https://github.com/beagleboard/beagleboard-x15
>
> Bootlog on B1: http://pastebin.ubuntu.com/23123408/ (sd and hdmi hpd tested)
>

Forgot to add:
this series is based on:
https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.9/dt

Also, the upstream u-boot support can only be added once we know what 
the dt name should be - basically pending dts acceptance..

> Nishanth Menon (2):
>   ARM: dts: am57xx-beagle-x15: Remove pinmux configurations
>   ARM: dts: am57xx-beagle-x15: Add support for rev B1
>
>  arch/arm/boot/dts/Makefile                         |   1 +
>  ...eagle-x15.dts => am57xx-beagle-x15-common.dtsi} | 230 +-----
>  arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |  24 +
>  arch/arm/boot/dts/am57xx-beagle-x15.dts            | 812 +--------------------
>  4 files changed, 34 insertions(+), 1033 deletions(-)
>  copy arch/arm/boot/dts/{am57xx-beagle-x15.dts => am57xx-beagle-x15-common.dtsi} (60%)
>  create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
