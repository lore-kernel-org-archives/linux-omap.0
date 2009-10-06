From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCHv3 1/7] OMAP4: PMIC: Add support for twl6030
 codec
Date: Tue, 6 Oct 2009 11:53:03 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90C2F931@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90C2F648@dlee04.ent.ti.com>
	<200910061146.05080.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200910061146.05080.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar,
	Santosh" <santosh.shilimkar@ti.com>, "Krishnamoorthy,
	Balaji T" <balajitk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

Peter Ujfalusi wrote:
> On Tuesday 06 October 2009 10:29:39 ext Lopez Cruz, Misael wrote:
>> In order to have TWL6030 CODEC driver as a platform driver, codec
>> data should be passed through twl_platform_data structure.
>> 
>> For twl6030 audio codec, the following data may be passed:
>> 
>> - audpwron_gpio: gpio line used to power-up/down the codec. A
>>   low-to-high transition powers codec up. Setting audpwron_gpio to a
>>   negative value means that codec will use manual power sequence
>> instead of automatic   sequence - naudint_irq: irq line for audio
>>   interrupt. twl6030 drives NAUDINT line to low when an interrupt
>> (codec ready, plug insertion/removal, etc) is   detected 
>> 
>> However, codec driver can operate if any or none of them are passed.

> How does the twl4030 series would fit with this modification?
> I have also added the twl4030 codec as a child for the twl
> MFD, but I have not finished the cleanup of the codec fully.

twl6030 codec data won't conflict with twl4030's as it's dependent of
TWL6030_CORE. We can add parallely the required data for twl4030 codec.

>> 
>> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
>> ---
>>  drivers/mfd/twl-core.c  |   15 +++++++++++++++
>>  include/linux/i2c/twl.h |    7 +++++++
>>  2 files changed, 22 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
>> index af4cf47..6432af1 100644
>> --- a/drivers/mfd/twl-core.c
>> +++ b/drivers/mfd/twl-core.c
>> @@ -108,6 +108,12 @@
>>  #define twl_has_mmc()   false
>>  #endif
>> 
>> +#if defined(CONFIG_SND_SOC_TWL6030) ||
>>  defined(CONFIG_SND_SOC_TWL6030_MODULE) +#define
>> twl_has_codec()	true +#else +#define twl_has_codec()	false
>> +#endif
>> +
>>  #if defined(CONFIG_TWL4030_USB) ||
> defined(CONFIG_TWL4030_USB_MODULE)
>>  #define twl_has_usb()	true
>>  #else
>> @@ -190,6 +196,7 @@
>>  #define BCI_SUB_CHIP_ID		SUB_CHIP_ID1
>>  #define GPIO_SUB_CHIP_ID	0 /* NOT SUPPORTED IN TWL6030 */
>>  #define KEYPAD_SUB_CHIP_ID	0 /* ADDED FOR COMPILATION ONLY */
>> +#define CODEC_SUB_CHIP_ID	SUB_CHIP_ID3

> TWL4030 codec is under ID2 address group.

CODEC_SUB_CHIP_ID for twl6030 is under #ifdef CONFIG_TWL6030_CORE.
There are a different set of _CHIP_IDs for twl4030 children, which
doesn't have a definition for CODEC yet.

>> 
>>  /* subchip/slave 0 0x48 - POWER */
>>  #define TWL6030_BASEADD_RTC		0x0000
>> @@ -632,6 +639,14 @@ add_children(struct twl_platform_data *pdata,
>>  unsigned long features) if (IS_ERR(child))
>>  			return PTR_ERR(child);
>>  	}
>> +
>> +	if (twl_has_codec()) {
>> +		child = add_child(CODEC_SUB_CHIP_ID, "twl6030_codec",
>> +			pdata->codec, sizeof(*pdata->codec), false,
>> +			0, 0);
>> +		if (IS_ERR(child))
>> +			return PTR_ERR(child);
>> +	}

> We are going to have the twl4030 as child as well.

>>  #endif
>> 
>>  	if (twl_has_usb() && pdata->usb) {
>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h index
>> b687a8b..e76ca9b 100644 --- a/include/linux/i2c/twl.h
>> +++ b/include/linux/i2c/twl.h
>> @@ -472,6 +472,12 @@ struct twl_usb_data {
>>  	enum twl_usb_mode	usb_mode;
>>  };
>> 
>> +struct twl_codec_data {
>> +	/* twl6030 */
>> +	int audpwron_gpio;	/* audio power-on gpio */
>> +	int naudint_irq;	/* audio interrupt */
>> +};

> These are not applicable for the twl4030 codec, should we
> have different
> twl_codec_data for twl6030 and twl4030 series?

Currently, the support for TWL4030 and TWL6030 makes them mutually
exclusive, TWL6030_CORE depends on !TWL4030_CORE. So we can have
separate twl_codec_data definitions to avoid unused space in the
structure.

> Should I merge here the things which will be used for the twl4030
> codec?

I think merging them would suit only if both twl versions can be
enabled at the same time, but not sure it that makes sense.

> At the moment, I only have audio_mclk in my codec_data, but
> most probably the HS ramp related things will be also merged here
> in the future.

>> +
>>  struct twl_platform_data {
>>  	unsigned				irq_base, irq_end;
>>  	struct twl_bci_platform_data	*bci;
>> @@ -479,6 +485,7 @@ struct twl_platform_data {
>>  	struct twl_madc_platform_data	*madc;
>>  	struct twl_keypad_data		*keypad;
>>  	struct twl_usb_data			*usb;
>> +	struct twl_codec_data		*codec;
>> 
>>  	/* LDO regulators common to TWL4030/TWL6030 */
>>  	struct regulator_init_data		*vdac;
