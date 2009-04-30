From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH] input: Add support for the TSC2003 controller.
Date: Thu, 30 Apr 2009 10:35:41 +0900
Message-ID: <483a38b80904291835p51044741p9bd83d33a40031c@mail.gmail.com>
References: <1241006627-22811-1-git-send-email-thierry.reding@avionic-design.de>
	 <5d5443650904290623n3712cd7dja653a139cff2cf6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <5d5443650904290623n3712cd7dja653a139cff2cf6d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Thierry and Trilok,

On Wed, Apr 29, 2009 at 10:23 PM, Trilok Soni <soni.trilok@gmail.com> w=
rote:
> Hi Thierry,
>
> I have added linux-omap community. How different is this chip from
> tsc2007. It looks to me that this chip is not much different from
> tsc2007 (this is just quick look at the driver). If they
> are similar please consider using i2c_device_id feature in tsc2007 to
> accommodate this chip.

I agree with the Trilok's opinion.
And some comments about the codes below..

> On Wed, Apr 29, 2009 at 5:33 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
>> This patch implements touchscreen support for the TSC2003 controller=
=2E There is
>> no support for the temperature sensor yet.
>>
>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>> ---
>> =A0drivers/input/touchscreen/Kconfig =A0 | =A0 =A08 +
>> =A0drivers/input/touchscreen/Makefile =A0| =A0 =A01 +
>> =A0drivers/input/touchscreen/tsc2003.c | =A0416 ++++++++++++++++++++=
+++++++++++++++
>> =A0include/linux/i2c/tsc2003.h =A0 =A0 =A0 =A0 | =A0 28 +++
>> =A04 files changed, 453 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touch=
screen/Kconfig
>> index b01fd61..87b980c 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -455,6 +455,14 @@ config TOUCHSCREEN_TOUCHIT213
>> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here=
: the
>> =A0 =A0 =A0 =A0 =A0module will be called touchit213.
>>
>> +config TOUCHSCREEN_TSC2003
>> + =A0 =A0 =A0 tristate "Texas Instruments TSC2003 Touchscreen Contro=
ller"
>> + =A0 =A0 =A0 depends on I2C
>> + =A0 =A0 =A0 ---help---
>> + =A0 =A0 =A0 =A0 If you say yes here you get support for the Texas =
Instruments
>> + =A0 =A0 =A0 =A0 TSC2003 Touchscreen Controller with on-chip temper=
ature
>> + =A0 =A0 =A0 =A0 measurement.
>> +
>> =A0config TOUCHSCREEN_TSC2007
>> =A0 =A0 =A0 =A0tristate "TSC2007 based touchscreens"
>> =A0 =A0 =A0 =A0depends on I2C
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touc=
hscreen/Makefile
>> index 6700f7b..e965422 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -27,6 +27,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT) =A0 =A0+=3D pen=
mount.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) =A0 +=3D touchit213.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) =A0 +=3D touchright.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =A0 =A0 +=3D touchwin.o
>> +obj-$(CONFIG_TOUCHSCREEN_TSC2003) =A0 =A0 =A0+=3D tsc2003.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =A0 =A0 =A0+=3D tsc2007.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =A0 =A0 =A0+=3D ucb1400_ts.o
>> =A0obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001) =A0+=3D wacom_w8001.o
>> diff --git a/drivers/input/touchscreen/tsc2003.c b/drivers/input/tou=
chscreen/tsc2003.c
>> new file mode 100644
>> index 0000000..5acaa0d
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/tsc2003.c
>> @@ -0,0 +1,416 @@
>> +/*
>> + * linux/drivers/input/touchscreen/tsc2003.c
>> + *
>> + * Copyright (C) 2007-2008 Avionic Design Development GmbH
>> + * Copyright (C) 2008-2009 Avionic Design GmbH
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * Written by Thierry Reding <thierry.reding@avionic-design.de>
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/i2c/tsc2003.h>
>> +
>> +#define =A0 =A0 =A0 =A0DRIVER_NAME =A0 =A0 "tsc2003"
>> +#define =A0 =A0 =A0 =A0DRIVER_VERSION =A0"1"
>> +
>> +/* basic commands */
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_TEMPERATURE_0 =A0 =A0 =A0 0x00
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_BATTERY_1 =A0 =A0 =A0 =A0 =A0 0x=
10
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_INPUT_1 =A0 =A0 =A0 =A0 =A0 =A0 =
0x20
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_TEMPERATURE_1 =A0 =A0 =A0 0x40
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_BATTERY_2 =A0 =A0 =A0 =A0 =A0 0x=
50
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_INPUT_2 =A0 =A0 =A0 =A0 =A0 =A0 =
0x60
>> +#define =A0 =A0 =A0 =A0CMD_ACTIVATE_X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x80
>> +#define =A0 =A0 =A0 =A0CMD_ACTIVATE_Y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x90
>> +#define =A0 =A0 =A0 =A0CMD_ACTIVATE_XY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0xA0
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_X =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0xC0
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_Y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0xD0
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_Z1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00xE0
>> +#define =A0 =A0 =A0 =A0CMD_MEASURE_Z2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00xF0
>> +
>> +/* powerdown modes */
>> +#define =A0 =A0 =A0 =A0PDM_POWERDOWN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00
>> +#define =A0 =A0 =A0 =A0PDM_IR_OFF_ADC_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x04
>> +#define =A0 =A0 =A0 =A0PDM_IR_ON_ADC_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x08
>> +#define =A0 =A0 =A0 =A0PDM_IR_ON_ADC_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x0A
>> +#define =A0 =A0 =A0 =A0PDM_TOUCH_IRQ_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x04
>> +

