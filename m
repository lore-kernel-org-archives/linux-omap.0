From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v4 3/5] misc serdev: Add w2sg0004 (gps receiver) power control driver
Date: Tue, 28 Nov 2017 22:42:10 +0100
Message-ID: <B096DC8C-66C5-4F04-8EE4-0B0711EC1700@goldelico.com>
References: <cover.1510781875.git.hns@goldelico.com> <871b744f878be8a0a4758ce549ff6ecaea8b6894.1510781876.git.hns@goldelico.com> <8dcd4cbb-02eb-b1d4-186e-63823199d5bb@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8dcd4cbb-02eb-b1d4-186e-63823199d5bb-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Ne
List-Id: linux-omap@vger.kernel.org

Hi Andrew,
now as 4.15-rc1 is out I find time to continue this work and prepare =
[PATCH v5].

> Am 23.11.2017 um 17:06 schrieb Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>:
>=20
> On 11/15/2017 03:37 PM, H. Nikolaus Schaller wrote:
>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>>=20
>> Use serdev API hooks to monitor and forward the UART traffic to =
/dev/ttyGPSn
>> and turn on/off the module. It also detects if the module is turned =
on (sends data)
>> but should be off, e.g. if it was already turned on during boot or =
power-on-reset.
>>=20
>> Additionally, rfkill block/unblock can be used to control an external =
LNA
>> (and power down the module if not needed).
>>=20
>> The driver concept is based on code developed by NeilBrown =
<neilb-l3A5Bk7waGM@public.gmane.org>
>> but simplified and adapted to use the new serdev API introduced in =
4.11.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
>> ---
>> drivers/misc/Kconfig    |  10 +
>> drivers/misc/Makefile   |   1 +
>> drivers/misc/w2sg0004.c | 545 =
++++++++++++++++++++++++++++++++++++++++++++++++

I wonder if this shouldn't better go to

  drivers/gps

But this directory does not yet exist and has no overall maintainer.
So it could be left in drivers/misc and moved as soon as drivers/gps
is created elsewhere.

>> 3 files changed, 556 insertions(+)
>> create mode 100644 drivers/misc/w2sg0004.c
>>=20
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 8136dc7e863d..09d171d68408 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -518,4 +518,14 @@ source "drivers/misc/mic/Kconfig"
>> source "drivers/misc/genwqe/Kconfig"
>> source "drivers/misc/echo/Kconfig"
>> source "drivers/misc/cxl/Kconfig"
>> +
>> +config W2SG0004
>> +	tristate "W2SG00x4 on/off control"
>> +	depends on GPIOLIB && SERIAL_DEV_BUS
>> +	help
>> +          Enable on/off control of W2SG00x4 GPS moduled connected
>> +	  to some SoC UART to allow powering up/down if the /dev/ttyGPSn
>> +	  is opened/closed.
>> +	  It also provides a rfkill gps name to control the LNA power.
>> +
>> endmenu
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index ad0e64fdba34..abcb667e0ff0 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_SRAM_EXEC)		+=3D sram-exec.o
>> obj-y				+=3D mic/
>> obj-$(CONFIG_GENWQE)		+=3D genwqe/
>> obj-$(CONFIG_ECHO)		+=3D echo/
>> +obj-$(CONFIG_W2SG0004)		+=3D w2sg0004.o
>> obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
>> obj-$(CONFIG_CXL_BASE)		+=3D cxl/
>> obj-$(CONFIG_ASPEED_LPC_CTRL)	+=3D aspeed-lpc-ctrl.o
>> diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
>> new file mode 100644
>> index 000000000000..12e14b5e0a99
>> --- /dev/null
>> +++ b/drivers/misc/w2sg0004.c
>> @@ -0,0 +1,545 @@
>> +// SPDX-License-Identifier: GPL-2.0
>=20
> Damn this looks ugly, oh well :/

I could remove it for [PATCH v5] ... :\

