From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/4] omap: Fix broken pbias device creation
Date: Fri, 7 Aug 2015 19:55:43 +0530
Message-ID: <55C4BFE7.2070302@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>	<55B89590.6000109@ti.com>	<20150805100009.GY16878@atomide.com> <CALeDE9OBjESdkXhkAEVj1L-XKJ1yoFg8rkHvcJ_Uj_RXOC-yUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALeDE9OBjESdkXhkAEVj1L-XKJ1yoFg8rkHvcJ_Uj_RXOC-yUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Friday 07 August 2015 05:18 PM, Peter Robinson wrote:
> On Wed, Aug 5, 2015 at 11:00 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [150729 02:01]:
>>> On 07/27/2015 03:16 PM, Kishon Vijay Abraham I wrote:
>>>> pbias device creation got broken once SCM cleanup got merged.
>>>> This patch series re-enables device creation by adding
>>>> "simple-bus" in the compatible property of the syscon
>>>> dt node.
>>>>
>>>> validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
>>>> boards.
>>>>
>>>> Kishon Vijay Abraham I (4):
>>>>   ARM: dts: omap24xx: Fix broken pbias device creation
>>>>   ARM: dts: OMAP4: Fix broken pbias device creation
>>>>   ARM: dts: OMAP5: Fix broken pbias device creation
>>>>   ARM: dts: dra7: Fix broken pbias device creation
>>>>
>>>>  arch/arm/boot/dts/dra7.dtsi     |    2 +-
>>>>  arch/arm/boot/dts/omap2430.dtsi |    3 ++-
>>>>  arch/arm/boot/dts/omap4.dtsi    |    3 ++-
>>>>  arch/arm/boot/dts/omap5.dtsi    |    3 ++-
>>>>  4 files changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>
>>> For dra7-evm:
>>> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Applying all into omap-for-v4.2fixes-v2 thanks.
> 
> Do we need the same for am33xx.dtsi too given commit e3bc5358e097 ?

PBIAS is not present in am33xx.

Thanks
Kishon
