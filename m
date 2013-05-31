From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v8] ARM: dts: omap4-panda: Update the LED support for
 the panda DTS
Date: Fri, 31 May 2013 10:19:44 -0500
Message-ID: <51A8BF90.4060509@ti.com>
References: <1370011682-20675-1-git-send-email-dmurphy@ti.com> <CABxcv=mCh38XgFoRSrZ8BK5U5EFDb-1Fb70FoLyNqb0V3WQm-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=mCh38XgFoRSrZ8BK5U5EFDb-1Fb70FoLyNqb0V3WQm-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/31/2013 10:05 AM, Javier Martinez Canillas wrote:
> On Fri, May 31, 2013 at 4:48 PM, Dan Murphy <dmurphy@ti.com> wrote:
>> The GPIO for LED D1 on the omap4-panda a1-a3 rev and the omap4-panda-es
>> are different.
>>
>> A1-A3 = gpio_wk7
>> ES = gpio_110
>>
>> There is no change to LED D2
>>
>> Abstract away the pinmux and the LED definitions for the two boards into
>> the respective DTS files.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>> v8 - Rebase to latest and use pinctrl macros - https://patchwork.kernel.org/patch/2629351/
>> v7 - Update headline to add spaces - https://patchwork.kernel.org/patch/2583661/
>> v6 - Review comments updated - https://patchwork.kernel.org/patch/2582771/
>> v5 - Provide pincrtl phandle to the gpio-led driver - https://patchwork.kernel.org/patch/2573981/
>>
>>  arch/arm/boot/dts/omap4-panda-common.dtsi |   16 +++++++++++++++-
>>  arch/arm/boot/dts/omap4-panda-es.dts      |   28 ++++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index d5d144a..523a800 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -16,8 +16,13 @@
>>                 reg = <0x80000000 0x40000000>; /* 1 GB */
>>         };
>>
>> -       leds {
>> +       leds: leds {
>>                 compatible = "gpio-leds";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <
>> +                       &led_wkgpio_pins
>> +               >;
>> +
>>                 heartbeat {
>>                         label = "pandaboard::status1";
>>                         gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>> @@ -157,6 +162,15 @@
>>         };
>>  };
>>
>> +&omap4_pmx_wkup {
>> +       led_wkgpio_pins: pinmux_leds_wkpins {
>> +               pinctrl-single,pins = <
>> +                       0x1a (PIN_OUTPUT | MUX_MODE3)   /* gpio_wk7 OUTPUT | MODE 3 */
>> +                       0x1c (PIN_OUTPUT | MUX_MODE3)   /* gpio_wk8 OUTPUT | MODE 3 */
> Hello Dan,
>
> The OUTPUT | MODE 3 in the comments were added so people shouldn't
> have to look at the TRM to find what each constant number meant. But
> now using the macros this is not needed anymore, so I don't think is
> necessary to keep that on the comments.
>
> Best regards,
> Javier
Yes you are correct sending update to remove the comments

-- 
------------------
Dan Murphy
