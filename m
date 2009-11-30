From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] mfd: twl4030: Driver for twl4030 madc module
Date: Mon, 30 Nov 2009 15:58:39 +0200
Message-ID: <37786d4b0911300558i984d2bdj9b0c5617503c1950@mail.gmail.com>
References: <1259146071-2372-1-git-send-email-amit.kucheria@verdurent.com>
	 <20091127193636.GA16866@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753536AbZK3N6i@vger.kernel.org>
In-Reply-To: <20091127193636.GA16866@sortiz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>, khali@linux-fr.org
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On Fri, Nov 27, 2009 at 9:36 PM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> Hi Amit,
>
> On Wed, Nov 25, 2009 at 12:47:51PM +0200, Amit Kucheria wrote:
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index af0fc90..df1897b 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -25,8 +25,9 @@ obj-$(CONFIG_TPS65010) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D tps65010.o
>> =A0obj-$(CONFIG_MENELAUS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D menelaus.=
o
>>
>> =A0obj-$(CONFIG_TWL4030_CORE) =A0 +=3D twl4030-core.o twl4030-irq.o
>> -obj-$(CONFIG_TWL4030_POWER) =A0 =A0+=3D twl4030-power.o
>> +obj-$(CONFIG_TWL4030_POWER) =A0+=3D twl4030-power.o
>> =A0obj-$(CONFIG_TWL4030_CODEC) =A0+=3D twl4030-codec.o
>> +obj-$(CONFIG_TWL4030_MADC) =A0 +=3D twl4030-madc.o
>>
>> =A0obj-$(CONFIG_MFD_MC13783) =A0 =A0+=3D mc13783-core.o
>>
>> diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
>> new file mode 100644
>> index 0000000..90ce99a
>> --- /dev/null
>> +++ b/drivers/mfd/twl4030-madc.c
>> @@ -0,0 +1,548 @@
>> +/*
>> + * drivers/i2c/chips/twl4030-madc.c
> drivers/mfd/twl4030-madc.c
> By the way, have you considered moving this one to drivers/hwmon ?

I haven't. I moved it from i2c/chips/ to the most obvious place I
could think of - drivers/mfd. But wasn't this the point of mfd - that
various subcomponents drivers could live there instead of being
scattered across the driver tree?

Adding Jean to CC, if he would consider taking this driver in drivers/h=
wmon.

>> + * TWL4030 MADC module driver
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/types.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/fs.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/i2c/twl4030.h>
>> +#include <linux/i2c/twl4030-madc.h>
>> +
>> +#include <asm/uaccess.h>
>> +
>> +#define TWL4030_MADC_PFX =A0 =A0 "twl4030-madc: "
>> +
>> +struct twl4030_madc_data {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;
>> + =A0 =A0 struct work_struct =A0 =A0 =A0ws;
>> + =A0 =A0 struct twl4030_madc_request =A0 =A0 requests[TWL4030_MADC_=
NUM_METHODS];
> Typically, I'd expect to have a list (limited in length) of requests =
here, but
> I guess you're happy with that array .
>
>
>
>> + =A0 =A0 int imr;
>> + =A0 =A0 int isr;
>> +};
>> +
>> +static struct twl4030_madc_data *the_madc;
> I dont particularly enjoy that. All of the twl4030 drivers have this =
bad habit
> of assuming they will be alone on a platform. Although it's certainly=
 very
> likely, I still think having this kind of design is not so nice.

I agree. Unfortunately, twl4030-core.c is unable to handle multiple
devices currently. See note from line 779 in twl4030-core below:

/* NOTE:  this driver only handles a single twl4030/tps659x0 chip */
static int
twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id=
)

