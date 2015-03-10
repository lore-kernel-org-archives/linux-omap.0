From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
Date: Tue, 10 Mar 2015 10:06:11 -0500
Message-ID: <54FF0863.7080804@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com>	<1425427237-11511-2-git-send-email-nm@ti.com> <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

On 03/10/2015 05:39 AM, Linus Walleij wrote:
> On Wed, Mar 4, 2015 at 1:00 AM, Nishanth Menon <nm@ti.com> wrote:
> 
>> +Configuration definition follows similar model as the pinctrl-single:
>> +The groups of pin configuration are defined under "pinctrl-single,pins"
>> +
>> +&dra7_iodelay_core {
>> +       mmc2_iodelay_3v3_conf: mmc2_iodelay_3v3_conf {
>> +               pinctrl-single,pins = <
>> +                       0x18c (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A19_IN */
>> +                       0x1a4 (A_DELAY(265) | G_DELAY(360))     /* CFG_GPMC_A20_IN */
>> +                       0x1b0 (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A21_IN */
>> +                       0x1bc (A_DELAY(0) | G_DELAY(120))       /* CFG_GPMC_A22_IN */
>> +                       0x1c8 (A_DELAY(287) | G_DELAY(420))     /* CFG_GPMC_A23_IN */
>> +                       0x1d4 (A_DELAY(144) | G_DELAY(240))     /* CFG_GPMC_A24_IN */
>> +                       0x1e0 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_A25_IN */
>> +                       0x1ec (A_DELAY(120) | G_DELAY(0))       /* CFG_GPMC_A26_IN */
>> +                       0x1f8 (A_DELAY(120) | G_DELAY(180))     /* CFG_GPMC_A27_IN */
>> +                       0x360 (A_DELAY(0) | G_DELAY(0))         /* CFG_GPMC_CS1_IN */
>> +               >;
>> +       };
>> +};
> 
> But wait.
> 
> The promise when we merged pinctrl-single was that this driver was to be used
> when the system had a one-register-per-pin layout and it was easy to do device
> trees based on that.
> 
> We were very reluctant to accept that even though we didn't even have the
> generic pin control bindings in place, the argument being that the driver
> should know the detailed register layout, it should not be described in the
> device tree. We eventually caved in and accepted it as an exception.
> 
> Since this pin controller is not using pinctrl-single it does not enjoy that
> privilege and you need to explain why this pin controller cannot use the
> generic bindings like so many other pin controllers have since started
> to do. ("It is in the same SoC" is not an acceptable argument.)
> 
> What is wrong with this:
> Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> 
> We can add generic delay bindings to the list, it even seems like
> a good idea to do so, as it is likely something that will come up in
> other hardware and will be needed for ACPI etc going forward.

Let me try to explain how the hardware works in this instance - it is
a quirk that we had'nt understood as being mandatory until very recently.

Apologies on pointing to TRM. Unfortunately, understanding this kind
of needs us to understand the hardware a little deeper.

http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
18.5.2 CTRL_MODULE_CORE registers (page 4040) -> mux starts from
CTRL_CORE_PAD_GPMC_AD0 (page 4390)

This is the basic support needed for DRA7 family of SoC
handled by pinctrl-single. a single register for a single pin -> write
the mux mode, internal pull, wakeup capability etc. handled today as
part of pinctrl-single compatible "ti,dra7-padconf".

This works for almost 95%+ of the pins. few pins need tweaking of the
delay parameters to address per die, operational and board(rarely)
characteristics.

Here is where it gets a little complicated.

18.6.1 IODELAYCONFIG Module Instance Summary (page 4798) - starts at
CFG_RMII_MHZ_50_CLK_IN.

These registers are programmed per "18.4.6.1.4 Manual IO Timing Modes"
(page 4004).

Initial sequence of recalibration involves IO isolation - process
involving isolating every DRA7 pin from the external world - The only
logical place to do this is obviously as part of bootloader. Doing
this from kernel can be more than rationally complicated (IO isolation
for doing recalibration while a video playback or coprocessor like DSP
is active is just plain ridiculous in complexity).

The calibrated values then are read for programming these iodelay
registers per pin as described in the Section "18.4.6.1.4 Manual IO
Timing Modes" (page 4005).


In summary:
- This does not really control traditional points of pinctrl control
such as mux mode, pull direction etc. It is, in short, a tweaking of
delay paths from the IP to the external pin.

- Most pins do not need iodelay register programming. The ones that do
may have upto 3 other registers that may need programming (IN, OUT, OUTEN)

- Unlike pinctrl-single where a value is read from dts and programmed
straight to the register, programming iodelay involves taking two
parameter(a_delay and g_delay) per iodelay register, value for the
registers computed based on two other parameters(cdpe, fdpe). Where
cdpe and fdpe are computed based on "recalibration sequence" generated
values programmed in register fields for ref_count, delay_count and
ref_clk_period.
	- This is also why pinctrl-single wont work here - it is not
	  a copy from dts to register sequence, it is a compute from
	  dts to register sequence.

- The recalibration parameters ref_count, delay_count and
ref_clk_period are die dependent (hence the need of recalibration
sequence).

- The parameters a_delay, g_delay are dependent on operational
mode/board properties.
	- This is why such a data in kernel may not scale with
	  multitude of board variations and operational needs of
	  certain pins.
	- The values themselves come from some automated tool/data
	  sheet with per-board tweaking done under simulation.

Considering this was a "configuration of per pin iodelay", i chose
pinconf-like model here. Unfortunately, The traditional pinconf is a
set of properties for a pin, but it does not give information as to
which register those properties belong to. since these registers do
not form the same pattern of offsets as padconf register, that iodelay
register information will need to be encoded in some form.

The traditional pinctrl does not fit this hardware either. it does not
control mux, rather given that pinctrl has selected a specific mux
mode, it tweaks the delay parameters corresponding to that mux.


This is one of those modules that I cant seem to fit neatly in any of
the existing frameworks, I am most happy to understand if there are
alternatives that can be proposed..

-- 
Regards,
Nishanth Menon
