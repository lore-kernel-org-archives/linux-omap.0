From: Ash Charles <ashcharles@gmail.com>
Subject: Re: [PATCH] omap: Add devicetree for Gumstix Pepper board
Date: Tue, 10 Jun 2014 15:19:08 -0700
Message-ID: <CAK8F28kEi7TfnOCXk1S8bX8PpE_fQLHBFALg5GmtEk6iaTbf=Q@mail.gmail.com>
References: <1402087916-14857-1-git-send-email-ashcharles@gmail.com>
 <53972B57.6010802@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53972B57.6010802@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 10, 2014 at 8:59 AM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> It is not very common to add oneself as the maintainer of a single .dts
> file. I could only found the am335x-nano.dts with such a way of doing.
> Usually get_maintainer.pl will also take into account the commit author
> and properly handle this case.
Okay--I'll remove this.  Ironically, I was looking at the nano to make
sure I'd done everything I needed to ;-).
...
> For all the boards that I have seen, all the properties of a new node
> are declared at the same place, where you put some of them at the end. I
> have not a strong opinion on this, but I find it a bit more difficult to
> read.
...
> Splitting the pinmux is also unusual, but in this case I found it more
> readable.
My goal both by moving the properties and the pinmux was to separate
out chunks of functionality into discrete sections.  It makes it easy
to resolve an issue with a specific board feature (e.g. LEDs) or adapt
for a new board version as the pinmux and any node properties are
grouped together.
I recognize this is something of a personal bias though so I can
certainly re-organize if this is stylistically bad.
...
>> +&am33xx_pinmux {
>> +     accel_pins: pinmux_accel {
>> +             pinctrl-single,pins = <
>> +                     0x98 (PIN_INPUT_PULLUP | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
>
> The INT pin of the LIS33 chip seems to be push-pull, thus enabling the
> pullup on the SoC side will increase the current consumption when held down.
Good catch.
...
>> +&am33xx_pinmux {
>> +     audio_pins: pinmux_audio {
>> +             pinctrl-single,pins = <
>> +                     0x1AC (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_ahcklx.mcasp0_ahclkx */
>> +                     0x194 (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
>> +                     0x190 (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
>> +                     0x198 (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
>> +                     0x1A8 (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr1.mcasp0_axr1 */
>> +                     0x40 (PIN_OUTPUT_PULLUP | MUX_MODE7)    /* gpmc_a0.gpio1_16 */
>
> You already have an external pullup in your design, so this one seems
> superfluous.
You're correct.  Changed.
...
>> +/* Power */
>> +&vbat {
>> +     regulator-name = "vbat";
>> +     regulator-min-microvolt = <5000000>;
>> +     regulator-max-microvolt = <5000000>;
>> +     regulator-always-on;
removed regulator-always-on
>> +};
>> +
>> +&v3v3c_reg {
>> +     regulator-name = "v3v3c_reg";
>> +     regulator-min-microvolt = <3300000>;
>> +     regulator-max-microvolt = <3300000>;
>> +     vin-supply = <&vbat>;
>> +     regulator-always-on;
removed regulator-always-on
>> +};
>> +
>> +&vdd5_reg {
>> +     regulator-name = "vdd5_reg";
>> +     regulator-min-microvolt = <5000000>;
>> +     regulator-max-microvolt = <5000000>;
>> +     regulator-always-on;
removed regulator-always-on
>> +     vin-supply = <&vbat>;
>> +};
>> +
>> +/include/ "tps65217.dtsi"
>> +
>> +&tps {
>> +     backlight {
>> +             isel = <1>; /* ISET1 */
>> +             fdim = <200>; /* TPS65217_BL_FDIM_200HZ */
>> +             default-brightness = <80>;
>> +     };
>> +
>> +     regulators {
>> +             dcdc1_reg: regulator@0 {
>> +                     /* VDD_1V8 system supply */
>> +                     regulator-always-on;
removed regulator-always-on
>> +             };
>> +
>> +             dcdc2_reg: regulator@1 {
>> +                     /* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
>> +                     regulator-name = "vdd_core";
>> +                     regulator-min-microvolt = <925000>;
>> +                     regulator-max-microvolt = <1325000>;
>> +                     regulator-boot-on;
>> +                     regulator-always-on;
removed regulator-always-on
>> +             };
>> +
>> +             dcdc3_reg: regulator@2 {
>> +                     /* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
>> +                     regulator-name = "vdd_mpu";
>> +                     regulator-min-microvolt = <925000>;
>> +                     regulator-max-microvolt = <1150000>;
>> +                     regulator-boot-on;
>> +                     regulator-always-on;
removed regulator-always-on
>> +             };
>> +
>> +             ldo1_reg: regulator@3 {
>> +                     /* VRTC 1.8V always-on supply */
>> +                     regulator-always-on;
This is the backup supply shouldn't be switched off.
>> +             };
>> +
>> +             ldo2_reg: regulator@4 {
>> +                     /* 3.3V rail */
>> +                     regulator-always-on;
removed regulator-always-on
>> +             };
>> +
>> +             ldo3_reg: regulator@5 {
>> +                     /* VDD_3V3A 3.3V rail */
>> +                     regulator-always-on;
removed regulator-always-on
>> +                     regulator-min-microvolt = <3300000>;
>> +                     regulator-max-microvolt = <3300000>;
>> +             };
>> +
>> +             ldo4_reg: regulator@6 {
>> +                     /* VDD_3V3B 3.3V rail */
>> +                     regulator-always-on;
removed regulator-always-on
>> +             };
>
> Why are all the regulators always on? Most of them should be managed
> automatically if you have correct dependencies, shouldn't they?
A little cargo-cult I fear.  I've removed as noted above.
...
> You can use the key codes defined in <dt-bindings/input/input.h>.
Ah--cool.  Will do.
>
>> +             gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
>> +             gpio-key,wakeup;
>> +     };
>> +
>> +     button@1 {
>> +             label = "menu";
>> +             linux,code = <139>;
>
> KEY_MENU
>
>> +             gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
>> +             gpio-key,wakeup;
>> +     };
>> +
>> +     buttons@2 {
>> +             label = "power";
>> +             linux,code = <116>;
>
> KEY_POWER
>
>> +             gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
>> +             gpio-key,wakeup;
>> +     };
>> +};
>> +
>> +&am33xx_pinmux {
>> +     user_leds_pins: pinmux_user_leds {
>> +             pinctrl-single,pins = <
>> +                     0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)  /* gpmc_a4.gpio1_20 */
>> +                     0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)  /* gpmc_a5.gpio1_21 */
>
> Why enabling the pulldown on an output gpio? You will increase the power
> consumption when driving high.
These work fine as simple outputs.

Thanks for your careful review Florian.  Much appreciated.

--Ash