>> +static int twl4030_madc_set_current_generator(struct twl4030_madc_d=
ata *madc, int chan, int on);
>> +
>> +static
>> +const struct twl4030_madc_conversion_method twl4030_conversion_meth=
ods[] =3D {
>> + =A0 =A0 [TWL4030_MADC_RT] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sel =A0 =A0=3D TWL4030_MADC_RTSELECT_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .avg =A0 =A0=3D TWL4030_MADC_RTAVERAGE_LSB=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rbase =A0=3D TWL4030_MADC_RTCH0_LSB,
>> + =A0 =A0 },
>> + =A0 =A0 [TWL4030_MADC_SW1] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sel =A0 =A0=3D TWL4030_MADC_SW1SELECT_LSB=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .avg =A0 =A0=3D TWL4030_MADC_SW1AVERAGE_LS=
B,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rbase =A0=3D TWL4030_MADC_GPCH0_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =A0 =3D TWL4030_MADC_CTRL_SW1,
>> + =A0 =A0 },
>> + =A0 =A0 [TWL4030_MADC_SW2] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .sel =A0 =A0=3D TWL4030_MADC_SW2SELECT_LSB=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .avg =A0 =A0=3D TWL4030_MADC_SW2AVERAGE_LS=
B,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rbase =A0=3D TWL4030_MADC_GPCH0_LSB,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrl =A0 =3D TWL4030_MADC_CTRL_SW2,
>> + =A0 =A0 },
>> +};
>> +
>> +static int twl4030_madc_read(struct twl4030_madc_data *madc, u8 reg=
)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 val;
>> +
>> + =A0 =A0 ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_MADC, &val, reg=
);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "unable to read registe=
r 0x%X\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return val;
>> +}
> FWIW, you're not checking the return value on any of the madc_read ca=
lls
> below.

I've changed the dev_dbg above to dev_err now. If we see those error
messages, then anything that follows from the higher level functions
is overhead IMHO.
The higher level functions in this case aren't adding any more useful
information to the error. E.g. I could check the return value again in
twl4030_madc_channel_raw_read() below. But if would simply repeat the
same error message we show in twl4030_madc_read().

Hmm, perhaps twl4030_madc_read should return void?