>=20
>> +/*
>> + * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
>> + *
>=20
>=20
> Think you still need copyright tag here somewhere.

At the bottom there is:

>> +MODULE_AUTHOR("NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>");
>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>> +MODULE_LICENSE("GPL v2");

Isn't that enough any more?

>=20
>> + * This receiver has an ON/OFF pin which must be toggled to
>> + * turn the device 'on' of 'off'.  A high->low->high toggle
>> + * will switch the device on if it is off, and off if it is on.
>> + *
>> + * To enable receiving on/off requests we register with the
>> + * UART power management notifications.
>> + *
>> + * It is not possible to directly detect the state of the device.
>> + * However when it is on it will send characters on a UART line
>> + * regularly.
>> + *
>> + * To detect that the power state is out of sync (e.g. if GPS
>> + * was enabled before a reboot), we register for UART data received
>> + * notifications.
>> + *
>> + * In addition we register as a rfkill client so that we can
>> + * control the LNA power.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/rfkill.h>
>> +#include <linux/serdev.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/workqueue.h>
>> +
>> +/*
>> + * There seems to be restrictions on how quickly we can toggle the
>> + * on/off line.  data sheets says "two rtc ticks", whatever that =
means.
>> + * If we do it too soon it doesn't work.
>> + * So we have a state machine which uses the common work queue to =
ensure
>> + * clean transitions.
>> + * When a change is requested we record that request and only act on =
it
>> + * once the previous change has completed.
>> + * A change involves a 10ms low pulse, and a 990ms raised level, so =
only
>> + * one change per second.
>> + */
>> +
>> +enum w2sg_state {
>> +	W2SG_IDLE,	/* is not changing state */
>> +	W2SG_PULSE,	/* activate on/off impulse */
>> +	W2SG_NOPULSE	/* deactivate on/off impulse */
>> +};
>> +
>> +struct w2sg_data {
>> +	struct		rfkill *rf_kill;
>> +	struct		regulator *lna_regulator;
>> +	int		lna_blocked;	/* rfkill block gps active */
>> +	int		lna_is_off;	/* LNA is currently off */
>> +	int		is_on;		/* current state (0/1) */
>> +	unsigned long	last_toggle;
>> +	unsigned long	backoff;	/* time to wait since =
last_toggle */
>> +	int		on_off_gpio;	/* the on-off gpio number */
>> +	struct		serdev_device *uart;	/* uart connected to the =
chip */
>> +	struct		tty_driver *tty_drv;	/* this is the user =
space tty */
>> +	struct		device *dev;	/* from =
tty_port_register_device() */
>> +	struct		tty_port port;
>> +	int		open_count;	/* how often we were opened */
>> +	enum		w2sg_state state;
>> +	int		requested;	/* requested state (0/1) */
>> +	int		suspended;
>> +	struct delayed_work work;
>> +	int		discard_count;
>> +};
>> +
>=20
> Kernel doc style.

Is this really needed here?

For pure driver internal structs (they are not kernel infrastructure =
API) I usually
consult the source code of a driver and never well formatted kernel doc. =
Hence I think
readability by programmers looking into the source file is more =
important than serving
kernel doc tools.

Yes, there are examples like:

=
https://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/iio/accel=
/mma8452.c#L113

But I find them more confusing than helpful because I have to jump =
between code lines
to match the comment with the data type.

>=20
>> +static struct w2sg_data *w2sg_by_minor[1];
>> +
>=20
> If you can only have one right now then just drop the array.

w2sg_get_by_minor() is prepared to access more than one record.
And there are plans to have more than one (but I don't know exactly
how to provide it).

Making it a non-array seems to be an unnecessary hurdle for such
improvements. And regarding memory footprint, a single-element
array is equivalent to a non-array.

