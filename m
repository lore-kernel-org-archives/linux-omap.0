From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am5729: beaglebone-ai: adding device tree
Date: Thu, 21 Nov 2019 13:07:20 +0200
Message-ID: <41c73bc1-99ae-6797-5bb7-7acc0f6518c0@ti.com>
References: <20191120220559.18914-1-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120220559.18914-1-c-robey@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 21/11/2019 00:05, Caleb Robey wrote:
> From: Jason Kridner <jdk@ti.com>
> 
> BeagleBoard.org BeagleBone AI is an open source hardware single
> board computer based on the Texas Instruments AM5729 SoC featuring
> dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> signal processor (DSP), quad-core embedded vision engine (EVE),
> Arm Cortex-M4 processors, dual programmable realtime unit
> industrial control subsystems and more. The board features 1GB
> DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> headers.
> 
> For more information, refer to:
> https://beaglebone.ai
> 
> This patch introduces the BeagleBone AI device tree.
> 
> Note that the device use the "ti,tpd12s016" component which is
> software compatible with "ti,tpd12s015". Thus we only use the
> latter driver.

Ah. thanks. I see my comments resolved here.
no more comments to net part from my side.

> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> Signed-off-by: Caleb Robey <c-robey@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> 
> 
> ---
> 
> V2 Changes:
>    - dra7.dtsi was reintroduced and components that are only
>      not present in upstream linux dts were removed.
> 
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/am5729-beagleboneai.dts | 731 ++++++++++++++++++++++
>   arch/arm/boot/dts/dra7.dtsi               |   2 +-
>   3 files changed, 733 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 

[..]

-- 
Best regards,
grygorii
