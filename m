From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/1] ARM: dts: am5729: beaglebone-ai: enable board
Date: Thu, 21 Nov 2019 13:05:02 +0200
Message-ID: <e831422f-66b7-32e1-5b44-f7ca287abc4b@ti.com>
References: <20191119202850.18149-1-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119202850.18149-1-c-robey@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 19/11/2019 22:28, Caleb Robey wrote:
> The following patch adds the device tree file for BeagleBone AI


Please, add version info in subjects and
provide change log in cover.


>   
> Caleb Robey (1):
>    ARM: dts: am5729: beaglebone-ai: adding device tree
> 
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/am5729-beagleboneai.dts | 782 ++++++++++++++++++++++
>   2 files changed, 783 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 

-- 
Best regards,
grygorii
