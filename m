From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm: dts: add support for AM437x StarterKit
Date: Wed, 18 Jun 2014 16:54:05 -0500
Message-ID: <53A20A7D.3060508@ti.com>
References: <1403106200-777-1-git-send-email-balbi@ti.com> <1403106200-777-3-git-send-email-balbi@ti.com> <53A1BADD.7050309@ti.com> <20140618193113.GC4570@saruman.home>
Reply-To: nm-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140618193113.GC4570-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Josh Elliot <jelliott-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, r.sricharan-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 06/18/2014 02:31 PM, Felipe Balbi wrote:
> On Wed, Jun 18, 2014 at 11:14:21AM -0500, Nishanth Menon wrote:
>> On 06/18/2014 10:43 AM, Felipe Balbi wrote:
>>> Add support for TI's AM437x StarterKit Evaluation
>>> Module.
>>
>> is there a link for this platform?
>
> internal only

but will eventually be sold externally? I assume this is not an TI 
internal only board.
[...]
>>> +
>>> +	matrix_keypad: matrix_keypad@0 {
>>> +		compatible = "gpio-matrix-keypad";
>>
>> no pinctrl needed?
>
> pins are gpio by default

Might be good to explicitly configure it - no strong opinions though -> 
GPIOs are always good to pinctrl up esp if bootloader screws up at a 
later date.

[...]
>>> +&i2c0 {
>>> +        status = "okay";
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&i2c0_pins>;
>>
>> what speed are you running this on? -> also can you align these to 1
>
> 100kHz ?

Rule of thumb is to do the following:
MIN(MAX_FREQ(D1), MAX_FREQ(D2).... MAX_FREQ(Dn));
where D1..n are all the peripherals on this i2c bus.

>>> +	tps@24 {
>>> +		compatible = "ti,tps65218";
>>> +		reg = <0x24>;
>>> +		interrupt-parent = <&gic>;
>>> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>
>> is this muxed?
>
> there's no configuration for this. This pin is a single function.
>
>>> +		interrupt-controller;
>>> +		#interrupt-cells = <2>;
>>> +
>>> +		dcdc1: regulator-dcdc1 {
>>> +			compatible = "ti,tps65218-dcdc1";
>>> +			/* VDD_CORE limits min of OPP50 and max of OPP100 */
>>> +			regulator-name = "vdd_core";
>>> +			regulator-min-microvolt = <912000>;
>>> +			regulator-max-microvolt = <1144000>;
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>> +		};
>>> +
>>> +		dcdc2: regulator-dcdc2 {
>>> +			compatible = "ti,tps65218-dcdc2";
>>> +			/* VDD_MPU limits min of OPP50 and max of OPP_NITRO */
>>> +			regulator-name = "vdd_mpu";
>>> +			regulator-min-microvolt = <912000>;
>>> +			regulator-max-microvolt = <1378000>;
>>> +			regulator-boot-on;
>>> +			regulator-always-on;
>>> +		};
>>> +
>>> +		dcdc3: regulator-dcdc3 {
>>> +			compatible = "ti,tps65218-dcdc3";
>>> +			regulator-name = "vdds_ddr";
>> no voltage ?
>
> has no users in kernel. Also, it comes out with default, and correct,
> voltage.

Device tree is description of hardware, not just who uses what in OS of 
interest.

you might consider u-boot to use the same device tree at a later date 
and having complete details about the hardware is always the norm.

I suggest setting the voltage here to be complete even if there are no 
current users.

>>> +	edt-ft5306@38 {
>>> +		status = "okay";
>>> +		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&edt_ft5306_ts_pins>;
>>> +		reg = <0x38>;
>>> +		interrupt-parent = <&gpio0>;
>>> +		interrupts = <31 0>;
>>> +
>>> +		wake-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>
>> why wake-gpios? we should be using pinctrl with interrupt-extended to
>> do wakeup sequence, no?
>
> sure, can you patch the edt driver ? I'll fix the DTS after that gets
> merged

If you really want to go down that road, so you could probably help 
review the pinctrl patches I posted to enable pinctrl wakeup[1]?

Come on, as of today, there is no ability to suspend AM437x without 
doing [1], let alone talk about wakeup gpio vs interrupt-extended. and 
do we really want to wakeup from suspend when touch screen is touched?

Do you expect wake-gpio to work even after doing interrupt based 
solution? I am no edt driver expert... maybe you can help me here.

>>> +&mmc1 {
>>> +	status = "okay";
>>> +	vmmc-supply = <&dcdc4>;
>>> +	bus-width = <4>;
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&mmc1_pins>;
>>
>> just for style, wonder if moving the pinctrl just after status is better?
>
> why ? makes no difference.

it does not - I agree, except, when you look at all other nodes:
status="okay"
pinctrl
other things..

it is just a symmetry thing, I guess..

>
>>> +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
>>> +};
>>> +
>>> +&usb2_phy1 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb1 {
>>> +	dr_mode = "peripheral";
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb2_phy2 {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&usb2 {
>>> +	dr_mode = "host";
>>> +	status = "okay";
>>> +};
>> none of the above need pinctrl? no regulator supplies?
>
> pins in default states, drivers don't use regulators.

USB works without a supply? even a fixed voltage supply? that is weird.

[..]

[1] http://marc.info/?l=devicetree&m=140301966510748&w=2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
