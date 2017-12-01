From: H. Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH v4 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Fri, 1 Dec 2017 08:49:22 +0100
Message-ID: <FD5BF26C-4199-4A16-BADA-9F0153D2AF44@goldelico.com>
References: <cover.1510781875.git.hns@goldelico.com>
 <871b744f878be8a0a4758ce549ff6ecaea8b6894.1510781876.git.hns@goldelico.com>
 <8dcd4cbb-02eb-b1d4-186e-63823199d5bb@ti.com>
 <B096DC8C-66C5-4F04-8EE4-0B0711EC1700@goldelico.com>
 <7379a64d-f3f8-977a-308e-99f21654ba1d@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7379a64d-f3f8-977a-308e-99f21654ba1d@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Marek Belisko <marek@goldelico.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Thierry Reding <treding@nvidia.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 29.11.2017 um 15:47 schrieb Andrew F. Davis <afd@ti.com>:
> 
> On 11/28/2017 03:42 PM, H. Nikolaus Schaller wrote:
>> Hi Andrew,
>> now as 4.15-rc1 is out I find time to continue this work and prepare [PATCH v5].
>> 
>>> Am 23.11.2017 um 17:06 schrieb Andrew F. Davis <afd@ti.com>:
>>> 
>>> On 11/15/2017 03:37 PM, H. Nikolaus Schaller wrote:
>>>> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
>>>> 
>>>> Use serdev API hooks to monitor and forward the UART traffic to /dev/ttyGPSn
>>>> and turn on/off the module. It also detects if the module is turned on (sends data)
>>>> but should be off, e.g. if it was already turned on during boot or power-on-reset.
>>>> 
>>>> Additionally, rfkill block/unblock can be used to control an external LNA
>>>> (and power down the module if not needed).
>>>> 
>>>> The driver concept is based on code developed by NeilBrown <neilb@suse.de>
>>>> but simplified and adapted to use the new serdev API introduced in 4.11.
>>>> 
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> drivers/misc/Kconfig    |  10 +
>>>> drivers/misc/Makefile   |   1 +
>>>> drivers/misc/w2sg0004.c | 545 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 
>> I wonder if this shouldn't better go to
>> 
>>  drivers/gps
>> 
>> But this directory does not yet exist and has no overall maintainer.
>> So it could be left in drivers/misc and moved as soon as drivers/gps
>> is created elsewhere.
>> 
> 
> Making that directory would imply the existence of a GPS driver
> framework, until one comes about (or if you would like to create one), I
> think misc is the most appropriate spot for now.

Understood and fine with it.
I just wanted to have asked and clarified.

> 
>>>> 3 files changed, 556 insertions(+)
>>>> create mode 100644 drivers/misc/w2sg0004.c
>>>> 
>>>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>>>> index 8136dc7e863d..09d171d68408 100644
>>>> --- a/drivers/misc/Kconfig
>>>> +++ b/drivers/misc/Kconfig
>>>> @@ -518,4 +518,14 @@ source "drivers/misc/mic/Kconfig"
>>>> source "drivers/misc/genwqe/Kconfig"
>>>> source "drivers/misc/echo/Kconfig"
>>>> source "drivers/misc/cxl/Kconfig"
>>>> +
>>>> +config W2SG0004
>>>> +	tristate "W2SG00x4 on/off control"
>>>> +	depends on GPIOLIB && SERIAL_DEV_BUS
>>>> +	help
>>>> +          Enable on/off control of W2SG00x4 GPS moduled connected
>>>> +	  to some SoC UART to allow powering up/down if the /dev/ttyGPSn
>>>> +	  is opened/closed.
>>>> +	  It also provides a rfkill gps name to control the LNA power.
>>>> +
>>>> endmenu
>>>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>>>> index ad0e64fdba34..abcb667e0ff0 100644
>>>> --- a/drivers/misc/Makefile
>>>> +++ b/drivers/misc/Makefile
>>>> @@ -51,6 +51,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
>>>> obj-y				+= mic/
>>>> obj-$(CONFIG_GENWQE)		+= genwqe/
>>>> obj-$(CONFIG_ECHO)		+= echo/
>>>> +obj-$(CONFIG_W2SG0004)		+= w2sg0004.o
>>>> obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
>>>> obj-$(CONFIG_CXL_BASE)		+= cxl/
>>>> obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
>>>> diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
>>>> new file mode 100644
>>>> index 000000000000..12e14b5e0a99
>>>> --- /dev/null
>>>> +++ b/drivers/misc/w2sg0004.c
>>>> @@ -0,0 +1,545 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>> 
>>> Damn this looks ugly, oh well :/
>> 
>> I could remove it for [PATCH v5] ... :\
>> 
> 
> Nah, you should leave it, this comment was just me venting, Greg KH has
> spoken, so this is the correct way now.

