From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: omap: re-factor omap_i2c_init function
Date: Thu, 25 Oct 2012 12:23:56 +0530
Message-ID: <CAM=Q2cvzQ7fVL1-vUpWZdwhGk3s0GpO3uG3MH9CAzBvyeSftKQ@mail.gmail.com>
References: <1351147011-6500-1-git-send-email-shubhrajyoti@ti.com>
	<20121025063608.GA5084@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121025063608.GA5084-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 25, 2012 at 12:06 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Thu, Oct 25, 2012 at 12:06:51PM +0530, Shubhrajyoti D wrote:
>> re-factor omap_i2c_init() so that we can re-use it for resume.
>> While at it also remove the bufstate variable as we write it
>> in omap_i2c_resize_fifo for every transfer.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> ---
>> v2 - add the iestate 0 check back.
>>    - Remove a stray change.
>> - Applies on top of Felipe's patches.
>> http://www.spinics.net/lists/linux-omap/msg79995.html
>>
>>
>> Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
>> on omap3636 beagle both idle and suspend.
>>
>> Functional testing on omap4sdp.
>>
>>  drivers/i2c/busses/i2c-omap.c |   71 ++++++++++++++++++----------------------
>>  1 files changed, 32 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 5e5cefb..3d400b1 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -209,7 +209,6 @@ struct omap_i2c_dev {
>>       u16                     pscstate;
>>       u16                     scllstate;
>>       u16                     sclhstate;
>> -     u16                     bufstate;
>>       u16                     syscstate;
>>       u16                     westate;
>>       u16                     errata;
>> @@ -285,9 +284,31 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
>>       }
>>  }
>>
>> +static void __omap_i2c_init(struct omap_i2c_dev *dev)
>> +{
>> +
>> +     omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>> +     /* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
>> +     omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
>> +
>> +     /* SCL low and high time values */
>> +     omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
>> +     omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
>> +     if (dev->rev >= OMAP_I2C_REV_ON_3430_3530)
>> +             omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>> +     /* Take the I2C module out of reset: */
>> +     omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>
> a few blank lines in this function wouldn't hurt and they would help
> with readability.

Will add .

>
>> +     /*
>> +      * Don't write to this register if the IE state is 0 as it can
>> +      * cause deadlock.
>> +      */
>> +     if (dev->iestate)
>> +             omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>> +}
>> +
>>  static int omap_i2c_init(struct omap_i2c_dev *dev)
>>  {
>> -     u16 psc = 0, scll = 0, sclh = 0, buf = 0;
>> +     u16 psc = 0, scll = 0, sclh = 0;
>>       u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
>>       unsigned long fclk_rate = 12000000;
>>       unsigned long timeout;
>> @@ -337,11 +358,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>>                        * REVISIT: Some wkup sources might not be needed.
>>                        */
>>                       dev->westate = OMAP_I2C_WE_ALL;
>> -                     omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>> -                                                     dev->westate);
>
> remove the comment too since now that's done by some other function ?
>
>>               }
>>       }
>> -     omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>
>>       if (dev->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
>>               /*
>> @@ -426,28 +444,18 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>>               sclh = fclk_rate / (dev->speed * 2) - 7 + psc;
>>       }
>>
>> -     /* Setup clock prescaler to obtain approx 12MHz I2C module clock: */
>> -     omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, psc);
>> -
>> -     /* SCL low and high time values */
>> -     omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, scll);
>> -     omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, sclh);
>> -
>> -     /* Take the I2C module out of reset: */
>> -     omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>> -
>>       /* Enable interrupts */
>>       dev->iestate = (OMAP_I2C_IE_XRDY | OMAP_I2C_IE_RRDY |
>>                       OMAP_I2C_IE_NACK | OMAP_I2C_IE_AL)  |
>>                       ((dev->fifo_size) ? (OMAP_I2C_IE_RDR |
>>                               OMAP_I2C_IE_XDR) : 0);
>> -     omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>> -     if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>> -             dev->pscstate = psc;
>> -             dev->scllstate = scll;
>> -             dev->sclhstate = sclh;
>> -             dev->bufstate = buf;
>> -     }
>> +
>> +     dev->pscstate = psc;
>> +     dev->scllstate = scll;
>> +     dev->sclhstate = sclh;
>> +
>> +     __omap_i2c_init(dev);
>> +
>>       return 0;
>>  }
>>
>> @@ -1268,23 +1276,8 @@ static int omap_i2c_runtime_resume(struct device *dev)
>>  {
>>       struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
>>
>> -     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>> -     }
>> -
>> -     /*
>> -      * Don't write to this register if the IE state is 0 as it can
>> -      * cause deadlock.
>> -      */
>> -     if (_dev->iestate)
>> -             omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, _dev->iestate);
>> +     if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE)
>> +             __omap_i2c_init(_dev);
>>
>>       return 0;
>>  }
>
> you continue to miss the changes in omap_i2c_xfer_msg() and your
> explanation of why not doing it wasn't good enough IMHO.

Will do that . I am preparing a seperate patch for moving the
calculation to a seperate function.


>
> --
> balbi
