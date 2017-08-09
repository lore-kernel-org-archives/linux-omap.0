From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: dts: omap: workarounds for Ethernet PHY strap
 on DRA71 and DRA72 EVMs
Date: Wed, 9 Aug 2017 17:26:37 -0500
Message-ID: <ca0d0615-d813-d00b-e853-25df9a5c49b6@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1502284400.git.nsekhar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 08/09/2017 09:02 AM, Sekhar Nori wrote:
> Hi Tony,
> 
> Here are some patches to overcome incorrect Ethernet PHY strap settings
> on DRA72x EVM Rev C and DRA71 EVM. Both of these boards use TI's DP83867
> PHY.
> 
> The incorrect PHY strap settings cause a voilation of PHY specification
> and need to be worked around in software as documented in the commit
> messages. But there is no known issue that these patches fix.
> 
> Changes from v1:
> - Add Grygorii's reviewed-by to 3/3
> - Rebase on latest mainline master
> 
> Sekhar Nori (3):
>    ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL pin strap
>    ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin
>      strap
>    ARM: omap2plus_defconfig: enable DP83867 phy driver
> 
>   arch/arm/boot/dts/dra71-evm.dts      | 2 ++
>   arch/arm/boot/dts/dra72-evm-revc.dts | 3 +++
>   arch/arm/configs/omap2plus_defconfig | 1 +
>   3 files changed, 6 insertions(+)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