Yes, sigh...

> 
>>> 
>>>> +/*
>>>> + * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
>>>> + *
>>> 
>>> 
>>> Think you still need copyright tag here somewhere.
>> 
>> At the bottom there is:
>> 
>>>> +MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
>>>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>>>> +MODULE_LICENSE("GPL v2");
>> 
>> Isn't that enough any more?
>> 
> 
> Not sure.. someone needs to hold the copyright to this file and it
> really should be close to the top.

Ok, I'll add some (C) line(s) matching the author(s).

> 
>>> 
>>>> + * This receiver has an ON/OFF pin which must be toggled to
>>>> + * turn the device 'on' of 'off'.  A high->low->high toggle
>>>> + * will switch the device on if it is off, and off if it is on.
>>>> + *
>>>> + * To enable receiving on/off requests we register with the
>>>> + * UART power management notifications.
>>>> + *
>>>> + * It is not possible to directly detect the state of the device.
>>>> + * However when it is on it will send characters on a UART line
>>>> + * regularly.
>>>> + *
>>>> + * To detect that the power state is out of sync (e.g. if GPS
>>>> + * was enabled before a reboot), we register for UART data received
>>>> + * notifications.
>>>> + *
>>>> + * In addition we register as a rfkill client so that we can
>>>> + * control the LNA power.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/delay.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/irq.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_irq.h>
>>>> +#include <linux/of_gpio.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +#include <linux/rfkill.h>
>>>> +#include <linux/serdev.h>
>>>> +#include <linux/sched.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/tty.h>
>>>> +#include <linux/tty_flip.h>
>>>> +#include <linux/workqueue.h>
>>>> +
>>>> +/*
>>>> + * There seems to be restrictions on how quickly we can toggle the
>>>> + * on/off line.  data sheets says "two rtc ticks", whatever that means.
>>>> + * If we do it too soon it doesn't work.
>>>> + * So we have a state machine which uses the common work queue to ensure
>>>> + * clean transitions.
>>>> + * When a change is requested we record that request and only act on it
>>>> + * once the previous change has completed.
>>>> + * A change involves a 10ms low pulse, and a 990ms raised level, so only
>>>> + * one change per second.
>>>> + */
>>>> +
>>>> +enum w2sg_state {
>>>> +	W2SG_IDLE,	/* is not changing state */
>>>> +	W2SG_PULSE,	/* activate on/off impulse */
>>>> +	W2SG_NOPULSE	/* deactivate on/off impulse */
>>>> +};
>>>> +
>>>> +struct w2sg_data {
>>>> +	struct		rfkill *rf_kill;
>>>> +	struct		regulator *lna_regulator;
>>>> +	int		lna_blocked;	/* rfkill block gps active */
>>>> +	int		lna_is_off;	/* LNA is currently off */
>>>> +	int		is_on;		/* current state (0/1) */
>>>> +	unsigned long	last_toggle;
>>>> +	unsigned long	backoff;	/* time to wait since last_toggle */
>>>> +	int		on_off_gpio;	/* the on-off gpio number */
>>>> +	struct		serdev_device *uart;	/* uart connected to the chip */
>>>> +	struct		tty_driver *tty_drv;	/* this is the user space tty */
>>>> +	struct		device *dev;	/* from tty_port_register_device() */
>>>> +	struct		tty_port port;
>>>> +	int		open_count;	/* how often we were opened */
>>>> +	enum		w2sg_state state;
>>>> +	int		requested;	/* requested state (0/1) */
>>>> +	int		suspended;
>>>> +	struct delayed_work work;
>>>> +	int		discard_count;
>>>> +};
>>>> +
>>> 
>>> Kernel doc style.
>> 
>> Is this really needed here?
>> 
>> For pure driver internal structs (they are not kernel infrastructure API) I usually
>> consult the source code of a driver and never well formatted kernel doc. Hence I think
>> readability by programmers looking into the source file is more important than serving
>> kernel doc tools.
>> 
>> Yes, there are examples like:
>> 
>> https://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/iio/accel/mma8452.c#L113
>> 
>> But I find them more confusing than helpful because I have to jump between code lines
>> to match the comment with the data type.
>> 
> 
> I have no strong preference here as long as you think this is the most
> readable way.