>> +static void twl4030_madc_write(struct twl4030_madc_data *madc, u8 r=
eg, u8 val)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MADC, val, reg=
);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(madc->dev, "unable to write regist=
er 0x%X\n", reg);
>> +}
>> +
>> +static int twl4030_madc_channel_raw_read(struct twl4030_madc_data *=
madc, u8 reg)
>> +{
>> + =A0 =A0 u8 msb, lsb;
>> +
>> + =A0 =A0 /* For each ADC channel, we have MSB and LSB register pair=
=2E MSB address
>> + =A0 =A0 =A0* is always LSB address+1. reg parameter is the addr of=
 LSB register */
>> + =A0 =A0 msb =3D twl4030_madc_read(madc, reg + 1);
>> + =A0 =A0 lsb =3D twl4030_madc_read(madc, reg);
>> +
>> + =A0 =A0 return (int)(((msb << 8) | lsb) >> 6);
>> +}
>> +
>> +static int twl4030_madc_read_channels(struct twl4030_madc_data *mad=
c,
>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 reg_base, u16 channels, int *buf)
>> +{
>> + =A0 =A0 int count =3D 0;
>> + =A0 =A0 u8 reg, i;
>> +
>> + =A0 =A0 if (unlikely(!buf))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (channels & (1<<i)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg_base + 2*i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[i] =3D twl4030_madc_ch=
annel_raw_read(madc, reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return count;
>> +}
>> +
>> +static void twl4030_madc_enable_irq(struct twl4030_madc_data *madc,=
 int id)
>> +{
>> + =A0 =A0 u8 val;
>> +
>> + =A0 =A0 val =3D twl4030_madc_read(madc, madc->imr);
>> + =A0 =A0 val &=3D ~(1 << id);
>> + =A0 =A0 twl4030_madc_write(madc, madc->imr, val);
>> +}
>> +
>> +static void twl4030_madc_disable_irq(struct twl4030_madc_data *madc=
, int id)
>> +{
>> + =A0 =A0 u8 val;
>> +
>> + =A0 =A0 val =3D twl4030_madc_read(madc, madc->imr);
>> + =A0 =A0 val |=3D (1 << id);
>> + =A0 =A0 twl4030_madc_write(madc, madc->imr, val);
>> +}
>> +
>> +static irqreturn_t twl4030_madc_irq_handler(int irq, void *_madc)
>> +{
>> + =A0 =A0 struct twl4030_madc_data *madc =3D _madc;
>> + =A0 =A0 u8 isr_val, imr_val;
>> + =A0 =A0 int i;
>> +
>> +#ifdef CONFIG_LOCKDEP
>> + =A0 =A0 /* WORKAROUND for lockdep forcing IRQF_DISABLED on us, whi=
ch
>> + =A0 =A0 =A0* we don't want and can't tolerate. =A0Although it migh=
t be
>> + =A0 =A0 =A0* friendlier not to borrow this thread context...
>> + =A0 =A0 =A0*/
>> + =A0 =A0 local_irq_enable();
>> +#endif
> I'm curious, what's special about madc so that it can't tolerate that=
 ?

This was part of some bugfixes by David Brownell:
http://markmail.org/message/zlisiurni3ei6gst
TBH, I am not upto speed on the working of LOCKDEP.

>> + =A0 =A0 /* Use COR to ack interrupts since we have no shared IRQs =
in ISRx */
>> + =A0 =A0 isr_val =3D twl4030_madc_read(madc, madc->isr);
>> + =A0 =A0 imr_val =3D twl4030_madc_read(madc, madc->imr);
>> +
>> + =A0 =A0 isr_val &=3D ~imr_val;
>> +
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(isr_val & (1<<i)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_disable_irq(madc, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 madc->requests[i].result_pending =3D 1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 schedule_work(&madc->ws);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static void twl4030_madc_work(struct work_struct *ws)
>> +{
>> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 struct twl4030_madc_data *madc;
>> + =A0 =A0 struct twl4030_madc_request *r;
>> + =A0 =A0 int len, i;
>> +
>> + =A0 =A0 madc =3D container_of(ws, struct twl4030_madc_data, ws);
>> + =A0 =A0 mutex_lock(&madc->lock);
>> +
>> + =A0 =A0 for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 r =3D &madc->requests[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* No pending results for this method, mov=
e to next one */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!r->result_pending)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 method =3D &twl4030_conversion_methods[r->=
method];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Read results */
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D twl4030_madc_read_channels(madc, m=
ethod->rbase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0r->channels, r->rbuf);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Return results to caller */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (r->func_cb !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb(len, r->channel=
s, r->rbuf);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r->func_cb =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Free request */
>> + =A0 =A0 =A0 =A0 =A0 =A0 r->result_pending =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 r->active =A0 =A0 =A0 =A0 =3D 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&madc->lock);
>> +}
> I think you may want to consider using a threaded irq here, see
> request_threaded_irq().

I am working on moving the entire twl* driver set to use threaded irqs
on the side. Will you consider merging this code with the work_struct
since it is known to work while I work on the conversion?

>> +static int twl4030_madc_set_irq(struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct twl4030_madc_request *req)
>> +{
>> + =A0 =A0 struct twl4030_madc_request *p;
>> +
>> + =A0 =A0 p =3D &madc->requests[req->method];
>> +
>> + =A0 =A0 memcpy(p, req, sizeof *req);
>> +
>> + =A0 =A0 twl4030_madc_enable_irq(madc, req->method);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static inline void twl4030_madc_start_conversion(struct twl4030_mad=
c_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int conv_method)
>> +{
>> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> +
>> + =A0 =A0 method =3D &twl4030_conversion_methods[conv_method];
>> +
>> + =A0 =A0 switch (conv_method) {
>> + =A0 =A0 case TWL4030_MADC_SW1:
>> + =A0 =A0 case TWL4030_MADC_SW2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(madc, method->ctrl, TWL=
4030_MADC_SW_START);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case TWL4030_MADC_RT:
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +}
>> +
>> +static int twl4030_madc_wait_conversion_ready(
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct twl4030_madc_data *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout_ms, u8 status_reg)
>> +{
>> + =A0 =A0 unsigned long timeout;
>> +
>> + =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int reg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D twl4030_madc_read(madc, status_reg=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(reg < 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & TWL4030_MADC_BUSY) && (reg & T=
WL4030_MADC_EOC_SW))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 } while (!time_after(jiffies, timeout));
>> +
>> + =A0 =A0 return -EAGAIN;
>> +}
>> +
>> +static int twl4030_madc_set_power(struct twl4030_madc_data *madc, i=
nt on);
>> +int twl4030_madc_conversion(struct twl4030_madc_request *req)
>> +{
>> + =A0 =A0 const struct twl4030_madc_conversion_method *method;
>> + =A0 =A0 u8 ch_msb, ch_lsb;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (unlikely(!req))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 mutex_lock(&the_madc->lock);
>> +
>> + =A0 =A0 twl4030_madc_set_power(the_madc, 1);
>> +
>> + =A0 =A0 /* Do we have a conversion request ongoing */
>> + =A0 =A0 if (the_madc->requests[req->method].active) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ch_msb =3D (req->channels >> 8) & 0xff;
>> + =A0 =A0 ch_lsb =3D req->channels & 0xff;
>> +
>> + =A0 =A0 method =3D &twl4030_conversion_methods[req->method];
>> +
>> + =A0 =A0 /* Select channels to be converted */
>> + =A0 =A0 twl4030_madc_write(the_madc, method->sel + 1, ch_msb);
>> + =A0 =A0 twl4030_madc_write(the_madc, method->sel, ch_lsb);
>> +
>> + =A0 =A0 /* Select averaging for all channels if do_avg is set */
>> + =A0 =A0 if (req->do_avg) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg +=
 1, ch_msb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(the_madc, method->avg, =
ch_lsb);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if ((req->type =3D=3D TWL4030_MADC_IRQ_ONESHOT) && (req->f=
unc_cb !=3D NULL)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_set_irq(the_madc, req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_start_conversion(the_madc, re=
q->method);
>> + =A0 =A0 =A0 =A0 =A0 =A0 the_madc->requests[req->method].active =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* With RT method we should not be here anymore */
>> + =A0 =A0 if (req->method =3D=3D TWL4030_MADC_RT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 twl4030_madc_start_conversion(the_madc, req->method);
>> + =A0 =A0 the_madc->requests[req->method].active =3D 1;
>> +
>> + =A0 =A0 /* Wait until conversion is ready (ctrl register returns E=
OC) */
>> + =A0 =A0 ret =3D twl4030_madc_wait_conversion_ready(the_madc, 5, me=
thod->ctrl);
> So, you're busy looping with all conversions ? I have no idea how oft=
en this
> is called, but putting the caller to sleep on e.g. a waitqueue would =
be more
> elegant.

I suspect this was done for latency reasons since this is used for
battery charging software.
Mikko can you comment on this?

>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(the_madc->dev, "conversion timeout=
!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 the_madc->requests[req->method].active =3D=
 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D twl4030_madc_read_channels(the_madc, method->rbase=
, req->channels,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0req->rbuf);
>> +
>> + =A0 =A0 the_madc->requests[req->method].active =3D 0;
>> +
>> + =A0 =A0 twl4030_madc_set_power(the_madc, 0);
>> +
>> +out:
>> + =A0 =A0 mutex_unlock(&the_madc->lock);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(twl4030_madc_conversion);
> Who's supposed to use this one ?

Nokia AV accessory detection code uses this. So does the BCI battery
driver from TI. The BCI driver has been removed from the omap tree
pending the merge of the madc driver upstream.

>> +static int twl4030_madc_set_current_generator(struct twl4030_madc_d=
ata *madc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 int chan, int on)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 /* Current generator is only available for ADCIN0 and ADCI=
N1. NB:
>> + =A0 =A0 =A0* ADCIN1 current generator only works when AC or VBUS i=
s present */
>> + =A0 =A0 if (chan > 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return EINVAL;
>> +
>> + =A0 =A0 ret =3D twl4030_i2c_read_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &regva=
l, TWL4030_BCI_BCICTL1);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "unable to read registe=
r 0x%X\n", TWL4030_BCI_BCICTL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D (chan) ? TWL4030_BCI_ITHEN : T=
WL4030_BCI_TYPEN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_BCI_MESBAT;
>> + =A0 =A0 }
>> + =A0 =A0 else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D (chan) ? ~TWL4030_BCI_ITHEN : =
~TWL4030_BCI_TYPEN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~TWL4030_BCI_MESBAT;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg=
val, TWL4030_BCI_BCICTL1);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(madc->dev, "unable to write regist=
er 0x%X\n", TWL4030_BCI_BCICTL1);
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int twl4030_madc_set_power(struct twl4030_madc_data *madc, i=
nt on)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 if (on) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval =3D twl4030_madc_read(madc, TWL4030=
_MADC_CTRL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval |=3D TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(madc, TWL4030_MADC_CTRL=
1, regval);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D twl4030_madc_set_current_generato=
r(madc, 0, 1);
>> +
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D twl4030_madc_set_current_generato=
r(madc, 0, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval =3D twl4030_madc_read(madc, TWL4030=
_MADC_CTRL1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 regval &=3D ~TWL4030_MADC_MADCON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl4030_madc_write(madc, TWL4030_MADC_CTRL=
1, regval);
>> + =A0 =A0 }
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static long twl4030_madc_ioctl(struct file *filp, unsigned int cmd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng arg)
>> +{
>> + =A0 =A0 struct twl4030_madc_user_parms par;
>> + =A0 =A0 int val, ret;
>> +
>> + =A0 =A0 ret =3D copy_from_user(&par, (void __user *) arg, sizeof(p=
ar));
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(the_madc->dev, "copy_from_user: %d=
\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EACCES;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (cmd) {
>> + =A0 =A0 case TWL4030_MADC_IOCX_ADC_RAW_READ: {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct twl4030_madc_request req;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (par.channel >=3D TWL4030_MADC_MAX_CHAN=
NELS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 req.channels =3D (1 << par.channel);
>> + =A0 =A0 =A0 =A0 =A0 =A0 req.do_avg =A0 =A0 =A0=3D par.average;
>> + =A0 =A0 =A0 =A0 =A0 =A0 req.method =A0 =A0 =A0=3D TWL4030_MADC_SW1=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 req.func_cb =A0 =A0 =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 req.type =A0 =A0 =A0 =A0=3D TWL4030_MADC_W=
AIT;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D twl4030_madc_conversion(&req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (likely(val > 0)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par.status =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par.result =3D (u16)req.rb=
uf[par.channel];
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (val =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par.status =3D -ENODATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par.status =3D val;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0}
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D copy_to_user((void __user *) arg, &par, sizeof(par=
));
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(the_madc->dev, "copy_to_user: %d\n=
", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EACCES;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct file_operations twl4030_madc_fileops =3D {
>> + =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 .unlocked_ioctl =3D twl4030_madc_ioctl
>> +};
>> +
>> +static struct miscdevice twl4030_madc_device =3D {
>> + =A0 =A0 .minor =3D MISC_DYNAMIC_MINOR,
>> + =A0 =A0 .name =3D "twl4030-adc",
>> + =A0 =A0 .fops =3D &twl4030_madc_fileops
>> +};
>> +
>> +static int __init twl4030_madc_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct twl4030_madc_data *madc;
>> + =A0 =A0 struct twl4030_madc_platform_data *pdata =3D pdev->dev.pla=
tform_data;
>> +
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 regval;
>> +
>> + =A0 =A0 madc =3D kzalloc(sizeof *madc, GFP_KERNEL);
>> + =A0 =A0 if (!madc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "platform_data not ava=
ilable\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_pdata;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 madc->imr =3D (pdata->irq_line =3D=3D 1) ? TWL4030_MADC_IM=
R1 : TWL4030_MADC_IMR2;
>> + =A0 =A0 madc->isr =3D (pdata->irq_line =3D=3D 1) ? TWL4030_MADC_IS=
R1 : TWL4030_MADC_ISR2;
>> +
>> + =A0 =A0 ret =3D misc_register(&twl4030_madc_device);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "could not register mi=
sc_device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_misc;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D request_irq(platform_get_irq(pdev, 0), twl4030_mad=
c_irq_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, "twl4030_madc", mad=
c);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "could not request irq=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, madc);
>> + =A0 =A0 mutex_init(&madc->lock);
>> + =A0 =A0 INIT_WORK(&madc->ws, twl4030_madc_work);
>> +
>> + =A0 =A0 the_madc =3D madc;
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_irq:
>> + =A0 =A0 misc_deregister(&twl4030_madc_device);
>> +
>> +err_misc:
>> +err_pdata:
>> + =A0 =A0 kfree(madc);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __exit twl4030_madc_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct twl4030_madc_data *madc =3D platform_get_drvdata(pd=
ev);
>> +
>> + =A0 =A0 free_irq(platform_get_irq(pdev, 0), madc);
>> + =A0 =A0 cancel_work_sync(&madc->ws);
>> + =A0 =A0 misc_deregister(&twl4030_madc_device);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver twl4030_madc_driver =3D {
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D twl4030_madc_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(twl4030_madc_remove),
>> + =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "twl4030_madc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init twl4030_madc_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&twl4030_madc_driver);
>> +}
>> +module_init(twl4030_madc_init);
>> +
>> +static void __exit twl4030_madc_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&twl4030_madc_driver);
>> +}
>> +module_exit(twl4030_madc_exit);
>> +
>> +MODULE_ALIAS("platform:twl4030-madc");
>> +MODULE_AUTHOR("Nokia Corporation");
>> +MODULE_DESCRIPTION("twl4030 ADC driver");
>> +MODULE_LICENSE("GPL");
>> +
>> diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/tw=
l4030-madc.h
>> new file mode 100644
>> index 0000000..24523b5
>> --- /dev/null
>> +++ b/include/linux/i2c/twl4030-madc.h
>> @@ -0,0 +1,126 @@
>> +/*
>> + * include/linux/i2c/twl4030-madc.h
>> + *
>> + * TWL4030 MADC module driver header
>> + *
>> + * Copyright (C) 2008 Nokia Corporation
>> + * Mikko Ylinen <mikko.k.ylinen@nokia.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#ifndef _TWL4030_MADC_H
>> +#define _TWL4030_MADC_H
>> +
>> +struct twl4030_madc_conversion_method {
>> + =A0 =A0 u8 sel;
>> + =A0 =A0 u8 avg;
>> + =A0 =A0 u8 rbase;
>> + =A0 =A0 u8 ctrl;
>> +};
>> +
>> +#define TWL4030_MADC_MAX_CHANNELS 16
>> +
>> +struct twl4030_madc_request {
>> + =A0 =A0 u16 channels;
>> + =A0 =A0 u16 do_avg;
>> + =A0 =A0 u16 method;
>> + =A0 =A0 u16 type;
>> + =A0 =A0 int active;
>> + =A0 =A0 int result_pending;
> active and result_pending can be bool.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>