>=20
>> +static int w2sg_set_lna_power(struct w2sg_data *data)
>> +{
>> +	int ret =3D 0;
>> +	int off =3D data->suspended || !data->requested || =
data->lna_blocked;
>> +
>> +	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
>> +
>> +	if (off !=3D data->lna_is_off) {
>> +		data->lna_is_off =3D off;
>> +		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
>> +			if (off)
>> +				regulator_disable(data->lna_regulator);
>> +			else
>> +				ret =3D =
regulator_enable(data->lna_regulator);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void w2sg_set_power(void *pdata, int val)
>> +{
>> +	struct w2sg_data *data =3D (struct w2sg_data *) pdata;
>> +
>> +	pr_debug("%s to state=3D%d (requested=3D%d)\n", __func__, val, =
data->requested);
>> +
>> +	if (val && !data->requested) {
>> +		data->requested =3D true;
>> +	} else if (!val && data->requested) {
>> +		data->backoff =3D HZ;
>> +		data->requested =3D false;
>> +	} else
>> +		return;
>> +
>> +	pr_debug("w2sg00x4 scheduled for %d\n", data->requested);
>> +
>> +	if (!data->suspended)
>> +		schedule_delayed_work(&data->work, 0);
>> +}
>> +
>> +/* called each time data is received by the UART (i.e. sent by the =
w2sg0004) */
>> +
>> +static int w2sg_uart_receive_buf(struct serdev_device *serdev,
>> +				const unsigned char *rxdata,
>> +				size_t count)
>> +{
>> +	struct w2sg_data *data =3D
>> +		(struct w2sg_data *) serdev_device_get_drvdata(serdev);
>> +
>> +	if (!data->requested && !data->is_on) {
>> +		/*
>> +		 * we have received characters while the w2sg
>> +		 * should have been be turned off
>> +		 */
>> +		data->discard_count +=3D count;
>> +		if ((data->state =3D=3D W2SG_IDLE) &&
>> +		    time_after(jiffies,
>> +		    data->last_toggle + data->backoff)) {
>> +			/* Should be off by now, time to toggle again */
>> +			pr_debug("w2sg00x4 has sent %d characters data =
although it should be off!\n",
>> +				data->discard_count);
>> +
>> +			data->discard_count =3D 0;
>> +
>> +			data->is_on =3D true;
>> +			data->backoff *=3D 2;
>> +			if (!data->suspended)
>> +				schedule_delayed_work(&data->work, 0);
>> +		}
>> +	} else if (data->open_count > 0) {
>> +		int n;
>> +
>> +		pr_debug("w2sg00x4: push %lu chars to tty port\n",
>> +			(unsigned long) count);
>> +
>> +		/* pass to user-space */
>> +		n =3D tty_insert_flip_string(&data->port, rxdata, =
count);
>> +		if (n !=3D count)
>> +			pr_err("w2sg00x4: did loose %lu characters\n",
>> +				(unsigned long) (count - n));
>> +		tty_flip_buffer_push(&data->port);
>> +		return n;
>> +	}
>> +
>> +	/* assume we have processed everything */
>> +	return count;
>> +}
>> +
>> +/* try to toggle the power state by sending a pulse to the on-off =
GPIO */
>> +
>=20
> drop extra line, same everywhere

Ok! Was just this and one more location.

>=20
>> +static void toggle_work(struct work_struct *work)
>> +{
>> +	struct w2sg_data *data =3D container_of(work, struct w2sg_data,
>> +					      work.work);
>> +
>> +	switch (data->state) {
>> +	case W2SG_IDLE:
>> +		if (data->requested =3D=3D data->is_on)
>> +			return;
>> +
>> +		w2sg_set_lna_power(data);	/* update LNA power =
state */
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		data->state =3D W2SG_PULSE;
>> +
>> +		pr_debug("w2sg: power gpio ON\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_PULSE:
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle =3D jiffies;
>> +		data->state =3D W2SG_NOPULSE;
>> +		data->is_on =3D !data->is_on;
>> +
>> +		pr_debug("w2sg: power gpio OFF\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_NOPULSE:
>> +		data->state =3D W2SG_IDLE;
>> +
>> +		pr_debug("w2sg: idle\n");
>> +
>> +		break;
>> +
>> +	}
>> +}
>> +
>> +static int w2sg_rfkill_set_block(void *pdata, bool blocked)
>> +{
>> +	struct w2sg_data *data =3D pdata;
>> +
>> +	pr_debug("%s: blocked: %d\n", __func__, blocked);
>> +
>> +	data->lna_blocked =3D blocked;
>> +
>> +	return w2sg_set_lna_power(data);
>> +}
>> +
>> +static struct rfkill_ops w2sg0004_rfkill_ops =3D {
>> +	.set_block =3D w2sg_rfkill_set_block,
>> +};
>> +
>> +static struct serdev_device_ops serdev_ops =3D {
>> +	.receive_buf =3D w2sg_uart_receive_buf,
>> +};
>> +
>> +/*
>> + * we are a man-in the middle between the user-space visible tty =
port
>> + * and the serdev tty where the chip is connected.
>> + * This allows us to recognise when the device should be powered on
>> + * or off and handle the "false" state that data arrives while no
>> + * users-space tty client exists.
>> + */
>> +
>> +static struct w2sg_data *w2sg_get_by_minor(unsigned int minor)
>> +{
>> +	return w2sg_by_minor[minor];
>> +}
>> +
>> +static int w2sg_tty_install(struct tty_driver *driver, struct =
tty_struct *tty)
>> +{
>> +	struct w2sg_data *data;
>> +	int retval;
>> +
>> +	pr_debug("%s() tty =3D %p\n", __func__, tty);
>> +
>> +	data =3D w2sg_get_by_minor(tty->index);
>> +
>> +	if (!data)
>> +		return -ENODEV;
>> +
>> +	retval =3D tty_standard_install(driver, tty);
>> +	if (retval)
>> +		goto error_init_termios;
>> +
>> +	tty->driver_data =3D data;
>> +
>> +	return 0;
>> +
>> +error_init_termios:
>> +	tty_port_put(&data->port);
>> +	return retval;
>> +}
>> +
>> +static int w2sg_tty_open(struct tty_struct *tty, struct file *file)
>> +{
>> +	struct w2sg_data *data =3D tty->driver_data;
>> +
>> +	pr_debug("%s() data =3D %p open_count =3D ++%d\n", __func__, =
data, data->open_count);
>> +
>> +	w2sg_set_power(data, ++data->open_count > 0);
>> +
>> +	return tty_port_open(&data->port, tty, file);
>> +}
>> +
>> +static void w2sg_tty_close(struct tty_struct *tty, struct file =
*file)
>> +{
>> +	struct w2sg_data *data =3D tty->driver_data;
>> +
>> +	pr_debug("%s()\n", __func__);
>> +
>> +	w2sg_set_power(data, --data->open_count > 0);
>> +
>> +	tty_port_close(&data->port, tty, file);
>> +}
>> +
>> +static int w2sg_tty_write(struct tty_struct *tty,
>> +		const unsigned char *buffer, int count)
>> +{
>> +	struct w2sg_data *data =3D tty->driver_data;
>> +
>> +	/* simply pass down to UART */
>> +	return serdev_device_write_buf(data->uart, buffer, count);
>> +}
>> +
>> +static const struct tty_operations w2sg_serial_ops =3D {
>> +	.install =3D w2sg_tty_install,
>> +	.open =3D w2sg_tty_open,
>> +	.close =3D w2sg_tty_close,
>> +	.write =3D w2sg_tty_write,
>> +};
>> +
>> +static const struct tty_port_operations w2sg_port_ops =3D {
>> +};
>=20
> drop the brackets? or use NULL below, not sure if this needs memory.

This allocates a struct tty_port_operations initialized with NULL for
all function pointers.

I am not sure if this is the same as providing no w2sg_port_ops at all.

Rather I think the serial core is only port =3D=3D NULL safe but not
port->ops =3D=3D NULL e.g.:

=
http://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/tty/tty_po=
rt.c#L422

A test confirms (see comment below):

>=20
>> +
>> +static int w2sg_probe(struct serdev_device *serdev)
>> +{
>> +	struct w2sg_data *data;
>> +	struct rfkill *rf_kill;
>> +	int err;
>> +	int minor;
>> +	enum of_gpio_flags flags;
>> +
>> +	pr_debug("%s()\n", __func__);
>> +
>> +	minor =3D 0;
>> +	if (w2sg_by_minor[minor]) {
>> +		pr_err("w2sg minor is already in use!\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	data =3D devm_kzalloc(&serdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (data =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	w2sg_by_minor[minor] =3D data;

While looking through this, I found a potential issue if allocating the
gpio fails with -EPROBE_DEFER.

Then, we have set w2sg_by_minor[minor] !=3D NULL and the above test will =
already
find it allocated on next deferred probe attempt.

So I'll move that to a position further down.

>> +
>> +	serdev_device_set_drvdata(serdev, data);
>> +
>> +	data->on_off_gpio =3D =
of_get_named_gpio_flags(serdev->dev.of_node,
>> +						     "enable-gpios", 0,
>> +						     &flags);
>> +	/* defer until we have all gpios */
>> +	if (data->on_off_gpio =3D=3D -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
>> +
>> +	data->lna_regulator =3D =
devm_regulator_get_optional(&serdev->dev,
>> +							"lna");
>> +	if (IS_ERR(data->lna_regulator)) {
>> +		/* defer until we can get the regulator */
>> +		if (PTR_ERR(data->lna_regulator) =3D=3D -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +
>> +		data->lna_regulator =3D NULL;
>> +	}
>> +	pr_debug("%s() lna_regulator =3D %p\n", __func__, =
data->lna_regulator);
>> +
>> +	data->lna_blocked =3D true;
>> +	data->lna_is_off =3D true;
>> +
>> +	data->is_on =3D false;
>> +	data->requested =3D false;
>> +	data->state =3D W2SG_IDLE;
>> +	data->last_toggle =3D jiffies;
>> +	data->backoff =3D HZ;
>> +
>> +	data->uart =3D serdev;
>> +
>> +	INIT_DELAYED_WORK(&data->work, toggle_work);
>> +
>> +	err =3D devm_gpio_request(&serdev->dev, data->on_off_gpio,
>> +				"w2sg0004-on-off");
>> +	if (err < 0)
>> +		goto out;
>> +
>> +	gpio_direction_output(data->on_off_gpio, false);
>> +
>> +	serdev_device_set_client_ops(data->uart, &serdev_ops);
>> +	serdev_device_open(data->uart);
>> +
>> +	serdev_device_set_baudrate(data->uart, 9600);
>> +	serdev_device_set_flow_control(data->uart, false);
>> +
>> +	rf_kill =3D rfkill_alloc("GPS", &serdev->dev, RFKILL_TYPE_GPS,
>> +				&w2sg0004_rfkill_ops, data);
>> +	if (rf_kill =3D=3D NULL) {
>> +		err =3D -ENOMEM;
>> +		goto err_rfkill;
>> +	}
>> +
>> +	err =3D rfkill_register(rf_kill);
>> +	if (err) {
>> +		dev_err(&serdev->dev, "Cannot register rfkill =
device\n");
>> +		goto err_rfkill;
>> +	}
>> +
>> +	data->rf_kill =3D rf_kill;
>> +
>> +	/* allocate the tty driver */
>> +	data->tty_drv =3D alloc_tty_driver(1);
>> +	if (!data->tty_drv)
>> +		return -ENOMEM;
>> +
>> +	/* initialize the tty driver */
>> +	data->tty_drv->owner =3D THIS_MODULE;
>> +	data->tty_drv->driver_name =3D "w2sg0004";
>> +	data->tty_drv->name =3D "ttyGPS";
>> +	data->tty_drv->major =3D 0;
>> +	data->tty_drv->minor_start =3D 0;
>> +	data->tty_drv->type =3D TTY_DRIVER_TYPE_SERIAL;
>> +	data->tty_drv->subtype =3D SERIAL_TYPE_NORMAL;
>> +	data->tty_drv->flags =3D TTY_DRIVER_REAL_RAW | =
TTY_DRIVER_DYNAMIC_DEV;
>> +	data->tty_drv->init_termios =3D tty_std_termios;
>> +	data->tty_drv->init_termios.c_cflag =3D B9600 | CS8 | CREAD |
>> +					      HUPCL | CLOCAL;
>> +	/*
>> +	 * optional:
>> +	 * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>> +					115200, 115200);
>> +	 * w2sg_tty_termios(&data->tty_drv->init_termios);
>> +	 */
>> +	tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>> +
>> +	/* register the tty driver */
>> +	err =3D tty_register_driver(data->tty_drv);
>> +	if (err) {
>> +		pr_err("%s - tty_register_driver failed(%d)\n",
>> +			__func__, err);
>> +		put_tty_driver(data->tty_drv);
>> +		goto err_rfkill;
>> +	}
>> +
>> +	tty_port_init(&data->port);
>> +	data->port.ops =3D &w2sg_port_ops;

A test setting this to NULL leads to a kernel oops in:

[ 3048.821258] [<c046c598>] (tty_port_open) from [<c0466328>] =
(tty_open+0x1e8/0x2d8)

So we must define this completely empty struct w2sg_port_ops
and pass a reference.

>> +
>> +	pr_debug("w2sg call tty_port_register_device\n");
>> +
>> +	data->dev =3D tty_port_register_device(&data->port,
>> +			data->tty_drv, minor, &serdev->dev);
>> +
>> +	pr_debug("w2sg probed\n");
>> +
>> +	/* keep off until user space requests the device */
>> +	w2sg_set_power(data, false);
>> +
>> +	return 0;
>> +
>> +err_rfkill:
>> +	rfkill_destroy(rf_kill);
>> +	serdev_device_close(data->uart);
>> +out:
>> +	return err;
>> +}
>> +
>> +static void w2sg_remove(struct serdev_device *serdev)
>> +{
>> +	struct w2sg_data *data =3D serdev_device_get_drvdata(serdev);
>> +	int minor;
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	/* what is the right sequence to avoid problems? */
>> +	serdev_device_close(data->uart);
>> +
>> +	minor =3D 0;
>> +	tty_unregister_device(data->tty_drv, minor);
>> +
>> +	tty_unregister_driver(data->tty_drv);
>> +}
>> +
>> +static int w2sg_suspend(struct device *dev)
>=20
> __maybe_unused, or if PM is disabled you will get a warning.

Ok.

>=20
>> +{
>> +	struct w2sg_data *data =3D dev_get_drvdata(dev);
>> +
>> +	data->suspended =3D true;
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	w2sg_set_lna_power(data);	/* shuts down if needed */
>> +
>> +	if (data->state =3D=3D W2SG_PULSE) {
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle =3D jiffies;
>> +		data->is_on =3D !data->is_on;
>> +		data->state =3D W2SG_NOPULSE;
>> +	}
>> +
>> +	if (data->state =3D=3D W2SG_NOPULSE) {
>> +		msleep(10);
>> +		data->state =3D W2SG_IDLE;
>> +	}
>> +
>> +	if (data->is_on) {
>> +		pr_info("GPS off for suspend %d %d %d\n", =
data->requested,
>> +			data->is_on, data->lna_is_off);
>> +
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->is_on =3D 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int w2sg_resume(struct device *dev)
>> +{
>> +	struct w2sg_data *data =3D dev_get_drvdata(dev);
>> +
>> +	data->suspended =3D false;
>> +
>> +	pr_info("GPS resuming %d %d %d\n", data->requested,
>> +		data->is_on, data->lna_is_off);
>> +
>> +	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed =
*/
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id w2sg0004_of_match[] =3D {
>> +	{ .compatible =3D "wi2wi,w2sg0004" },
>> +	{ .compatible =3D "wi2wi,w2sg0084" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
>> +
>> +SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_suspend, w2sg_resume);
>> +
>> +static struct serdev_device_driver w2sg_driver =3D {
>> +	.probe		=3D w2sg_probe,
>> +	.remove		=3D w2sg_remove,
>> +	.driver =3D {
>> +		.name	=3D "w2sg0004",
>> +		.owner	=3D THIS_MODULE,
>> +		.pm	=3D &w2sg_pm_ops,
>> +		.of_match_table =3D of_match_ptr(w2sg0004_of_match)
>> +	},
>> +};
>> +
>> +module_serdev_device_driver(w2sg_driver);
>> +
>> +MODULE_ALIAS("w2sg0004");
>=20
> Is this needed?

Seems to be redundant.
After removal the driver is still loaded automatically after boot:

root@letux:~# modprobe -c | fgrep w2sg
alias of:N*T*Cwi2wi,w2sg0004 w2sg0004
alias of:N*T*Cwi2wi,w2sg0004C* w2sg0004
alias of:N*T*Cwi2wi,w2sg0084 w2sg0004
alias of:N*T*Cwi2wi,w2sg0084C* w2sg0004
root@letux:~# lsmod | fgrep w2sg
w2sg0004               16384  2=20
root@letux:~#=20

>=20
>> +
>> +MODULE_AUTHOR("NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>");
>=20
> Who really wrote this?

Good question.

The problem is that with cleaning up the code and rewriting history over =
such
a long time, it is no more visible.

But I have searched through our older branches:

Neil Brown had developed the first version for v3.7 in 2013:=20
=
http://git.goldelico.com/?p=3Dgta04-kernel.git;a=3Dcommit;h=3D5b6fad7c7f15=
db8bb8e2c98ae9a50da52bda8b69

This is where the MODULE_AUTHOR line comes from.

Later, Marek Belisko worked on the UART driver, pinmux and interrupts.

And I have
* added lna-regulator and rfkill ca. v3.12
* added device tree support ca. v3.15
* moved to drivers/misc
* ported the code to serdev API ca. v4.11
* submitted to LKML and worked in comments by reviewers ca. 4.15

So this is the first version that is close to be acceptable.

Neil had also submitted different versions to LKML but I am not
sure if he still is active anywhere.

I have also checked a diff between the v3.7 version and the
current one and there are ca. 30-40% of lines original code by
Neil.

So I'd say:

* Neil is the original author and a significant amount of untouched code =
lines and comments are still there
* he designed the overall driver architecture
* Hence he is the copyright holder, did license under GPL v2 and we have =
just made a derivative work out of it
* Neil did submit his version of serdev ca. 2015 (quite different from =
this) but resigned after review feedback
* I did add some important features but not the core code and driver =
architecture
* I feel my role as maintainer and massaging everything for DT, serdev =
and get it upstream, but not "the author"

How should we best reflect this in the AUTHOR macro?

>=20
>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>> +MODULE_LICENSE("GPL v2");
>>=20


BR and thanks,
Nikolaus Schaller

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
