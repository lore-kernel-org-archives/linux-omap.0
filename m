From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: am335x: Add initial support for ICEv2
 board
Date: Wed, 23 Mar 2016 11:46:20 +0200
Message-ID: <56F265EC.5050208@ti.com>
References: <1458704054-18152-1-git-send-email-lokeshvutla@ti.com>
 <1458704054-18152-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458704054-18152-2-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/23/2016 05:34 AM, Lokesh Vutla wrote:
> TI's Industrial Communication Engine EVM is a low cost hardware mainly
> developed for industrial communication type applications using serial
> or Ethernet based interfaces. This platform features TI's AM3359 with
> 800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
> 8MB NOR Flash, mmc, usb, can, dual Ethernet ports.
>
> For more information, look at HW user guide[1], Data manual[2].
>
> Just add basic support for the moment.
>
> [1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
> [2] http://www.ti.com/lit/ds/symlink/am3359.pdf
>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

> ---
> Changes since v1:
> - Add separate nodes for gpio leds and tpic2810 leds.
>
>   .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>   arch/arm/boot/dts/Makefile                         |   1 +
>   arch/arm/boot/dts/am335x-icev2.dts                 | 306 +++++++++++++++++++++
>   3 files changed, 310 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am335x-icev2.dts
>

[...]

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
