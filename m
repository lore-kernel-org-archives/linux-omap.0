From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: Optimize soc_is calls
Date: Mon, 14 Sep 2015 14:24:08 +0530
Message-ID: <55F68B30.8050304@ti.com>
References: <1441609528-20344-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441609528-20344-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Monday 07 September 2015 12:35 PM, Keerthy wrote:
> The series implements optimizing soc_is calls for DRA7 and AM43XX
> family of SoCs. Originally the soc_is calls for DRA7 involved parsing
> device tree nodes and some repetitive string comparisons. Optimizing
> to store the result and use the result in the subsequent calls.
>
> The series is boot tested on am437x-gp-evm, dra7-evm, dra72-evm.


A gentle ping on this series. This series would be good to include rtc 
hwmods selectively for non-epos evms. Let me know if you have any 
comments on this.

-Keerthy

>
> Keerthy (3):
>    ARM: OMAP2: DRA7: Modify optimize string comparisons in soc_is calls
>    ARM: dts: AM43x-epos-evm: Add AM438x compatible string for epos
>    ARM: OMAP2: AM43XX: Modify optimize string comparisons in soc_is calls
>
>   .../devicetree/bindings/arm/omap/omap.txt          |  5 +++-
>   arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
>   arch/arm/mach-omap2/id.c                           | 28 ++++++++++++++++++++++
>   arch/arm/mach-omap2/soc.h                          | 25 +++++++++++++++----
>   4 files changed, 53 insertions(+), 7 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
