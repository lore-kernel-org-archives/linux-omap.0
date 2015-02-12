From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-pandora: add common device tree
Date: Thu, 12 Feb 2015 17:29:41 +0100
Message-ID: <572DFAE0-6B61-47B2-90FF-DF8A827DE735@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-2-git-send-email-marek@goldelico.com>
 <20150212160316.GL2531@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150212160316.GL2531@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Am 12.02.2015 um 17:03 schrieb Tony Lindgren <tony@atomide.com>:

> Hi,
> =

> Few comments below.
> =

> * Marek Belisko <marek@goldelico.com> [150212 05:07]:
>> +
>> +&omap3_pmx_core {
>> +
>> +	mmc1_pins: pinmux_mmc1_pins {
>> +		pinctrl-single,pins =3D <
>> +			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_c=
lk.sdmmc1_clk */
>> +			OMAP3_CORE1_IOPAD(0x2146, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_c=
md.sdmmc1_cmd */
>> +			OMAP3_CORE1_IOPAD(0x2148, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_d=
at0.sdmmc1_dat0 */
>> +			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_d=
at1.sdmmc1_dat1 */
>> +			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_d=
at2.sdmmc1_dat2 */
>> +			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc1_d=
at3.sdmmc1_dat3 */
>> +		>;
> ...
> =

>> +&omap3_pmx_core2 {
>> +	/* define in CPU specific file that includes this one
>> +	 * use either OMAP3430_CORE2_IOPAD() or OMAP3630_CORE2_IOPAD()
>> +	 */
>> +};
> =

> OK looks like you have some SoC specific pins too.. I assume you
> guys have checked that all the pins defined in this file are at
> the same offset between 34xx and 36xx variants?

Yes. All in this file are common between 34xx and 36xx.
The 600mhz / 1ghz files cover the differences for pmx_core2 through the dif=
ferent macros
(OMAP3430_CORE2_IOPAD vs. OMAP3460_CORE2_IOPAD).

> =

>> +&i2c1 {
>> +	clock-frequency =3D <2600000>;
>> +
>> +	twl: twl@48 {
>> +		reg =3D <0x48>;
>> +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
>> +		interrupt-parent =3D <&intc>;
>> +
>> +		twl_power: power {
>> +			compatible =3D "ti,twl4030-power-reset";
>> +			ti,use_poweroff;
>> +		};
>> +
>> +		twl_audio: audio {
>> +			compatible =3D "ti,twl4030-audio";
>> +
>> +			codec {
>> +				ti,ramp_delay_value =3D <3>;
>> +			};
>> +		};
>> +	};
>> +};
> =

> Can be done later naturally, but ere you probably want
> ti,twl4030-power-idle or ti,twl4030-power-idle-osc-off
> if the osicllator can be shut down during off-idle.

Good hint. We have to check and test if it can be shut down.
But as said, this is just the beginning of DT support.

> =

>> +&gpmc {
>> +	ranges =3D <0 0 0x30000000 0x04>; /* CS0: NAND */
> =

> The ranges here allocate the GPMC partition, so it needs to be
> a minimum of 16MB:
> =

> 	ranges =3D <0 0 0x30000000 0x1000000>,	/* CS0: 16MB for NAND */
> =

>> +	nand@0,0 {
>> +		reg =3D <0 0 0>; /* CS0, offset 0 */
> =

> The reg is for the device driver to ioremap it's registers,
> for NAND it's just 4:
> =

> 		reg =3D <0 0 4>;	/* CS0, offset 0, IO size 4 */

Ok, that was a typo and we have not tested how compatible it is to the
board file scheme.

> =

>> +		filesystem@680000 {
>> +			label =3D "rootfs";
>> +			reg =3D <0xc80000 0>;	/* 0 =3D MTDPART_SIZ_FULL */
>> +		};
>> +	};
>> +};
> =

> Is the NAND the same size on all of them?

AFAIK not necessarily.

> I don't think dts
> has a binding for MTDPART_SIZ_FULL type thing..

It does not need a special binding, we just set the size to 0. This
is interpreted as MTDPART_SIZ_FULL later on. For board files,
there is just a #define in include/linux/mtd/partitions.h and it appears
to work.

> =

>> +	lcd: lcd@1 {
>> +		reg =3D <1>;	/* CS1 */
>> +		compatible =3D	"omapdss,tpo,td043mtea1";
>> +		spi-max-frequency =3D <100000>;
>> +		spi-cpol;
>> +		spi-cpha;
>> +
>> +		label =3D "lcd";
>> +		reset-gpios =3D <&gpio5 29 GPIO_ACTIVE_LOW>;	/* GPIO_157 */
>> +		vcc-supply =3D <&vaux1>;
>> +
>> +		port {
>> +			lcd_in: endpoint {
>> +				remote-endpoint =3D <&dpi_out>;
>> +			};
>> +		};
>> +	};
> =

> Oh there's already a binding for the LCD too? That=92s great :)

Yes, we were happy to find that the panel driver has already been upgraded
for DT use.

> =

> Nine job, good to see this happening!
> =

> Regards,
> =

> =

> Tony

BR,
Nikolaus
