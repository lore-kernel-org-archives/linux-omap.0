From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2 v2] mfd: twl4030: Driver for twl4030 madc module
Date: Mon, 28 Feb 2011 10:24:42 +0530
Message-ID: <AANLkTin8hJk3qUysA84ZPoRPH7P-DdjN8BN2-KzJttt-@mail.gmail.com>
References: <1298560713-18790-1-git-send-email-j-keerthy@ti.com>
	<20110228010045.GD2749@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51845 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752227Ab1B1Eyq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 23:54:46 -0500
Received: by mail-ey0-f178.google.com with SMTP id 25so1280461eya.23
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 20:54:45 -0800 (PST)
In-Reply-To: <20110228010045.GD2749@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 6:30 AM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> Hi Keerthy,
>
> On Thu, Feb 24, 2011 at 08:48:33PM +0530, Keerthy wrote:
>> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for mo=
nitoring
>> ADC. This driver monitors the real time conversion of analog signals=
 like
>> battery temperature, battery cuurent etc.
> Looks mostly good to me, one minor comment though:
>
>> +static int twl4030_madc_read_channels(struct twl4030_madc_data *mad=
c,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u8 reg_base, u16 channels, int *buf)
>> +{
>> + =A0 =A0 int count =3D 0, count_req =3D 0;
>> + =A0 =A0 u8 reg, i;
>> +
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1 << i)) {
> You may want to use for_each_set_bit() here.
>

Ok.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2 * i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_ch=
annel_raw_read(madc, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf[i] < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(ma=
dc->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to=
 read register 0x%X\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count_req+=
+;
> For a clearer code, just call continue here, and the following blck w=
ill look
> nicer.
>

I will call continue.
>> +static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void =
*_madc)
>> +{
>> + =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
>> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 u8 isr_val, imr_val;
>> + =A0 =A0 int i, len, ret;
>> + =A0 =A0 struct twl4030_madc_request *r;
>
> Don't you want to take the madc lock around here ?

Ok.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