Ok, then let's leave it as it is.

> 
>>> 
>>>> +static struct w2sg_data *w2sg_by_minor[1];
>>>> +
>>> 
>>> If you can only have one right now then just drop the array.
>> 
>> w2sg_get_by_minor() is prepared to access more than one record.
>> And there are plans to have more than one (but I don't know exactly
>> how to provide it).
>> 
> 
> Just add it back when you get that functionality.

I have added a BUG_ON if anyone tries to access an index different from 0.
Why BUG_ON? Because there is no way to cure this situation safely.

> 
>> Making it a non-array seems to be an unnecessary hurdle for such
>> improvements. And regarding memory footprint, a single-element
>> array is equivalent to a non-array.
>> 
> 
> This comment was not about memory footprint, it's about sane code practices.

Well, I would consider using a 1-element array when the plan is to use an n-element
array as more future-proof...

But I have changed it for v5.

> 
>>> 
>>>> +static int w2sg_set_lna_power(struct w2sg_data *data)
>>>> +{
>>>> +	int ret = 0;
>>>> +	int off = data->suspended || !data->requested || data->lna_blocked;
>>>> +
>>>> +	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
>>>> +
>>>> +	if (off != data->lna_is_off) {
>>>> +		data->lna_is_off = off;
>>>> +		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
>>>> +			if (off)
>>>> +				regulator_disable(data->lna_regulator);
>>>> +			else
>>>> +				ret = regulator_enable(data->lna_regulator);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void w2sg_set_power(void *pdata, int val)
>>>> +{
>>>> +	struct w2sg_data *data = (struct w2sg_data *) pdata;
>>>> +
>>>> +	pr_debug("%s to state=%d (requested=%d)\n", __func__, val, data->requested);
>>>> +
>>>> +	if (val && !data->requested) {
>>>> +		data->requested = true;
>>>> +	} else if (!val && data->requested) {
>>>> +		data->backoff = HZ;
>>>> +		data->requested = false;
>>>> +	} else
>>>> +		return;
>>>> +
>>>> +	pr_debug("w2sg00x4 scheduled for %d\n", data->requested);
>>>> +
>>>> +	if (!data->suspended)
>>>> +		schedule_delayed_work(&data->work, 0);
>>>> +}
>>>> +
>>>> +/* called each time data is received by the UART (i.e. sent by the w2sg0004) */
>>>> +
>>>> +static int w2sg_uart_receive_buf(struct serdev_device *serdev,
>>>> +				const unsigned char *rxdata,
>>>> +				size_t count)
>>>> +{
>>>> +	struct w2sg_data *data =
>>>> +		(struct w2sg_data *) serdev_device_get_drvdata(serdev);
>>>> +
>>>> +	if (!data->requested && !data->is_on) {
>>>> +		/*
>>>> +		 * we have received characters while the w2sg
>>>> +		 * should have been be turned off
>>>> +		 */
>>>> +		data->discard_count += count;
>>>> +		if ((data->state == W2SG_IDLE) &&
>>>> +		    time_after(jiffies,
>>>> +		    data->last_toggle + data->backoff)) {
>>>> +			/* Should be off by now, time to toggle again */
>>>> +			pr_debug("w2sg00x4 has sent %d characters data although it should be off!\n",
>>>> +				data->discard_count);
>>>> +
>>>> +			data->discard_count = 0;
>>>> +
>>>> +			data->is_on = true;
>>>> +			data->backoff *= 2;
>>>> +			if (!data->suspended)
>>>> +				schedule_delayed_work(&data->work, 0);
>>>> +		}
>>>> +	} else if (data->open_count > 0) {
>>>> +		int n;
>>>> +
>>>> +		pr_debug("w2sg00x4: push %lu chars to tty port\n",
>>>> +			(unsigned long) count);
>>>> +
>>>> +		/* pass to user-space */
>>>> +		n = tty_insert_flip_string(&data->port, rxdata, count);
>>>> +		if (n != count)
>>>> +			pr_err("w2sg00x4: did loose %lu characters\n",
>>>> +				(unsigned long) (count - n));
>>>> +		tty_flip_buffer_push(&data->port);
>>>> +		return n;
>>>> +	}
>>>> +
>>>> +	/* assume we have processed everything */
>>>> +	return count;
>>>> +}
>>>> +
>>>> +/* try to toggle the power state by sending a pulse to the on-off GPIO */
>>>> +
>>> 
>>> drop extra line, same everywhere
>> 
>> Ok! Was just this and one more location.
>> 
>>> 
>>>> +static void toggle_work(struct work_struct *work)
>>>> +{
>>>> +	struct w2sg_data *data = container_of(work, struct w2sg_data,
>>>> +					      work.work);
>>>> +
>>>> +	switch (data->state) {
>>>> +	case W2SG_IDLE:
>>>> +		if (data->requested == data->is_on)
>>>> +			return;
>>>> +
>>>> +		w2sg_set_lna_power(data);	/* update LNA power state */
>>>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>>>> +		data->state = W2SG_PULSE;
>>>> +
>>>> +		pr_debug("w2sg: power gpio ON\n");
>>>> +
>>>> +		schedule_delayed_work(&data->work,
>>>> +				      msecs_to_jiffies(10));
>>>> +		break;
>>>> +
>>>> +	case W2SG_PULSE:
>>>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>>>> +		data->last_toggle = jiffies;
>>>> +		data->state = W2SG_NOPULSE;
>>>> +		data->is_on = !data->is_on;
>>>> +
>>>> +		pr_debug("w2sg: power gpio OFF\n");
>>>> +
>>>> +		schedule_delayed_work(&data->work,
>>>> +				      msecs_to_jiffies(10));
>>>> +		break;
>>>> +
>>>> +	case W2SG_NOPULSE:
>>>> +		data->state = W2SG_IDLE;
>>>> +
>>>> +		pr_debug("w2sg: idle\n");
>>>> +
>>>> +		break;
>>>> +
>>>> +	}
>>>> +}
>>>> +
>>>> +static int w2sg_rfkill_set_block(void *pdata, bool blocked)
>>>> +{
>>>> +	struct w2sg_data *data = pdata;
>>>> +
>>>> +	pr_debug("%s: blocked: %d\n", __func__, blocked);
>>>> +
>>>> +	data->lna_blocked = blocked;
>>>> +
>>>> +	return w2sg_set_lna_power(data);
>>>> +}
>>>> +
>>>> +static struct rfkill_ops w2sg0004_rfkill_ops = {
>>>> +	.set_block = w2sg_rfkill_set_block,
>>>> +};
>>>> +
>>>> +static struct serdev_device_ops serdev_ops = {
>>>> +	.receive_buf = w2sg_uart_receive_buf,
>>>> +};
>>>> +
>>>> +/*
>>>> + * we are a man-in the middle between the user-space visible tty port
>>>> + * and the serdev tty where the chip is connected.
>>>> + * This allows us to recognise when the device should be powered on
>>>> + * or off and handle the "false" state that data arrives while no
>>>> + * users-space tty client exists.
>>>> + */
>>>> +
>>>> +static struct w2sg_data *w2sg_get_by_minor(unsigned int minor)
>>>> +{
>>>> +	return w2sg_by_minor[minor];
>>>> +}
>>>> +
>>>> +static int w2sg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>>>> +{
>>>> +	struct w2sg_data *data;
>>>> +	int retval;
>>>> +
>>>> +	pr_debug("%s() tty = %p\n", __func__, tty);
>>>> +
>>>> +	data = w2sg_get_by_minor(tty->index);
>>>> +
>>>> +	if (!data)
>>>> +		return -ENODEV;
>>>> +
>>>> +	retval = tty_standard_install(driver, tty);
>>>> +	if (retval)
>>>> +		goto error_init_termios;
>>>> +
>>>> +	tty->driver_data = data;
>>>> +
>>>> +	return 0;
>>>> +
>>>> +error_init_termios:
>>>> +	tty_port_put(&data->port);
>>>> +	return retval;
>>>> +}
>>>> +
>>>> +static int w2sg_tty_open(struct tty_struct *tty, struct file *file)
>>>> +{
>>>> +	struct w2sg_data *data = tty->driver_data;
>>>> +
>>>> +	pr_debug("%s() data = %p open_count = ++%d\n", __func__, data, data->open_count);
>>>> +
>>>> +	w2sg_set_power(data, ++data->open_count > 0);
>>>> +
>>>> +	return tty_port_open(&data->port, tty, file);
>>>> +}
>>>> +
>>>> +static void w2sg_tty_close(struct tty_struct *tty, struct file *file)
>>>> +{
>>>> +	struct w2sg_data *data = tty->driver_data;
>>>> +
>>>> +	pr_debug("%s()\n", __func__);
>>>> +
>>>> +	w2sg_set_power(data, --data->open_count > 0);
>>>> +
>>>> +	tty_port_close(&data->port, tty, file);
>>>> +}
>>>> +
>>>> +static int w2sg_tty_write(struct tty_struct *tty,
>>>> +		const unsigned char *buffer, int count)
>>>> +{
>>>> +	struct w2sg_data *data = tty->driver_data;
>>>> +
>>>> +	/* simply pass down to UART */
>>>> +	return serdev_device_write_buf(data->uart, buffer, count);
>>>> +}
>>>> +
>>>> +static const struct tty_operations w2sg_serial_ops = {
>>>> +	.install = w2sg_tty_install,
>>>> +	.open = w2sg_tty_open,
>>>> +	.close = w2sg_tty_close,
>>>> +	.write = w2sg_tty_write,
>>>> +};
>>>> +
>>>> +static const struct tty_port_operations w2sg_port_ops = {
>>>> +};
>>> 
>>> drop the brackets? or use NULL below, not sure if this needs memory.
>> 
>> This allocates a struct tty_port_operations initialized with NULL for
>> all function pointers.
>> 
> 
> Then just drop the brackets, or allocate it with kzalloc.
> 
>> I am not sure if this is the same as providing no w2sg_port_ops at all.
>> 
>> Rather I think the serial core is only port == NULL safe but not
>> port->ops == NULL e.g.:
>> 
>> http://elixir.free-electrons.com/linux/v4.15-rc1/source/drivers/tty/tty_port.c#L422
>> 
>> A test confirms (see comment below):
>> 
>>> 
>>>> +
>>>> +static int w2sg_probe(struct serdev_device *serdev)
>>>> +{
>>>> +	struct w2sg_data *data;
>>>> +	struct rfkill *rf_kill;
>>>> +	int err;
>>>> +	int minor;
>>>> +	enum of_gpio_flags flags;
>>>> +
>>>> +	pr_debug("%s()\n", __func__);
>>>> +
>>>> +	minor = 0;
>>>> +	if (w2sg_by_minor[minor]) {
>>>> +		pr_err("w2sg minor is already in use!\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	data = devm_kzalloc(&serdev->dev, sizeof(*data), GFP_KERNEL);
>>>> +	if (data == NULL)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	w2sg_by_minor[minor] = data;
>> 
>> While looking through this, I found a potential issue if allocating the
>> gpio fails with -EPROBE_DEFER.
>> 
>> Then, we have set w2sg_by_minor[minor] != NULL and the above test will already
>> find it allocated on next deferred probe attempt.
>> 
>> So I'll move that to a position further down.
>> 
>>>> +
>>>> +	serdev_device_set_drvdata(serdev, data);
>>>> +
>>>> +	data->on_off_gpio = of_get_named_gpio_flags(serdev->dev.of_node,
>>>> +						     "enable-gpios", 0,
>>>> +						     &flags);
>>>> +	/* defer until we have all gpios */
>>>> +	if (data->on_off_gpio == -EPROBE_DEFER)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>>> +	data->lna_regulator = devm_regulator_get_optional(&serdev->dev,
>>>> +							"lna");
>>>> +	if (IS_ERR(data->lna_regulator)) {
>>>> +		/* defer until we can get the regulator */
>>>> +		if (PTR_ERR(data->lna_regulator) == -EPROBE_DEFER)
>>>> +			return -EPROBE_DEFER;
>>>> +
>>>> +		data->lna_regulator = NULL;
>>>> +	}
>>>> +	pr_debug("%s() lna_regulator = %p\n", __func__, data->lna_regulator);
>>>> +
>>>> +	data->lna_blocked = true;
>>>> +	data->lna_is_off = true;
>>>> +
>>>> +	data->is_on = false;
>>>> +	data->requested = false;
>>>> +	data->state = W2SG_IDLE;
>>>> +	data->last_toggle = jiffies;
>>>> +	data->backoff = HZ;
>>>> +
>>>> +	data->uart = serdev;
>>>> +
>>>> +	INIT_DELAYED_WORK(&data->work, toggle_work);
>>>> +
>>>> +	err = devm_gpio_request(&serdev->dev, data->on_off_gpio,
>>>> +				"w2sg0004-on-off");
>>>> +	if (err < 0)
>>>> +		goto out;
>>>> +
>>>> +	gpio_direction_output(data->on_off_gpio, false);
>>>> +
>>>> +	serdev_device_set_client_ops(data->uart, &serdev_ops);
>>>> +	serdev_device_open(data->uart);
>>>> +
>>>> +	serdev_device_set_baudrate(data->uart, 9600);
>>>> +	serdev_device_set_flow_control(data->uart, false);
>>>> +
>>>> +	rf_kill = rfkill_alloc("GPS", &serdev->dev, RFKILL_TYPE_GPS,
>>>> +				&w2sg0004_rfkill_ops, data);
>>>> +	if (rf_kill == NULL) {
>>>> +		err = -ENOMEM;
>>>> +		goto err_rfkill;
>>>> +	}
>>>> +
>>>> +	err = rfkill_register(rf_kill);
>>>> +	if (err) {
>>>> +		dev_err(&serdev->dev, "Cannot register rfkill device\n");
>>>> +		goto err_rfkill;
>>>> +	}
>>>> +
>>>> +	data->rf_kill = rf_kill;
>>>> +
>>>> +	/* allocate the tty driver */
>>>> +	data->tty_drv = alloc_tty_driver(1);
>>>> +	if (!data->tty_drv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	/* initialize the tty driver */
>>>> +	data->tty_drv->owner = THIS_MODULE;
>>>> +	data->tty_drv->driver_name = "w2sg0004";
>>>> +	data->tty_drv->name = "ttyGPS";
>>>> +	data->tty_drv->major = 0;
>>>> +	data->tty_drv->minor_start = 0;
>>>> +	data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>>>> +	data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>>>> +	data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>>>> +	data->tty_drv->init_termios = tty_std_termios;
>>>> +	data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>>>> +					      HUPCL | CLOCAL;
>>>> +	/*
>>>> +	 * optional:
>>>> +	 * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>>>> +					115200, 115200);
>>>> +	 * w2sg_tty_termios(&data->tty_drv->init_termios);
>>>> +	 */
>>>> +	tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>>>> +
>>>> +	/* register the tty driver */
>>>> +	err = tty_register_driver(data->tty_drv);
>>>> +	if (err) {
>>>> +		pr_err("%s - tty_register_driver failed(%d)\n",
>>>> +			__func__, err);
>>>> +		put_tty_driver(data->tty_drv);
>>>> +		goto err_rfkill;
>>>> +	}
>>>> +
>>>> +	tty_port_init(&data->port);
>>>> +	data->port.ops = &w2sg_port_ops;
>> 
>> A test setting this to NULL leads to a kernel oops in:
>> 
>> [ 3048.821258] [<c046c598>] (tty_port_open) from [<c0466328>] (tty_open+0x1e8/0x2d8)
>> 
>> So we must define this completely empty struct w2sg_port_ops
>> and pass a reference.
>> 
>>>> +
>>>> +	pr_debug("w2sg call tty_port_register_device\n");
>>>> +
>>>> +	data->dev = tty_port_register_device(&data->port,
>>>> +			data->tty_drv, minor, &serdev->dev);
>>>> +
>>>> +	pr_debug("w2sg probed\n");
>>>> +
>>>> +	/* keep off until user space requests the device */
>>>> +	w2sg_set_power(data, false);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_rfkill:
>>>> +	rfkill_destroy(rf_kill);
>>>> +	serdev_device_close(data->uart);
>>>> +out:
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static void w2sg_remove(struct serdev_device *serdev)
>>>> +{
>>>> +	struct w2sg_data *data = serdev_device_get_drvdata(serdev);
>>>> +	int minor;
>>>> +
>>>> +	cancel_delayed_work_sync(&data->work);
>>>> +
>>>> +	/* what is the right sequence to avoid problems? */
>>>> +	serdev_device_close(data->uart);
>>>> +
>>>> +	minor = 0;
>>>> +	tty_unregister_device(data->tty_drv, minor);
>>>> +
>>>> +	tty_unregister_driver(data->tty_drv);
>>>> +}
>>>> +
>>>> +static int w2sg_suspend(struct device *dev)
>>> 
>>> __maybe_unused, or if PM is disabled you will get a warning.
>> 
>> Ok.
>> 
>>> 
>>>> +{
>>>> +	struct w2sg_data *data = dev_get_drvdata(dev);
>>>> +
>>>> +	data->suspended = true;
>>>> +
>>>> +	cancel_delayed_work_sync(&data->work);
>>>> +
>>>> +	w2sg_set_lna_power(data);	/* shuts down if needed */
>>>> +
>>>> +	if (data->state == W2SG_PULSE) {
>>>> +		msleep(10);
>>>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>>>> +		data->last_toggle = jiffies;
>>>> +		data->is_on = !data->is_on;
>>>> +		data->state = W2SG_NOPULSE;
>>>> +	}
>>>> +
>>>> +	if (data->state == W2SG_NOPULSE) {
>>>> +		msleep(10);
>>>> +		data->state = W2SG_IDLE;
>>>> +	}
>>>> +
>>>> +	if (data->is_on) {
>>>> +		pr_info("GPS off for suspend %d %d %d\n", data->requested,
>>>> +			data->is_on, data->lna_is_off);
>>>> +
>>>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>>>> +		msleep(10);
>>>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>>>> +		data->is_on = 0;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int w2sg_resume(struct device *dev)
>>>> +{
>>>> +	struct w2sg_data *data = dev_get_drvdata(dev);
>>>> +
>>>> +	data->suspended = false;
>>>> +
>>>> +	pr_info("GPS resuming %d %d %d\n", data->requested,
>>>> +		data->is_on, data->lna_is_off);
>>>> +
>>>> +	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed */
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct of_device_id w2sg0004_of_match[] = {
>>>> +	{ .compatible = "wi2wi,w2sg0004" },
>>>> +	{ .compatible = "wi2wi,w2sg0084" },
>>>> +	{},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
>>>> +
>>>> +SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_suspend, w2sg_resume);
>>>> +
>>>> +static struct serdev_device_driver w2sg_driver = {
>>>> +	.probe		= w2sg_probe,
>>>> +	.remove		= w2sg_remove,
>>>> +	.driver = {
>>>> +		.name	= "w2sg0004",
>>>> +		.owner	= THIS_MODULE,
>>>> +		.pm	= &w2sg_pm_ops,
>>>> +		.of_match_table = of_match_ptr(w2sg0004_of_match)
>>>> +	},
>>>> +};
>>>> +
>>>> +module_serdev_device_driver(w2sg_driver);
>>>> +
>>>> +MODULE_ALIAS("w2sg0004");
>>> 
>>> Is this needed?
>> 
>> Seems to be redundant.
>> After removal the driver is still loaded automatically after boot:
>> 
>> root@letux:~# modprobe -c | fgrep w2sg
>> alias of:N*T*Cwi2wi,w2sg0004 w2sg0004
>> alias of:N*T*Cwi2wi,w2sg0004C* w2sg0004
>> alias of:N*T*Cwi2wi,w2sg0084 w2sg0004
>> alias of:N*T*Cwi2wi,w2sg0084C* w2sg0004
>> root@letux:~# lsmod | fgrep w2sg
>> w2sg0004               16384  2 
>> root@letux:~# 
>> 
>>> 
>>>> +
>>>> +MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
>>> 
>>> Who really wrote this?
>> 
>> Good question.
>> 
>> The problem is that with cleaning up the code and rewriting history over such
>> a long time, it is no more visible.
>> 
>> But I have searched through our older branches:
>> 
>> Neil Brown had developed the first version for v3.7 in 2013: 
>> http://git.goldelico.com/?p=gta04-kernel.git;a=commit;h=5b6fad7c7f15db8bb8e2c98ae9a50da52bda8b69
>> 
>> This is where the MODULE_AUTHOR line comes from.
>> 
>> Later, Marek Belisko worked on the UART driver, pinmux and interrupts.
>> 
>> And I have
>> * added lna-regulator and rfkill ca. v3.12
>> * added device tree support ca. v3.15
>> * moved to drivers/misc
>> * ported the code to serdev API ca. v4.11
>> * submitted to LKML and worked in comments by reviewers ca. 4.15
>> 
>> So this is the first version that is close to be acceptable.
>> 
>> Neil had also submitted different versions to LKML but I am not
>> sure if he still is active anywhere.
>> 
>> I have also checked a diff between the v3.7 version and the
>> current one and there are ca. 30-40% of lines original code by
>> Neil.
>> 
>> So I'd say:
>> 
>> * Neil is the original author and a significant amount of untouched code lines and comments are still there
>> * he designed the overall driver architecture
>> * Hence he is the copyright holder, did license under GPL v2 and we have just made a derivative work out of it
>> * Neil did submit his version of serdev ca. 2015 (quite different from this) but resigned after review feedback
>> * I did add some important features but not the core code and driver architecture
>> * I feel my role as maintainer and massaging everything for DT, serdev and get it upstream, but not "the author"
>> 
>> How should we best reflect this in the AUTHOR macro?
>> 
> 
> Easy:
> 
> MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
> MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
> 
> you can have more than one :)

Ah, that is much easier to solve than I had thought...

> 
>>> 
>>>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> 

[PATCH v5] now coming.

BR and thanks,
Nikolaus
