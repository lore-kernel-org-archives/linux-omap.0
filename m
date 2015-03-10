From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
Date: Tue, 10 Mar 2015 12:25:09 -0500
Message-ID: <54FF28F5.4040707@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com>
 <1425427237-11511-2-git-send-email-nm@ti.com>
 <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
 <20150310153321.GO5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150310153321.GO5264@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/10/2015 10:33 AM, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [150310 03:39]:
>> On Wed, Mar 4, 2015 at 1:00 AM, Nishanth Menon <nm@ti.com> wrote:
>>
>>> +Configuration definition follows similar model as the pinctrl-single:
>>> +The groups of pin configuration are defined under "pinctrl-single,pins"
>>> +
>>> +&dra7_iodelay_core {
>>> +       mmc2_iodelay_3v3_conf: mmc2_iodelay_3v3_conf {
>>> +               pinctrl-single,pins = <
>>> +                       0x18c (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A19_IN */
>>> +                       0x1a4 (A_DELAY(265) | G_DELAY(360))     /* CFG_GPMC_A20_IN */
>>> +                       0x1b0 (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A21_IN */
>>> +                       0x1bc (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A22_IN */
>>> +                       0x1c8 (A_DELAY(287) | G_DELAY(420))     /* CFG_GPMC_A23_IN */
>>> +                       0x1d4 (A_DELAY(144) | G_DELAY(240))     /* CFG_GPMC_A24_IN */
>>> +                       0x1e0 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_A25_IN */
>>> +                       0x1ec (A_DELAY(120) | G_DELAY(0))       /* CFG_GPMC_A26_IN */
>>> +                       0x1f8 (A_DELAY(120) | G_DELAY(180))     /* CFG_GPMC_A27_IN */
>>> +                       0x360 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_CS1_IN */
>>> +               >;
>>> +       };
>>> +};
>>
>> But wait.
>>
>> The promise when we merged pinctrl-single was that this driver was to be used
>> when the system had a one-register-per-pin layout and it was easy to do device
>> trees based on that.
>>
>> We were very reluctant to accept that even though we didn't even have the
>> generic pin control bindings in place, the argument being that the driver
>> should know the detailed register layout, it should not be described in the
>> device tree. We eventually caved in and accepted it as an exception.
> 
> Hey let's get few things straight here. There's nothing stopping the
> driver from knowing a detailed register layout with the pinctrl-single
> binding. This can be very easily done based on the compatible flag and
> match data as needed and check the values provided.
> 
> And let's also recap the reasons for the pinctrl-single binding. The
> the main reason for the pinctrl-single binding is to avoid mapping
> individual register bits to device tree compatible string properties.
> 
> Imagine doing that for hundreds of similar registers. Believe me, I tried
> using device tree properties initially and it just sucked big time. For
> larger amounts of dts data, it's best to stick to numeric values and
> phandles in the device tree data and rely on the preprocessor for
> getting the values right.
> 
> Finally, we don't want to build databases into the kernel drivers for
> every SoC. We certainly have plenty fo those already.
>  
>> Since this pin controller is not using pinctrl-single it does not enjoy that
>> privilege and you need to explain why this pin controller cannot use the
>> generic bindings like so many other pin controllers have since started
>> to do. ("It is in the same SoC" is not an acceptable argument.)
>>
>> What is wrong with this:
>> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> 
> Nishanth, care to explain your reasons for using pinctrl-single binding
> here vs the generic binding? Is the amount of string parsing with the
> data an issue here?

Wrong option chosen, I suppose :( - alright, lets discuss the alternative.

>  
>> We can add generic delay bindings to the list, it even seems like
>> a good idea to do so, as it is likely something that will come up in
>> other hardware and will be needed for ACPI etc going forward.
> 
> We certainly need to make setting delays (with values) generic, no
> doubt about that.
> 
> If the large amount of data is not an issue here, we could maybe set
> each iodelay register as a separate device? Then the binding could
> be just along the interrupts-extended type binding:
> 
> foo = <&bar 0x18c A_DELAY(0) G_DELAY(120)>;
> 
> Where the 0x18c is the instance offset of the register within the
> ti,dra7-iodelay compatible controller.

if mmc2_pins_default point at pins for mmc pin configuration for
control_core (pinctrl-single), are you proposing the following?

 mmc2_pins_default: mmc2_pins_default {
         pinctrl-single,pins = <
                 0x9c (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a23.mmc2_clk */
                 0xb0 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_cs1.mmc2_cmd */
                 0xa0 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a24.mmc2_dat0 */
                 0xa4 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a25.mmc2_dat1 */
                 0xa8 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a26.mmc2_dat2 */
                 0xac (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a27.mmc2_dat3 */
                 0x8c (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a19.mmc2_dat4 */
                 0x90 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a20.mmc2_dat5 */
                 0x94 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a21.mmc2_dat6 */
                 0x98 (PIN_INPUT_PULLUP | MANUAL_MODE | MUX_MODE1) /*
gpmc_a22.mmc2_dat7 */
         >;
 };

&mmc2 {
...
 pinctrl-1 =
 	&mmc2_pins_default,	/* points to mmc control core pins */
 	<&iodelay 0x18c A_DELAY(0) | G_DELAY(120)>,       /* CFG_GPMC_A19_IN */
 	<&iodelay 0x1a4 A_DELAY(265) | G_DELAY(360)>,     /* CFG_GPMC_A20_IN */
 	<&iodelay 0x1b0 A_DELAY(0) | G_DELAY(120)>,       /* CFG_GPMC_A21_IN */
 	<&iodelay 0x1bc A_DELAY(0) | G_DELAY(120)>,       /* CFG_GPMC_A22_IN */
 	<&iodelay 0x1c8 A_DELAY(287) | G_DELAY(420)>,     /* CFG_GPMC_A23_IN */
 	<&iodelay 0x1d4 A_DELAY(144) | G_DELAY(240)>,     /* CFG_GPMC_A24_IN */
 	<&iodelay 0x1e0 A_DELAY(0) | G_DELAY(0)>,         /* CFG_GPMC_A25_IN */
 	<&iodelay 0x1ec A_DELAY(120) | G_DELAY(0)>,       /* CFG_GPMC_A26_IN */
 	<&iodelay 0x1f8 A_DELAY(120) | G_DELAY(180)>,     /* CFG_GPMC_A27_IN */
 	<&iodelay 0x360 A_DELAY(0) | G_DELAY(0)>;         /* CFG_GPMC_CS1_IN */

I have to check if we are capable of parsing that. but if that is the
approach chosen, I suppose we might be able to figure something, I
suppose..

-- 
Regards,
Nishanth Menon
