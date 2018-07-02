From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/5] ARM: dts: dra7/am7xx: USB fixes and enhancements
Date: Mon, 2 Jul 2018 11:56:59 +0300
Message-ID: <e6e22046-e784-9cf6-3882-5a7f6ac66f2c@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 29/05/18 12:00, Roger Quadros wrote:
> Hi Tony,
> 
> These are some fixes and enhancements for USB ports on dra7 and am57xx-idk EVMs.
> If OK, please queue these for v4.18. Thanks.
> 

Gentle reminder.
Could you please pick the first patch for 2018-rc, and the rest for -next. Thanks.

> Roger Quadros (5):
>   ARM: dts: dra7: Disable metastability workaround for USB2
>   ARM: dts: am57xx-idk: Enable dual role for USB2 port
>   ARM: dts: dra7-evm: Add extcon to USB2 port
>   ARM: dts: dra71-evm: Add VBUS GPIO to USB1/USB2 extcon
>   ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon
> 
>  arch/arm/boot/dts/am571x-idk.dts         |  4 ----
>  arch/arm/boot/dts/am572x-idk-common.dtsi |  4 ----
>  arch/arm/boot/dts/am57xx-idk-common.dtsi |  7 ++++++-
>  arch/arm/boot/dts/dra7-evm-common.dtsi   | 10 ++++++++++
>  arch/arm/boot/dts/dra7-evm.dts           |  9 ---------
>  arch/arm/boot/dts/dra7.dtsi              |  2 +-
>  arch/arm/boot/dts/dra71-evm.dts          |  8 ++++++++
>  arch/arm/boot/dts/dra72-evm-common.dtsi  |  1 +
>  arch/arm/boot/dts/dra76-evm.dts          |  8 ++++++++
>  9 files changed, 34 insertions(+), 19 deletions(-)
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
