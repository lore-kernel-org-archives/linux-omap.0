From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 3/3] radio-tea5761: Update driver
Date: Mon, 9 Jun 2008 21:14:21 -0400
Message-ID: <a0580c510806091814g246a1553n7e78f8a857d978f8@mail.gmail.com>
References: <1213041943-31218-1-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-2-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-3-git-send-email-edubezval@gmail.com>
	 <1213041943-31218-4-git-send-email-edubezval@gmail.com>
	 <20080609234028.GC4962@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:61559 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYFJBOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2008 21:14:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so622242rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Jun 2008 18:14:21 -0700 (PDT)
In-Reply-To: <20080609234028.GC4962@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Balbi,

On Mon, Jun 9, 2008 at 7:40 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Mon, Jun 09, 2008 at 04:05:43PM -0400, Eduardo Valentin wrote:
>> +static void tea5761_set_audout_mode(struct tea5761_device *tea, int audmode)
>>  {
>> -     struct tea5761_regs *r = &tea->regs;
>> -
>> -     if (!(r->tnctrl & TEA5761_TNCTRL_PUPD0)) {
>> -             r->tnctrl &= ~(TEA5761_TNCTRL_AFM | TEA5761_TNCTRL_MU |
>> -                            TEA5761_TNCTRL_HLSI);
>> -             r->testreg |= TEA5761_TESTREG_TRIGFR;
>> -             r->tnctrl |= TEA5761_TNCTRL_PUPD0;
>> -             return tea5761_write_regs(tea);
>> +     struct dvb_frontend *fe = &tea->fe;
>> +     struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
>> +     struct analog_parameters params = {
>> +             .mode           = V4L2_TUNER_RADIO,
>> +             .frequency      = tea->freq,
>> +             .audmode        = audmode,
>> +     };
>> +
>> +     if (NULL == fe_tuner_ops->set_analog_params) {
>> +             dev_warn(tea->dev,
>> +                     "Tuner frontend module has no way to set frequency\n");
>> +             return;
>>       }
>> +     if (!fe_tuner_ops->set_analog_params(fe, &params))
>> +             tea->audmode = audmode;
>
> instead of both ifs, how about:
>
>        if (fe_tuner_ops->set_analog_params) {
>                tea->audmode =
>                fe_tuner_ops->set_analog_params(fe, &params) ?
>                        audmode : 0;
>        }
>>  }

I don't know. I personally do not like "silent fail" style. The way you
proposed it will say nothing if set_anolog_params is not set. And that
is a very important part of this code.
>
>> +static void tea5761_mute(struct tea5761_device *tea, int on)
>> +{
>> +     struct dvb_frontend *fe = &tea->fe;
>> +     struct dvb_tuner_ops *fe_tuner_ops = &fe->ops.tuner_ops;
>> +     struct analog_parameters params = {
>> +             .mode           = on ? T_STANDBY : V4L2_TUNER_RADIO,
>> +             .frequency      = tea->freq,
>> +             .audmode        = tea->audmode,
>> +     };
>> +
>> +     if (NULL == fe_tuner_ops->set_analog_params) {
>> +             dev_warn(tea->dev,
>> +                     "Tuner frontend module has no way to set frequency\n");
>> +             return;
>>       }
>> +     if (!fe_tuner_ops->set_analog_params(fe, &params))
>> +             tea->mute = on;
>
> samething here.
same here.
>
>>  }
>
>>  static int tea5761_i2c_driver_probe(struct i2c_client *client,
>> @@ -422,12 +407,24 @@ static int tea5761_i2c_driver_probe(struct i2c_client *client,
>>
>>       mutex_init(&tea->mutex);
>>
>> -     tea->i2c_dev = client;
>> +     /* Tuner attach */
>> +     if (!dvb_attach(tea5761_attach, &tea->fe, client->adapter,
>> +                     client->addr)) {
>> +             dev_err(&client->dev, "Could not attach tuner\n");
>> +             err = -ENODEV;
>> +             goto exit;
>> +     }
>> +
>> +     /* initialize and power off the chip */
>> +     tea5761_power_up(tea);
>> +     tea5761_set_audout_mode(tea, V4L2_TUNER_MODE_STEREO);
>> +     tea5761_mute(tea, 0);
>> +     tea5761_power_down(tea);
>>
>>       /* V4L initialization */
>>       video_dev = video_device_alloc();
>>       if (video_dev == NULL) {
>
>        if (!video_dev)
>
>> -             dev_err(&client->dev, "couldn't allocate memory\n");
>> +             dev_err(&client->dev, "Could not allocate memory\n");
>>               err = -ENOMEM;
>>               goto exit;
>>       }
>> @@ -436,25 +433,15 @@ static int tea5761_i2c_driver_probe(struct i2c_client *client,
>>       *video_dev = tea5761_video_device;
>>       video_dev->dev = &client->dev;
>>       i2c_set_clientdata(client, video_dev);
>> -
>> -     /* initialize and power off the chip */
>> -     tea5761_read_regs(tea);
>> -     tea5761_set_audout_mode(tea, V4L2_TUNER_MODE_STEREO);
>> -     tea5761_mute(tea, 0);
>> -     tea5761_power_down(tea);
>> -
>> -     tea5761.video_dev = video_dev;
>> -     tea5761.i2c_dev = client;
>> +     tea->video_dev = video_dev;
>> +     tea->dev = &client->dev;
>>
>>       err = video_register_device(video_dev, VFL_TYPE_RADIO, radio_nr);
>>       if (err) {
>> -             dev_err(&client->dev, "couldn't register video device\n");
>> +             dev_err(&client->dev, "Could not register video device\n");
>>               goto err_video_alloc;
>>       }
>>
>> -     dev_info(&client->dev, "tea5761 (version %d) detected\n",
>> -             (tea->regs.manid >> 12) & 0xf);
>> -
>>       return 0;
>>
>>  err_video_alloc:
>> @@ -492,7 +479,8 @@ static int __init tea5761_init(void)
>>  {
>>       int res;
>>
>> -     if ((res = i2c_add_driver(&tea5761_driver))) {
>> +     res = i2c_add_driver(&tea5761_driver);
>> +     if (res) {
>>               printk(KERN_ERR DRIVER_NAME ": driver registration failed\n");
>>               return res;
>
> not needed, return i2c_add_driver(&tea5761_driver); is enough as i2c
> subsystem already prints out error messages in case of failed probe.

If I understood correctly what you said, the same comment I said
before also applies here.
Eventhough it prints that the probe
failed, this way I sent it says: The probe failed and "The driver
registration failed". More easy
to debug the code when in a error situation.

>
>>       }
>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>



-- 
Eduardo Bezerra Valentin
