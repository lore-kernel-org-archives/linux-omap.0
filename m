From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v5 2/2] iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver
Date: Thu, 18 Jul 2013 11:48:10 +0200
Message-ID: <51E7B9DA.9040803@metafoo.de>
References: <1374059564-6872-1-git-send-email-oleksandr.kozaruk@ti.com> <1374059564-6872-3-git-send-email-oleksandr.kozaruk@ti.com> <51E6DCB5.3070302@metafoo.de> <CAPb7_muAzO-jRqgcm89fcKT-hTLq38Aj2p0WAWjGjN9DoQUwPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPb7_muAzO-jRqgcm89fcKT-hTLq38Aj2p0WAWjGjN9DoQUwPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, milo.kim-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/18/2013 10:36 AM, Oleksandr Kozaruk wrote:
> Hello Lars,
> 
> On Wed, Jul 17, 2013 at 9:04 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>>> +static int twl6032_calibration(struct twl6030_gpadc_data *gpadc)
>>> +{
>>> +     int chn, d1 = 0, d2 = 0, temp;
>>> +     u8 trim_regs[17];
>>> +     int ret;
>>> +
>>> +     ret = twl_i2c_read(TWL6030_MODULE_ID2, trim_regs + 1,
>>> +                     TWL6030_GPADC_TRIM1, 16);
>>> +     if (ret < 0) {
>>> +             dev_err(gpadc->dev, "calibration failed\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     /*
>>> +      * Loop to calculate the value needed for returning voltages from
>>> +      * GPADC not values.
>>> +      *
>>> +      * gain is calculated to 3 decimal places fixed point.
>>> +      */
>>> +     for (chn = 0; chn < TWL6032_GPADC_MAX_CHANNELS; chn++) {
>>> +
>>> +             switch (chn) {
>>> +             case 0:
>>> +             case 1:
>>> +             case 2:
>>> +             case 3:
>>> +             case 4:
>>> +             case 5:
>>> +             case 6:
>>> +             case 11:
>>> +             case 12:
>>> +             case 13:
>>> +             case 14:
>>> +                     /* D1 */
>>> +                     d1 = (trim_regs[3] & 0x1F) << 2;
>>> +                     d1 |= (trim_regs[1] & 0x06) >> 1;
>>> +                     if (trim_regs[1] & 0x01)
>>> +                             d1 = -d1;
>>> +
>>> +                     /* D2 */
>>> +                     d2 = (trim_regs[4] & 0x3F) << 2;
>>> +                     d2 |= (trim_regs[2] & 0x06) >> 1;
>>> +                     if (trim_regs[2] & 0x01)
>>> +                             d2 = -d2;
>>> +                     break;
>>> +             case 8:
>>> +                     /* D1 */
>>> +                     temp = (trim_regs[3] & 0x1F) << 2;
>>> +                     temp |= (trim_regs[1] & 0x06) >> 1;
>>> +                     if (trim_regs[1] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d1 = (trim_regs[8] & 0x18) << 1;
>>> +                     d1 |= (trim_regs[7] & 0x1E) >> 1;
>>> +                     if (trim_regs[7] & 0x01)
>>> +                             d1 = -d1;
>>> +
>>> +                     d1 += temp;
>>> +
>>> +                     /* D2 */
>>> +                     temp = (trim_regs[4] & 0x3F) << 2;
>>> +                     temp |= (trim_regs[2] & 0x06) >> 1;
>>> +                     if (trim_regs[2] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d2 = (trim_regs[10] & 0x1F) << 2;
>>> +                     d2 |= (trim_regs[8] & 0x06) >> 1;
>>> +                     if (trim_regs[8] & 0x01)
>>> +                             d2 = -d2;
>>> +
>>> +                     d2 += temp;
>>> +                     break;
>>> +             case 9:
>>> +                     /* D1 */
>>> +                     temp = (trim_regs[3] & 0x1F) << 2;
>>> +                     temp |= (trim_regs[1] & 0x06) >> 1;
>>> +                     if (trim_regs[1] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d1 = (trim_regs[14] & 0x18) << 1;
>>> +                     d1 |= (trim_regs[12] & 0x1E) >> 1;
>>> +                     if (trim_regs[12] & 0x01)
>>> +                             d1 = -d1;
>>> +
>>> +                     d1 += temp;
>>> +
>>> +                     /* D2 */
>>> +                     temp = (trim_regs[4] & 0x3F) << 2;
>>> +                     temp |= (trim_regs[2] & 0x06) >> 1;
>>> +                     if (trim_regs[2] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d2 = (trim_regs[16] & 0x1F) << 2;
>>> +                     d2 |= (trim_regs[14] & 0x06) >> 1;
>>> +                     if (trim_regs[14] & 0x01)
>>> +                             d2 = -d2;
>>> +
>>> +                     d2 += temp;
>>> +             case 10:
>>> +                     /* D1 */
>>> +                     d1 = (trim_regs[11] & 0x0F) << 3;
>>> +                     d1 |= (trim_regs[9] & 0x0E) >> 1;
>>> +                     if (trim_regs[9] & 0x01)
>>> +                             d1 = -d1;
>>> +
>>> +                     /* D2 */
>>> +                     d2 = (trim_regs[15] & 0x0F) << 3;
>>> +                     d2 |= (trim_regs[13] & 0x0E) >> 1;
>>> +                     if (trim_regs[13] & 0x01)
>>> +                             d2 = -d2;
>>> +                     break;
>>> +             case 7:
>>> +             case 18:
>>> +                     /* D1 */
>>> +                     temp = (trim_regs[3] & 0x1F) << 2;
>>> +                     temp |= (trim_regs[1] & 0x06) >> 1;
>>> +                     if (trim_regs[1] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d1 = (trim_regs[5] & 0x7E) >> 1;
>>> +                     if (trim_regs[5] & 0x01)
>>> +                             d1 = -d1;
>>> +.
>>> +                     d1 += temp;
>>> +
>>> +                     /* D2 */
>>> +                     temp = (trim_regs[4] & 0x3F) << 2;
>>> +                     temp |= (trim_regs[2] & 0x06) >> 1;
>>> +                     if (trim_regs[2] & 0x01)
>>> +                             temp = -temp;
>>> +
>>> +                     d2 = (trim_regs[6] & 0xFE) >> 1;
>>> +                     if (trim_regs[6] & 0x01)
>>> +                             d2 = -d2;
>>> +
>>> +                     d2 += temp;
>>> +                     break;
>>
>>
>> There is quite a bit of copy paste in here. Putting the bit swizziling into
>> a helper function should also improbe legibility.
> 
> Trimming bits are scattered randomly between registers and in
> different bit positions.
> I don't see any commonalities, that could be generalized. as Graeme
> said about it "it's a bane of my life".

The pattern is pretty regular though, how about:


int twl6032_get_trim_value(u8 *trim_regs, unsigned int reg0,
	unsigned int reg1, unsigned int mask0, unsigned int mask1,
	unsigned int shift0)
{
	int val;

	val = (trim_regs[reg0] & mask0) << shift0;
	val |= (trim_regs[reg1] & mask1) >> 1;
	if (trim_regs[reg1] & 0x01)
		val = -val;

	return val;
}

and then

	d1 = twl6032_get_trim_value(trim_regs, 3, 1, 0x1f, 0x06, 2);
	d2 = twl6032_get_trim_value(trim_regs, 4, 2, 0x3f, 0x06, 2);

and so on.
