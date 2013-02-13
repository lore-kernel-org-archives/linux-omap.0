From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] arm: dts: omap4-panda: Add I2c pinctrl data
Date: Wed, 13 Feb 2013 10:06:51 -0600
Message-ID: <511BBA1B.9050501@ti.com>
References: <1360747710-1532-1-git-send-email-sourav.poddar@ti.com> <511BB7CE.1020505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <511BB7CE.1020505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 02/13/2013 09:57 AM, Jon Hunter wrote:
> 
> On 02/13/2013 03:28 AM, Sourav Poddar wrote:
>> Booting 3.8-rc6 on omap4 panda results in the following error
>>
>> [    0.444427] omap_i2c 48070000.i2c: did not get pins for i2c error: -19
>> [    0.445770] omap_i2c 48070000.i2c: bus 0 rev0.11 at 400 kHz
>> [    0.473937] omap_i2c 48072000.i2c: did not get pins for i2c error: -19
>> [    0.474670] omap_i2c 48072000.i2c: bus 1 rev0.11 at 400 kHz
>> [    0.474822] omap_i2c 48060000.i2c: did not get pins for i2c error: -19
>> [    0.476379] omap_i2c 48060000.i2c: bus 2 rev0.11 at 100 kHz
>> [    0.477294] omap_i2c 48350000.i2c: did not get pins for i2c error: -19
>> [    0.477996] omap_i2c 48350000.i2c: bus 3 rev0.11 at 400 kHz
>> [    0.483398] Switching to clocksource 32k_counter
>>
>> This happens because omap4 panda dts file is not adapted to use i2c through
>> pinctrl framework. Populating i2c pinctrl data to get rid of the error.
> 
> What about the panda-es and panda-a4?
> 
>> Tested on omap4460 panda with 3.8-rc6 kernel.
>>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> Reported-by: Luciano Coelho <coelho@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4-panda.dts |   40 +++++++++++++++++++++++++++++++++++++
>>  1 files changed, 40 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
>> index 4122efe..f951e6b 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -110,9 +110,40 @@
>>  			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
>>  		>;
>>  	};
>> +
>> +	i2c1_pins: pinmux_i2c1_pins {
>> +		pinctrl-single,pins = <
>> +			0xe2 0x118        /* i2c1_scl PULLUP | INPUTENABLE | MODE0 */
>> +			0xe4 0x118        /* i2c1_sda PULLUP | INPUTENABLE | MODE0 */
>> +		>;
>> +	};
>> +
>> +	i2c2_pins: pinmux_i2c2_pins {
>> +		pinctrl-single,pins = <
>> +			0xe6 0x118        /* i2c2_scl PULLUP | INPUTENABLE | MODE0 */
>> +			0xe8 0x118        /* i2c2_sda PULLUP | INPUTENABLE | MODE0 */
>> +		>;
>> +	};
>> +
>> +	i2c3_pins: pinmux_i2c3_pins {
>> +		pinctrl-single,pins = <
>> +			0xea 0x118        /* i2c3_scl PULLUP | INPUTENABLE | MODE0 */
>> +			0xec 0x118     /* i2c3_sda PULLUP | INPUTENABLE | MODE0 */
>> +		>;
>> +	};
>> +
>> +	i2c4_pins: pinmux_i2c4_pins {
>> +		pinctrl-single,pins = <
>> +			0xee 0x118        /* i2c4_scl PULLUP | INPUTENABLE | MODE0 */
>> +			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
>> +		>;
>> +	};
>>  };
> 
> A quick look at the data manual shows that omap4430 and omap4460 has the
> same pin mux options for i2c. Furthermore, the data manual shows only
> one mux option for i2c1-4. Therefore, should these mux options be placed
> in omap4.dtsi? Boards not using specific i2c controllers can disabled
> them in there board dts file (same way we do for mmc).

I guess for i2c, a given omap4 board may use external pull-ups and not
use the internal ones and so putting this in the omap4.dtsi may not be
desirable. However, it seems that a common omap4-panda.dtsi could be
used here.

Cheers
Jon