Most of the commands are same with tsc2007.

struct tsc2007 has a member variable named model in tsc2007 driver.
It is acquired from platform_data. So I think it can be used to
distinguish chipsets.

>> +/* data width modes */
>> +#define =A0 =A0 =A0 =A0MODE_12BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x00
>> +#define =A0 =A0 =A0 =A0MODE_8BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0x02
>> +
>> +/* periodic polling delay and period */
>> +#define =A0 =A0 =A0 =A0TS_POLL_DELAY =A0 (1 * 1000000)
>> +#define =A0 =A0 =A0 =A0TS_POLL_PERIOD =A0(5 * 1000000)
>> +
>> +/**
>> + * struct ts_event - touchscreen event structure
>> + * @pendown: =A0 state of the pen
>> + * @x: =A0 =A0 =A0 =A0 X-coordinate of the event
>> + * @y: =A0 =A0 =A0 =A0 Y-coordinate of the event
>> + * @z: =A0 =A0 =A0 =A0 pressure of the event
>> + */
>> +struct ts_event {
>> + =A0 =A0 =A0 short pendown;
>> + =A0 =A0 =A0 short x;
>> + =A0 =A0 =A0 short y;
>> + =A0 =A0 =A0 short z;
>> +};
>> +
>> +/**
>> + * struct tsc2003 - touchscreen controller context
>> + * @client: =A0 =A0I2C client
>> + * @input: =A0 =A0 touchscreen input device
>> + * @lock: =A0 =A0 =A0lock for resource protection
>> + * @timer: =A0 =A0 timer for periodical polling
>> + * @work: =A0 =A0 =A0workqueue structure
>> + * @pendown: =A0 current pen state
>> + * @event: =A0 =A0 current touchscreen event
>> + * @pdata: =A0 =A0 platform-specific information
>> + */
>> +struct tsc2003 {
>> + =A0 =A0 =A0 struct i2c_client *client;
>> + =A0 =A0 =A0 struct input_dev *input;
>> + =A0 =A0 =A0 spinlock_t lock;
>> + =A0 =A0 =A0 struct hrtimer timer;
>> + =A0 =A0 =A0 struct work_struct work;
>> +
>> + =A0 =A0 =A0 struct ts_event event;
>> + =A0 =A0 =A0 unsigned pendown:1;
>> +
>> + =A0 =A0 =A0 struct tsc2003_platform_data *pdata;
>> +};
>> +
>> +/**
>> + * tsc2003_get_pendown_state() - obtain the current pen state
>> + * @ts: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0touchscreen controller conte=
xt
>> + */
>> +static int tsc2003_get_pendown_state(struct tsc2003 *ts)
>> +{
>> + =A0 =A0 =A0 int state =3D 0;
>> +
>> + =A0 =A0 =A0 if (ts && ts->pdata && ts->pdata->get_irq_level)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D !ts->pdata->get_irq_level();
>> +
>> + =A0 =A0 =A0 return state;
>> +}
>> +
>> +/**
>> + * tsc2003_read() - send a command and read the response
>> + * @client: =A0 =A0I2C client
>> + * @command: =A0 command to send
>> + */
>> +static int tsc2003_read(struct i2c_client *client, u8 command)
>> +{
>> + =A0 =A0 =A0 u8 value[2] =3D { 0, 0 };
>> + =A0 =A0 =A0 int size =3D 2;
>> + =A0 =A0 =A0 int status;
>> +
>> + =A0 =A0 =A0 command &=3D ~MODE_8BIT;
>> +
>> + =A0 =A0 =A0 status =3D i2c_master_send(client, &command, 1);
>> + =A0 =A0 =A0 if (status < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
>> +
>> + =A0 =A0 =A0 if (command & MODE_8BIT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D 1;
>> +
>> + =A0 =A0 =A0 status =3D i2c_master_recv(client, value, size);
>> + =A0 =A0 =A0 if (status < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
>> +
>> + =A0 =A0 =A0 if (command & MODE_8BIT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return value[0];
>> +
>> + =A0 =A0 =A0 return (value[0] << 4) | (value[1] >> 4);
>> +}

Jean said that these two APIs can be racy in tsc2007 driver.
So I used i2c_smbus_read_word_data() to replace it.

>> +
>> +/**
>> + * tsc2003_read_x() - read touch screen X-coordinate
>> + * @client: =A0 =A0I2C client
>> + * @pdm: =A0 =A0 =A0 powerdown mode
>> + * @samples: =A0 number of samples to average over
>> + */
>> +static int tsc2003_read_x(struct i2c_client *client, u8 pdm, int sa=
mples)
>> +{
>> + =A0 =A0 =A0 return tsc2003_read(client, CMD_MEASURE_X | pdm);
>> +}
>> +
>> +/**
>> + * tsc2003_read_y() - read touch screen Y-coordinate
>> + * @client: =A0 =A0I2C client
>> + * @pdm: =A0 =A0 =A0 powerdown mode
>> + * @samples: =A0 number of samples to average over
>> + */
>> +static int tsc2003_read_y(struct i2c_client *client, u8 pdm, int sa=
mples)
>> +{
>> + =A0 =A0 =A0 return tsc2003_read(client, CMD_MEASURE_Y | pdm);
>> +}
>> +
>> +/**
>> + * tsc2003_read_z() - read touch screen pressure
>> + * @client: =A0 =A0I2C client
>> + * @pdm: =A0 =A0 =A0 powerdown mode
>> + * @samples: =A0 number of samples to average over
>> + */
>> +static int tsc2003_read_z(struct i2c_client *client, u8 pdm, int sa=
mples)
>> +{
>> + =A0 =A0 =A0 int p1 =3D tsc2003_read(client, CMD_MEASURE_Z1 | pdm);
>> + =A0 =A0 =A0 int p2 =3D tsc2003_read(client, CMD_MEASURE_Z2 | pdm);
>> +
>> + =A0 =A0 =A0 p2 =3D 0;
>> +
>> + =A0 =A0 =A0 return p1;
>> +}
>> +
>> +/**
>> + * tsc2003_timer() - timer callback function
>> + * @timer: =A0 =A0 timer that caused this function call
>> + */
>> +static enum hrtimer_restart tsc2003_timer(struct hrtimer *timer)
>> +{
>> + =A0 =A0 =A0 struct tsc2003 *ts =3D container_of(timer, struct tsc2=
003, timer);
>> + =A0 =A0 =A0 unsigned long flags =3D 0;
>> + =A0 =A0 =A0 int state =3D 0;
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&ts->lock, flags);
>> +
>> + =A0 =A0 =A0 state =3D tsc2003_get_pendown_state(ts);
>> + =A0 =A0 =A0 if (state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset if this is the first pen down=
 event */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ts->pendown) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->event.pendown =3D =
0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pendown =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&ts->work);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable IRQ after the pen was lifted=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ts->pendown)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pendown =3D 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(ts->input, BTN_TOUCH,=
 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(ts->input, ABS_PRESSU=
RE, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(ts->input);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(ts->client->irq);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&ts->lock, flags);
>> + =A0 =A0 =A0 return HRTIMER_NORESTART;
>> +}
>> +
>> +/**
>> + * tsc2003_work() - work queue handler (initiated by the interrupt =
handler)
>> + * @work: =A0 =A0 =A0work queue to handle
>> + */
>> +static void tsc2003_work(struct work_struct *work)
>> +{
>> + =A0 =A0 =A0 struct tsc2003 *ts =3D container_of(work, struct tsc20=
03, work);
>> +
>> + =A0 =A0 =A0 /* report only the first pen down event */
>> + =A0 =A0 =A0 if (!ts->event.pendown) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(ts->input, BTN_TOUCH,=
 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->event.pendown =3D 1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* read X- and Y-coordinates and the pressure */
>> + =A0 =A0 =A0 ts->event.x =3D tsc2003_read_x(ts->client, PDM_POWERDO=
WN, 1);
>> + =A0 =A0 =A0 ts->event.y =3D tsc2003_read_y(ts->client, PDM_POWERDO=
WN, 1);
>> + =A0 =A0 =A0 ts->event.z =3D tsc2003_read_z(ts->client, PDM_POWERDO=
WN, 1);
>> +
>> + =A0 =A0 =A0 /* report X- and Y-coordinates and the pressure */
>> + =A0 =A0 =A0 input_report_abs(ts->input, ABS_X, ts->event.x);
>> + =A0 =A0 =A0 input_report_abs(ts->input, ABS_Y, ts->event.y);
>> + =A0 =A0 =A0 input_report_abs(ts->input, ABS_PRESSURE, ts->event.z)=
;
>> + =A0 =A0 =A0 input_sync(ts->input);
>> +
>> + =A0 =A0 =A0 /* restart the timer */
>> + =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD)=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HRTIMER_MODE_REL);
>> +}
>> +
>> +/**
>> + * tsc2003_interrupt() - interrupt handler for touch events
>> + * @irq: =A0 =A0 =A0 interrupt to handle
>> + * @dev_id: =A0 =A0device-specific information
>> + */
>> +static irqreturn_t tsc2003_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 struct i2c_client *client =3D (struct i2c_client *)dev=
_id;
>> + =A0 =A0 =A0 struct tsc2003 *ts =3D i2c_get_clientdata(client);
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&ts->lock, flags);
>> +
>> + =A0 =A0 =A0 /* if the pen is down, disable IRQ and start timer cha=
in */
>> + =A0 =A0 =A0 if (tsc2003_get_pendown_state(ts)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(client->irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ts->timer, ktime_set(0,=
 TS_POLL_DELAY),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HRTIME=
R_MODE_REL);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&ts->lock, flags);
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * tsc2003_probe() - initialize the I2C client
>> + * @client: =A0 =A0client to initialize
>> + * @id: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C device ID
>> + */
>> +static int tsc2003_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_id *id)
>> +{
>> + =A0 =A0 =A0 struct tsc2003 *ts;
>> + =A0 =A0 =A0 int err =3D 0;
>> +
>> + =A0 =A0 =A0 ts =3D kzalloc(sizeof(*ts), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!ts) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ts->client =3D client;
>> +
>> + =A0 =A0 =A0 ts->input =3D input_allocate_device();
>> + =A0 =A0 =A0 if (!ts->input) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* setup the input device */
>> + =A0 =A0 =A0 ts->input->name =3D "Texas Instruments TSC2003 I2C Tou=
chscreen";
>> + =A0 =A0 =A0 ts->input->phys =3D DRIVER_NAME "/input0";
>> + =A0 =A0 =A0 ts->input->id.bustype =3D BUS_I2C;
>> + =A0 =A0 =A0 ts->input->dev.parent =3D &client->dev;
>> +
>> + =A0 =A0 =A0 ts->input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV=
_ABS);
>> + =A0 =A0 =A0 ts->input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BT=
N_TOUCH);
>> + =A0 =A0 =A0 input_set_abs_params(ts->input, ABS_X, 0, 0x3ff, 0, 0)=
;
>> + =A0 =A0 =A0 input_set_abs_params(ts->input, ABS_Y, 0, 0x3ff, 0, 0)=
;
>> + =A0 =A0 =A0 input_set_abs_params(ts->input, ABS_PRESSURE, 0, 0x3ff=
, 0, 0);
>> +
>> + =A0 =A0 =A0 /* setup platform-specific hooks */
>> + =A0 =A0 =A0 ts->pdata =3D client->dev.platform_data;
>> + =A0 =A0 =A0 if (!ts->pdata || !ts->pdata->init_irq || !ts->pdata->=
get_irq_level) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "no platform-spe=
cific callbacks "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "provi=
ded\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENXIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (ts->pdata->init_irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D ts->pdata->init_irq();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, =
"failed to initialize IRQ#%d: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "%d\n", client->irq, err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_lock_init(&ts->lock);
>> + =A0 =A0 =A0 hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL);
>> + =A0 =A0 =A0 ts->timer.function =3D tsc2003_timer;
>> + =A0 =A0 =A0 INIT_WORK(&ts->work, tsc2003_work);
>> + =A0 =A0 =A0 ts->pendown =3D 0;
>> +
>> + =A0 =A0 =A0 err =3D request_irq(client->irq, tsc2003_interrupt, IR=
QF_SHARED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TSC2003 Touch Screen"=
, client);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "failed to reque=
st IRQ#%d: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client=
->irq, err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 i2c_set_clientdata(client, ts);
>> +
>> + =A0 =A0 =A0 err =3D input_register_device(ts->input);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "failed to regis=
ter input device: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_irq;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* dummy read; necessary to enable the pen IRQ */
>> + =A0 =A0 =A0 (void)tsc2003_read_z(client, PDM_POWERDOWN, 1);
>> + =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 goto out;
>> +
>> +fail_irq:
>> + =A0 =A0 =A0 free_irq(client->irq, client);
>> +
>> +fail:
>> + =A0 =A0 =A0 if (ts) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(ts->input);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(ts);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>> +out:
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +/**
>> + * tsc2003_remove() - cleanup the I2C client
>> + * @client: =A0 =A0client to clean up
>> + */
>> +static int tsc2003_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 struct tsc2003 *priv =3D i2c_get_clientdata(client);
>> +
>> + =A0 =A0 =A0 free_irq(client->irq, client);
>> + =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>> + =A0 =A0 =A0 input_unregister_device(priv->input);
>> + =A0 =A0 =A0 kfree(priv);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static const struct i2c_device_id tsc2003_ids[] =3D {
>> + =A0 =A0 =A0 { DRIVER_NAME, 0 },
>> + =A0 =A0 =A0 { }
>> +};
>> +
>> +/* TSC2003 I2C driver */
>> +static struct i2c_driver tsc2003_driver =3D {
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DRIVER_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .probe =3D tsc2003_probe,
>> + =A0 =A0 =A0 .remove =3D __devexit_p(tsc2003_remove),
>> + =A0 =A0 =A0 .id_table =3D tsc2003_ids,
>> +};
>> +
>> +/**
>> + * tsc2003_init() - module initialization
>> + */
>> +static int __init tsc2003_init(void)
>> +{
>> + =A0 =A0 =A0 return i2c_add_driver(&tsc2003_driver);
>> +}
>> +
>> +/**
>> + * tsc2003_exit() - module cleanup
>> + */
>> +static void __exit tsc2003_exit(void)
>> +{
>> + =A0 =A0 =A0 i2c_del_driver(&tsc2003_driver);
>> +}
>> +
>> +module_init(tsc2003_init);
>> +module_exit(tsc2003_exit);
>> +
>> +MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
>> +MODULE_DESCRIPTION("Texas Instruments TSC2003 I2C Touch Screen driv=
er");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_VERSION(DRIVER_VERSION);
>> +
>> diff --git a/include/linux/i2c/tsc2003.h b/include/linux/i2c/tsc2003=
=2Eh
>> new file mode 100644
>> index 0000000..45e6100
>> --- /dev/null
>> +++ b/include/linux/i2c/tsc2003.h
>> @@ -0,0 +1,28 @@
>> +/**
>> + * linux/include/i2c/tsc2003.h
>> + *
>> + * Copyright (C) 2007-2008 Avionic Design Development GmbH
>> + * Copyright (C) 2008-2009 Avionic Design GmbH
>> + *
>> + * This file is subject to the terms and conditions of the GNU Gene=
ral Public
>> + * License. See the file COPYING in the main directory of this arch=
ive for
>> + * more details.
>> + *
>> + * Written by Thierry Reding <thierry.reding@avionic-design.de>
>> + */
>> +
>> +#ifndef LINUX_I2C_TSC2003_H
>> +#define LINUX_I2C_TSC2003_H
>> +
>> +/**
>> + * struct tsc2003_platform_data - platform-specific TSC2003 data
>> + * @init_irq: =A0 =A0 =A0 =A0 =A0initialize interrupt
>> + * @get_irq_level: =A0 =A0 obtain current interrupt level
>> + */
>> +struct tsc2003_platform_data {
>> + =A0 =A0 =A0 int (*init_irq)(void);
>> + =A0 =A0 =A0 int (*get_irq_level)(void);
>> +};
>> +
>> +#endif /* !LINUX_I2C_TSC2003_H */
>> +
>> --
>> tg: (fb160d7..) adx/i2c/tsc2003 (depends on: adx/master)
>> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
