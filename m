From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [RESEND][PATCH] input: Added TSC2003
Date: Mon, 15 Jun 2009 23:40:05 +0530
Message-ID: <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com>
References: <4A366439.70005@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:47504 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbZFOSPF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 14:15:05 -0400
In-Reply-To: <4A366439.70005@mocean-labs.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

Hi,

On Mon, Jun 15, 2009 at 8:39 PM, Richard
R=F6jfors<richard.rojfors.ext@mocean-labs.com> wrote:
> Supplied is a driver for the TSC2003. There is actually a driver for =
TSC2007 which can be used in some cases.
> The platform struct is reused from the TSC2007.
> There is a big difference in the implementation between the drivers, =
this one does not use HR timers.
> The TSC2007 driver performs synchronous I2C in the timer callback (SW=
 IRQ context) which is bad when
> the I2C driver is interrupt driven.
>

Meaning? I think I2C transaction can sleep. I don't see (right now)
need for two drivers. TSC2003 id was added to TSC2007. If you think
TSC2007 doesn't provide enough support for it, then please add that in
TSC2007 driver itself. We don't need create another driver it seems.

I have added Thierry who can further comment on it, as he has access
to device with TSC2003.

>
> Signed-off-by: Richard R=F6jfors <richard.rojfors.ext@mocean-labs.com=
>
> ---
> Index: linux-2.6.30-rc7/drivers/input/touchscreen/tsc2003.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.30-rc7/drivers/input/touchscreen/tsc2003.c =A0 =A0 =A0 =
=A0(revision 0)
> +++ linux-2.6.30-rc7/drivers/input/touchscreen/tsc2003.c =A0 =A0 =A0 =
=A0(revision 869)
> @@ -0,0 +1,387 @@
> +/*
> + * tsc2003.c Driver for TI TSC2003 touch screen controller
> + * Copyright (c) 2009 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/* Supports:
> + * TI TSC2003
> + *
> + * Inspired by tsc2007, Copyright (c) 2008 MtekVision Co., Ltd.
> + */
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/tsc2007.h>
> +#include <linux/kthread.h>
> +#include <linux/semaphore.h>
> +
> +#define TSC2003_DRIVER_NAME =A0 =A0 =A0 =A0 =A0 =A0"tsc2003"
> +
> +#define TS_POLL_PERIOD 20 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* ms delay bet=
ween samples */
> +
> +#define TSC2003_MEASURE_TEMP0 =A0 =A0 =A0 =A0 =A0(0x0 << 4)
> +#define TSC2003_MEASURE_AUX =A0 =A0 =A0 =A0 =A0 =A0(0x2 << 4)
> +#define TSC2003_MEASURE_TEMP1 =A0 =A0 =A0 =A0 =A0(0x4 << 4)
> +#define TSC2003_ACTIVATE_XN =A0 =A0 =A0 =A0 =A0 =A0(0x8 << 4)
> +#define TSC2003_ACTIVATE_YN =A0 =A0 =A0 =A0 =A0 =A0(0x9 << 4)
> +#define TSC2003_ACTIVATE_YP_XN =A0 =A0 =A0 =A0 (0xa << 4)
> +#define TSC2003_SETUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xb << 4)
> +#define TSC2003_MEASURE_X =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xc << 4)
> +#define TSC2003_MEASURE_Y =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xd << 4)
> +#define TSC2003_MEASURE_Z1 =A0 =A0 =A0 =A0 =A0 =A0 (0xe << 4)
> +#define TSC2003_MEASURE_Z2 =A0 =A0 =A0 =A0 =A0 =A0 (0xf << 4)
> +
> +#define TSC2003_POWER_OFF_IRQ_EN =A0 =A0 =A0 (0x0 << 2)
> +#define TSC2003_ADC_ON_IRQ_DIS0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 =
<< 2)
> +#define TSC2003_ADC_OFF_IRQ_EN =A0 =A0 =A0 =A0 (0x2 << 2)
> +#define TSC2003_ADC_ON_IRQ_DIS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 =
<< 2)
> +
> +#define TSC2003_12BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x0 << 1)
> +#define TSC2003_8BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1 << 1)
> +
> +#define =A0 =A0 =A0 =A0MAX_12BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ((1 << 12) - 1)
> +
> +#define ADC_ON_12BIT =A0 (TSC2003_12BIT | TSC2003_ADC_ON_IRQ_DIS0)
> +
> +#define READ_Y =A0 =A0 =A0 =A0 (ADC_ON_12BIT | TSC2003_MEASURE_Y)
> +#define READ_Z1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ADC_ON_12BIT | TSC20=
03_MEASURE_Z1)
> +#define READ_Z2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ADC_ON_12BIT | TSC20=
03_MEASURE_Z2)
> +#define READ_X =A0 =A0 =A0 =A0 (ADC_ON_12BIT | TSC2003_MEASURE_X)
> +#define PWRDOWN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(TSC2003_12BIT | TSC2=
003_POWER_OFF_IRQ_EN)
> +
> +struct ts_event {
> + =A0 =A0 =A0 int =A0 =A0 x;
> + =A0 =A0 =A0 int =A0 =A0 y;
> + =A0 =A0 =A0 int =A0 =A0 z1, z2;
> +};
> +
> +struct tsc2003 {
> + =A0 =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input;
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys[32];
> + =A0 =A0 =A0 struct task_struct =A0 =A0 =A0*task;
> + =A0 =A0 =A0 struct ts_event =A0 =A0 =A0 =A0 tc;
> + =A0 =A0 =A0 struct completion =A0 =A0 =A0 penirq_completion;
> +
> + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> +
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 model;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x_plate_ohm=
s;
> +
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pendown;
> +};
> +
> +static inline int tsc2003_xfer(struct tsc2003 *tsc, u8 cmd)
> +{
> + =A0 =A0 =A0 s32 data;
> + =A0 =A0 =A0 u16 val;
> +
> + =A0 =A0 =A0 data =3D i2c_smbus_read_word_data(tsc->client, cmd);
> + =A0 =A0 =A0 if (data < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&tsc->client->dev, "i2c io erro=
r: %d\n", data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* The protocol and raw data format from i2c interface:
> + =A0 =A0 =A0 =A0* S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [=
DataHigh] NA P
> + =A0 =A0 =A0 =A0* Where DataLow has [D11-D4], DataHigh has [D3-D0 <<=
 4 | Dummy 4bit].
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 val =3D swab16(data) >> 4;
> +
> + =A0 =A0 =A0 dev_dbg(&tsc->client->dev, "data: 0x%x, val: 0x%x\n", d=
ata, val);
> +
> + =A0 =A0 =A0 return val;
> +}
> +
> +static void tsc2003_send_event(void *tsc)
> +{
> + =A0 =A0 =A0 struct tsc2003 =A0*ts =3D tsc;
> + =A0 =A0 =A0 struct input_dev *input =3D ts->input;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 rt =3D 0;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 x, y, z1, z2;
> +
> + =A0 =A0 =A0 x =3D ts->tc.x;
> + =A0 =A0 =A0 y =3D ts->tc.y;
> + =A0 =A0 =A0 z1 =3D ts->tc.z1;
> + =A0 =A0 =A0 z2 =3D ts->tc.z2;
> +
> + =A0 =A0 =A0 /* range filtering */
> + =A0 =A0 =A0 if (x =3D=3D MAX_12BIT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 x =3D 0;
> +
> + =A0 =A0 =A0 if (likely(x && z1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* compute touch pressure resistance us=
ing equation #1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt =3D z2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt -=3D z1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt *=3D x;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt *=3D ts->x_plate_ohms;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt /=3D z1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt =3D (rt + 2047) >> 12;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Sample found inconsistent by debouncing or pressure =
is beyond
> + =A0 =A0 =A0 =A0* the maximum. Don't report it to user space, repeat=
 at least
> + =A0 =A0 =A0 =A0* once more the measurement
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rt > MAX_12BIT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* NOTE: We can't rely on the pressure to determine the=
 pen down
> + =A0 =A0 =A0 =A0* state, even this controller has a pressure sensor.=
 =A0The pressure
> + =A0 =A0 =A0 =A0* value can fluctuate for quite a while after liftin=
g the pen and
> + =A0 =A0 =A0 =A0* in some cases may not even settle at the expected =
value.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The only safe way to check for the pen up conditio=
n is in the
> + =A0 =A0 =A0 =A0* timer by reading the pen signal state (it's a GPIO=
 _and_ IRQ).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rt) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ts->pendown) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&ts->client->de=
v, "DOWN\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_TOUCH, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pendown =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, r=
t);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&ts->client->dev, "point(%4d,%4=
d), pressure (%4u)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x, y, rt);
> + =A0 =A0 =A0 } else if (ts->pendown) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* pen up */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&ts->client->dev, "UP\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, 0=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts->pendown =3D 0;
> + =A0 =A0 =A0 }
> +}
> +
> +static int tsc2003_power_off_irq_en(struct tsc2003 *tsc)
> +{
> + =A0 =A0 =A0 /* power down */
> + =A0 =A0 =A0 return tsc2003_xfer(tsc, PWRDOWN);
> +}
> +
> +static int tsc2003_read_values(struct tsc2003 *tsc)
> +{
> + =A0 =A0 =A0 /* y- still on; turn on only y+ (and ADC) */
> + =A0 =A0 =A0 tsc->tc.y =3D tsc2003_xfer(tsc, READ_Y);
> + =A0 =A0 =A0 if (tsc->tc.y < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tsc->tc.y;
> +
> + =A0 =A0 =A0 /* turn y- off, x+ on, then leave in lowpower */
> + =A0 =A0 =A0 tsc->tc.x =3D tsc2003_xfer(tsc, READ_X);
> + =A0 =A0 =A0 if (tsc->tc.x < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tsc->tc.x;
> +
> + =A0 =A0 =A0 /* turn y+ off, x- on; we'll use formula #1 */
> + =A0 =A0 =A0 tsc->tc.z1 =3D tsc2003_xfer(tsc, READ_Z1);
> + =A0 =A0 =A0 if (tsc->tc.z1 < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tsc->tc.z1;
> +
> + =A0 =A0 =A0 tsc->tc.z2 =3D tsc2003_xfer(tsc, READ_Z2);
> + =A0 =A0 =A0 if (tsc->tc.z2 < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return tsc->tc.z2;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +static irqreturn_t tsc2003_irq(int irq, void *handle)
> +{
> + =A0 =A0 =A0 struct tsc2003 *ts =3D handle;
> +
> + =A0 =A0 =A0 /* do not call the synced version -> deadlock */
> + =A0 =A0 =A0 disable_irq_nosync(irq);
> + =A0 =A0 =A0 /* signal the thread to continue */
> + =A0 =A0 =A0 complete(&ts->penirq_completion);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int tsc2003_thread(void *d)
> +{
> + =A0 =A0 =A0 struct tsc2003 *ts =3D (struct tsc2003 *)d;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 allow_signal(SIGKILL);
> +
> + =A0 =A0 =A0 while (!signal_pending(current)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* power down and wait for interrupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop because the I2C=
 bus might be busy */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D msleep_interrup=
tible(TS_POLL_PERIOD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 tsc2003_power_off_irq_en(ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (ret =3D=3D -EAGAIN && !signal_=
pending(current));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (signal_pending(current))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D wait_for_completion_interruptib=
le(&ts->penirq_completion);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int first =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* got IRQ, start poll,=
 until pen is up */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!ret && !signal_=
pending(current)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (fir=
st || ts->pendown)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 tsc2003_read_values(ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!re=
t)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tsc2003_send_event(ts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 msleep_interruptible(TS_POLL_PERIOD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 first =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we re enable the int=
errupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!signal_pending(cur=
rent))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_=
irq(ts->client->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tsc2003_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device=
_id *id)
> +{
> + =A0 =A0 =A0 struct tsc2003 *ts;
> + =A0 =A0 =A0 struct tsc2007_platform_data *pdata =3D client->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "platform data is=
 required!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0I2C_FUNC_SMBUS_READ_WORD_DATA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 ts =3D kzalloc(sizeof(struct tsc2003), GFP_KERNEL);
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!ts || !input_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ts->client =3D client;
> + =A0 =A0 =A0 i2c_set_clientdata(client, ts);
> +
> + =A0 =A0 =A0 ts->input =3D input_dev;
> +
> + =A0 =A0 =A0 ts->model =A0 =A0 =A0 =A0 =A0 =A0 =3D pdata->model;
> + =A0 =A0 =A0 ts->x_plate_ohms =A0 =A0 =A0=3D pdata->x_plate_ohms;
> +
> + =A0 =A0 =A0 snprintf(ts->phys, sizeof(ts->phys),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s/input0", dev_name(&client->dev))=
;
> +
> + =A0 =A0 =A0 input_dev->name =3D TSC2003_DRIVER_NAME" Touchscreen";
> + =A0 =A0 =A0 input_dev->phys =3D ts->phys;
> + =A0 =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
> +
> + =A0 =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_=
ABS);
> + =A0 =A0 =A0 input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN=
_TOUCH);
> +
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0,=
 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0,=
 0);
> + =A0 =A0 =A0 input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12=
BIT, 0, 0);
> +
> + =A0 =A0 =A0 init_completion(&ts->penirq_completion);
> +
> + =A0 =A0 =A0 ts->task =3D kthread_run(tsc2003_thread, ts, TSC2003_DR=
IVER_NAME);
> + =A0 =A0 =A0 if (IS_ERR(ts->task)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(ts->task);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D request_irq(client->irq, tsc2003_irq, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->dev.driver->nam=
e, ts);
> + =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "irq %d busy?\n",=
 client->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_thread;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D input_register_device(input_dev);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> +
> + =A0 =A0 =A0 dev_info(&client->dev, "registered with irq (%d)\n", cl=
ient->irq);
> +
> + =A0 =A0 =A0 return 0;
> +
> + err_free_irq:
> + =A0 =A0 =A0 free_irq(client->irq, ts);
> + err_free_thread:
> + =A0 =A0 =A0 kthread_stop(ts->task);
> + err_free_mem:
> + =A0 =A0 =A0 input_free_device(input_dev);
> + =A0 =A0 =A0 kfree(ts);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int tsc2003_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct tsc2003 *ts =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 free_irq(client->irq, ts);
> + =A0 =A0 =A0 send_sig(SIGKILL, ts->task, 1);
> + =A0 =A0 =A0 kthread_stop(ts->task);
> + =A0 =A0 =A0 input_unregister_device(ts->input);
> + =A0 =A0 =A0 kfree(ts);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct i2c_device_id tsc2003_idtable[] =3D {
> + =A0 =A0 =A0 { TSC2003_DRIVER_NAME, 0 },
> + =A0 =A0 =A0 { }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tsc2003_idtable);
> +
> +static struct i2c_driver tsc2003_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D TSC2003_DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D &i2c_bus_type,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D tsc2003_idtable,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D tsc2003_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D tsc2003_remove,
> +};
> +
> +static int __init tsc2003_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&tsc2003_driver);
> +}
> +
> +static void __exit tsc2003_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&tsc2003_driver);
> +}
> +
> +module_init(tsc2003_init);
> +module_exit(tsc2003_exit);
> +
> +MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
> +MODULE_DESCRIPTION("TSC2003 TouchScreen Driver");
> +MODULE_LICENSE("GPL v2");
> +
> Index: linux-2.6.30-rc7/drivers/input/touchscreen/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.30-rc7/drivers/input/touchscreen/Kconfig =A0(revision 8=
61)
> +++ linux-2.6.30-rc7/drivers/input/touchscreen/Kconfig =A0(revision 8=
69)
> @@ -455,6 +455,17 @@
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called touchit213.
>
> +config TOUCHSCREEN_TSC2003
> + =A0 =A0 =A0 tristate "TSC2003 based touchscreens"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you have a TSC2003 based touchscreen.
> +
> + =A0 =A0 =A0 =A0 If unsure, say N.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called tsc2003.
> +
> =A0config TOUCHSCREEN_TSC2007
> =A0 =A0 =A0 =A0tristate "TSC2007 based touchscreens"
> =A0 =A0 =A0 =A0depends on I2C
> Index: linux-2.6.30-rc7/drivers/input/touchscreen/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.30-rc7/drivers/input/touchscreen/Makefile (revision 861=
)
> +++ linux-2.6.30-rc7/drivers/input/touchscreen/Makefile (revision 869=
)
> @@ -27,6 +27,7 @@
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213) =A0 +=3D touchit213.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT) =A0 +=3D touchright.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN) =A0 =A0 +=3D touchwin.o
> +obj-$(CONFIG_TOUCHSCREEN_TSC2003) =A0 =A0 =A0+=3D tsc2003.o
> =A0obj-$(CONFIG_TOUCHSCREEN_TSC2007) =A0 =A0 =A0+=3D tsc2007.o
> =A0obj-$(CONFIG_TOUCHSCREEN_UCB1400) =A0 =A0 =A0+=3D ucb1400_ts.o
> =A0obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001) =A0+=3D wacom_w8001.o
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
