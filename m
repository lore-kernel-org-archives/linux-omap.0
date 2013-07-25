From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Subject: Re: [PATCH v6 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Thu, 25 Jul 2013 09:08:48 +0300
Message-ID: <20130725060848.GA16521@uglx0158319>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com>
 <1374226039-16943-3-git-send-email-oleksandr.kozaruk@ti.com>
 <51EA69DE.4080908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51EA69DE.4080908@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: milo.kim@ti.com, lars@metafoo.de, sameo@linux.intel.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, poeschel@lemonage.de, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, kishon@ti.com, peter.ujfalusi@ti.com, linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, jic23@cam.ac.uk, grant.likely@linaro.org, benoit.cousson@linaro.org, gg@slimlogic.co.uk, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org, balajitk@ti.com
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 20, 2013 at 11:43:42AM +0100, Jonathan Cameron wrote:
> On 07/19/2013 10:27 AM, Oleksandr Kozaruk wrote:
> > The GPADC is general purpose ADC found on TWL6030, and TWL6032 PMIC,
> > known also as Phoenix and PhoenixLite.
> >
> > The TWL6030 and TWL6032 have GPADC with 17 and 19 channels
> > respectively. Some channels have current source and are used for
> > measuring voltage drop on resistive load for detecting battery ID
> > resistance, or measuring voltage drop on NTC resistors for external
> > temperature measurements. Some channels measure voltage, (i.e. battery
> > voltage), and have voltage dividers, thus, capable to scale voltage.
> > Some channels are dedicated for measuring die temperature.
> >
> > Some channels are calibrated in 2 points, having offsets from ideal
> > values kept in trim registers. This is used to correct measurements.
> >
> > The differences between GPADC in TWL6030 and TWL6032:
> > - 10 bit vs 12 bit ADC;
> > - 17 vs 19 channels;
> > - channels have different purpose(i.e. battery voltage
> >   channel 8 vs channel 18);
> > - trim values are interpreted differently.
> >
> > Based on the driver patched from Balaji TK, Graeme Gregory, Ambresh K,
> > Girish S Ghongdemath.
> >
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> > Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> > Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> A few little bits and bobs inline.
> 
> My only major query is about the lack of info for the temperature
> channels.  How do you convert these to useful real world units?

On blaze tablet platform(OMAP 4) temperature channels were used by
thermal framework and battery driver.
Thermal was using channel 4 [1]

Here is the comment from the driver:

* NTC termistor (NCP15WB473F) schematic connection for OMAP4460 board:
*
*          [Vref]
*            |
*            $ (Rpu)
*            |
*            +----+-----------[Vin]
*            |    |
*           [Rt]  $ (Rpd)
*            |    |
*           -------- (ground)
*
* NTC termistor resistanse (Rt, k) calculated from following formula:
*
* Rt = Rpd * Rpu * Vin / (Rpd * (Vref - Vin) - Rpu * Vin)
*
* where       Vref (GPADC_VREF4) - reference voltage, Vref = 1250 mV;
*                     Vin (GPADC_IN4) - measuring voltage, Vin = 0...1250 mV;
*                     Rpu (R1041) - pullup resistor, Rpu = 10 k;
*                     Rpd (R1043) - pulldown resistor, Rpd = 220 k;
*
* Pcb temp sensor temperature (t, C) calculated from following formula:
*
* t = 1 / (ln(Rt / Rt0) / B + 1 / T0) - 273
*
* where       Rt0 - NTC termistor resistance at 25 C, Rt0 = 47 k;
*                     B - specific constant, B = 4131 K;
*                     T0 - temperature, T0 = 298 K
[..]

And then there is a table for conversion:
/*
 * Temperature values in degrees celsius,
 * voltage values from 156 to 1191 milli volts
*/
static s8 mvolt_to_temp[] = {
               125, 125, 125, 124, 124, 124, 124, 123, 123, 123, 122, 122,
               122, 122, 121, 121, 121, 121, 120, 120, 120, 120, 119, 119,
[..]

The battery driver was using channel 1, dedicated for measuring battery
temperature.
static void twl6030_bci_battery_work(struct work_struct *work)
{
[..]
	for (temp = 0; temp < di->platform_data->tblsize; temp++) {
		if (adc_code >= di->platform_data->
				battery_tmp_tbl[temp])
			break;
	}

	/* first 2 values are for negative temperature */
	di->temp_C = (temp - 2) * 10; * /* in tenths of degree Celsius */
	[..]
}
static int omap4_batt_table[] = {
/* adc code for temperature in degree C */
	929, 925, /* -2 ,-1 */
	920, 917, 912, 908, 904, 899, 895, 890, 885, 880, /* 00 - 09 */
	875, 869, 864, 858, 853, 847, 841, 835, 829, 823, /* 10 - 19 */
[..]
	591, 583, 575, 567, 559, 551, 543, 535, 527, 519, /* 50 - 59 */
	511, 504, 496 /* 60 - 62 */
};

So, one driver was using millivolts and the other ADC code,
Though converting to millivolts and the to temperature, seems,
to be redundant, as code can be converted to temperature.
If I recollect correctly the previous driver version was using just
ADC code.

Regards,
Sasha.

[1] http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=drivers/staging/thermal_framework/sensor/thermistor_sensor.c;h=828d8010579b55ec4a122c49a2e5b547b1e41e63;hb=decb3fd22223ddf207e0118d0d558459acc7094e
