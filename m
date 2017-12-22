From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Date: Fri, 22 Dec 2017 15:40:12 +0100
Message-ID: <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171222124427.GI3374@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, letux-kernel@openphoenux.org, Thierry Reding <treding@nvidia.com>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Johan,

> Am 22.12.2017 um 13:44 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Fri, Dec 01, 2017 at 08:49:36AM +0100, H. Nikolaus Schaller wrote:
>> Add driver for Wi2Wi W2SG0004/84 GPS module connected to some SoC UART.
>> 
>> It uses serdev API hooks to monitor and forward the UART traffic to /dev/ttyGPSn
>> and turn on/off the module. It also detects if the module is turned on (sends data)
>> but should be off, e.g. if it was already turned on during boot or power-on-reset.
>> 
>> Additionally, rfkill block/unblock can be used to control an external LNA
>> (and power down the module if not needed).
>> 
>> The driver concept is based on code developed by Neil Brown <neilb@suse.de>
>> but simplified and adapted to use the new serdev API introduced in v4.11.
> 
> I'm sorry (and I know this discussion has been going on for a long
> time),

I'd say: already too much time.

> but this still feels like too much of a hack.

Well, to me it feels like review process is trying to get things 200% right
in the first step and therefore delays proposals that may already be useful
to real world users. Review is of course important to protect against severe
bugs and security issues.

My concern is that in 5 more years this chip is obsolete and then we never
had a working solution in distributions that base directly on kernel.org...

What I am lacking in this discussion is the spirit of starting with something
that basically works and permanently enhancing things. Like Linux started
25 years ago and many drivers look very different in v4.15 than v2.6.32.

Instead, we are sent back every time to rework it completely and at some point
our enthusiasm (and time budget) has boiled down to 0 because we see no more
reward for working on this.

> 
> You're registering a tty driver to allow user space to continue treat
> this as a tty device, but you provide no means of actually modifying
> anything (line settings, etc).

That was planned for a second step but is not important for pure GPS
reception.

> It's essentially just a character device
> with common tty ioctls as noops from a device PoV (well, plus the ldisc
> buffering and processing).

Yes. The buffering is the more important aspect and as far as I understand
we would have to implement our own buffer for a chardev driver. Buffering is
perfectly solved for tty devices.

Another aspect is that the same chip connected through an USB or Bluetooth
connection is presented as a tty device and not a char dev.

> This will probably require someone to first implement a generic gps
> framework with a properly defined interface which you may then teach
> gpsd to use (e.g. to avoid all its autodetection functionality) instead.

Yes, that is what I dream of.

But in past 5 years there was no "someone" to pop up and my time to work
on this topic is too limited. It is not even my main focus of efforts.

So I prefer solutions that can be done today with today's means and not
dreams (even if we share them).

> Or some entirely different approach, for example, where you manage
> everything from user space.

> 
> I'd suggest reiterating the problem you're trying to solve and
> enumerating the previously discussed potential solutions in order to
> find a proper abstraction level for this (before getting lost in
> implementation details).

Yes, please feel free to write patches that implement it that way.

> 
> That being said, I'm still pointing some bugs and issue below that you
> can consider for future versions of this (and other drivers) below.

Thanks!

> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/misc/Kconfig    |  10 +
>> drivers/misc/Makefile   |   1 +
>> drivers/misc/w2sg0004.c | 553 ++++++++++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 564 insertions(+)
>> create mode 100644 drivers/misc/w2sg0004.c
>> 
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index f1a5c2357b14..a3b11016ed2b 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -508,4 +508,14 @@ source "drivers/misc/mic/Kconfig"
>> source "drivers/misc/genwqe/Kconfig"
>> source "drivers/misc/echo/Kconfig"
>> source "drivers/misc/cxl/Kconfig"
>> +
>> +config W2SG0004
>> +	tristate "W2SG00x4 on/off control"
> 
> Please provide a better summary for what this driver does.

Ok.

> 
>> +	depends on GPIOLIB && SERIAL_DEV_BUS
>> +	help
>> +          Enable on/off control of W2SG00x4 GPS moduled connected

s/moduled/module/

> 
> Some whitespace issue here.

Ok.

> 
>> +	  to some SoC UART to allow powering up/down if the /dev/ttyGPSn
>> +	  is opened/closed.
>> +	  It also provides a rfkill gps name to control the LNA power.
>> +
>> endmenu
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 5ca5f64df478..d9d824b3d20a 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -50,6 +50,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
>> obj-y				+= mic/
>> obj-$(CONFIG_GENWQE)		+= genwqe/
>> obj-$(CONFIG_ECHO)		+= echo/
>> +obj-$(CONFIG_W2SG0004)		+= w2sg0004.o
>> obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
>> obj-$(CONFIG_CXL_BASE)		+= cxl/
>> obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
>> diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
>> new file mode 100644
>> index 000000000000..6bfd12eb8e02
>> --- /dev/null
>> +++ b/drivers/misc/w2sg0004.c
>> @@ -0,0 +1,553 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
>> + *
>> + * Copyright (C) 2013 Neil Brown <neilb@suse.de>
>> + * Copyright (C) 2015-2017 H. Nikolaus Schaller <hns@goldelico.com>,
>> + *						Golden Delicious Computers
>> + *
>> + * This receiver has an ON/OFF pin which must be toggled to
>> + * turn the device 'on' of 'off'.  A high->low->high toggle
> 
> s/of/or/

Ok.

> 
>> + * will switch the device on if it is off, and off if it is on.
>> + *
>> + * To enable receiving on/off requests we register with the
>> + * UART power management notifications.
> 
> No, the UART (serial device) would be the grandparent of your serdev
> device (for which you register PM callbacks).

Ah, thanks. This came from original description 5 years ago and if
you work too long on something you do no longer read what is really
written.

> 
>> + *
>> + * It is not possible to directly detect the state of the device.
> 
> Didn't the 0084 version have a pin for this?

AFAIR no and even if it had, it would not help for the 0004 device
(80% of the GTA04 devices have been built with the 0004 and there is no known
mechanism to detect the chip variant during runtime).

> 
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
>> + * on/off line.  data sheets says "two rtc ticks", whatever that means.
>> + * If we do it too soon it doesn't work.
>> + * So we have a state machine which uses the common work queue to ensure
>> + * clean transitions.
>> + * When a change is requested we record that request and only act on it
>> + * once the previous change has completed.
>> + * A change involves a 10ms low pulse, and a 990ms raised level, so only
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
> 
> These look like flags; use a bitfield rather than an int.

Well, yes. But what does it save? 8 bytes in memory?
If we use char it would not even save anything.

> 
>> +	unsigned long	last_toggle;
>> +	unsigned long	backoff;	/* time to wait since last_toggle */
>> +	int		on_off_gpio;	/* the on-off gpio number */
>> +	struct		serdev_device *uart;	/* uart connected to the chip */
>> +	struct		tty_driver *tty_drv;	/* this is the user space tty */
> 
> This does not belong in the device data as someone (Arnd?) already
> pointed out to you in a comment to an earlier version. More below.
> 
>> +	struct		device *dev;	/* from tty_port_register_device() */
>> +	struct		tty_port port;
>> +	int		open_count;	/* how often we were opened */
>> +	enum		w2sg_state state;
>> +	int		requested;	/* requested state (0/1) */
>> +	int		suspended;
>> +	struct delayed_work work;
>> +	int		discard_count;
>> +};
> 
> You seem to have completely ignored locking. These flags and resources
> are accessed from multiple contexts, and it all looks very susceptible
> to races (e.g. the work queue can race with the rfkill callback and
> leave the regulator enabled when it should be off).

Has never been observed in practise, but you are right to ask to consider.

> 
>> +/* should become w2sg_by_minor[n] if we want to support multiple devices */
>> +static struct w2sg_data *w2sg_by_minor;
>> +
>> +static int w2sg_set_lna_power(struct w2sg_data *data)
>> +{
>> +	int ret = 0;
>> +	int off = data->suspended || !data->requested || data->lna_blocked;
>> +
>> +	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
> 
> This and other pr_xxx should be replaced with dev_dbg and friends.

Ok.

> 
>> +
>> +	if (off != data->lna_is_off) {
>> +		data->lna_is_off = off;
>> +		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
>> +			if (off)
>> +				regulator_disable(data->lna_regulator);
>> +			else
>> +				ret = regulator_enable(data->lna_regulator);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void w2sg_set_power(void *pdata, int val)
> 
> Don't pass around void pointers like this.

Agreed. There might have been a reason years ago...
Maybe it was originally a callback handler with some opaque user-data pointer.

> 
>> +{
>> +	struct w2sg_data *data = (struct w2sg_data *) pdata;
>> +
>> +	pr_debug("%s to state=%d (requested=%d)\n", __func__, val,
>> +		 data->requested);
>> +
>> +	if (val && !data->requested) {
>> +		data->requested = true;
>> +	} else if (!val && data->requested) {
>> +		data->backoff = HZ;
>> +		data->requested = false;
>> +	} else
>> +		return;
> 
> Missing brackets.

Ok.

Interestingly there is no warning from checkpatch.

> 
>> +
>> +	if (!data->suspended)
>> +		schedule_delayed_work(&data->work, 0);
>> +}
>> +
>> +/* called each time data is received by the UART (i.e. sent by the w2sg0004) */
>> +static int w2sg_uart_receive_buf(struct serdev_device *serdev,
>> +				const unsigned char *rxdata,
>> +				size_t count)
>> +{
>> +	struct w2sg_data *data =
>> +		(struct w2sg_data *) serdev_device_get_drvdata(serdev);
>> +
>> +	if (!data->requested && !data->is_on) {
>> +		/*
>> +		 * we have received characters while the w2sg
>> +		 * should have been be turned off
>> +		 */
>> +		data->discard_count += count;
>> +		if ((data->state == W2SG_IDLE) &&
>> +		    time_after(jiffies,
>> +		    data->last_toggle + data->backoff)) {
>> +			/* Should be off by now, time to toggle again */
>> +			pr_debug("w2sg00x4 has sent %d characters data although it should be off!\n",
>> +				data->discard_count);
>> +
>> +			data->discard_count = 0;
>> +
>> +			data->is_on = true;
>> +			data->backoff *= 2;
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
>> +		n = tty_insert_flip_string(&data->port, rxdata, count);
>> +		if (n != count)
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
>> +/* try to toggle the power state by sending a pulse to the on-off GPIO */
>> +static void toggle_work(struct work_struct *work)
>> +{
>> +	struct w2sg_data *data = container_of(work, struct w2sg_data,
>> +					      work.work);
>> +
>> +	switch (data->state) {
>> +	case W2SG_IDLE:
>> +		if (data->requested == data->is_on)
>> +			return;
>> +
>> +		w2sg_set_lna_power(data);	/* update LNA power state */
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		data->state = W2SG_PULSE;
>> +
>> +		pr_debug("w2sg: power gpio ON\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_PULSE:
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle = jiffies;
>> +		data->state = W2SG_NOPULSE;
>> +		data->is_on = !data->is_on;
>> +
>> +		pr_debug("w2sg: power gpio OFF\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_NOPULSE:
>> +		data->state = W2SG_IDLE;
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
>> +	struct w2sg_data *data = pdata;
>> +
>> +	pr_debug("%s: blocked: %d\n", __func__, blocked);
>> +
>> +	data->lna_blocked = blocked;
>> +
>> +	return w2sg_set_lna_power(data);
>> +}
>> +
>> +static struct rfkill_ops w2sg0004_rfkill_ops = {
>> +	.set_block = w2sg_rfkill_set_block,
>> +};
>> +
>> +static struct serdev_device_ops serdev_ops = {
>> +	.receive_buf = w2sg_uart_receive_buf,
>> +};
>> +
>> +/*
>> + * we are a man-in the middle between the user-space visible tty port
>> + * and the serdev tty where the chip is connected.
>> + * This allows us to recognise when the device should be powered on
>> + * or off and handle the "false" state that data arrives while no
>> + * users-space tty client exists.
>> + */
>> +
>> +static struct w2sg_data *w2sg_get_by_minor(unsigned int minor)
>> +{
>> +	BUG_ON(minor >= 1);
> 
> Never use BUG_ON in driver code.

Ok.

> 
>> +	return w2sg_by_minor;
>> +}
>> +
>> +static int w2sg_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>> +{
>> +	struct w2sg_data *data;
>> +	int retval;
>> +
>> +	pr_debug("%s() tty = %p\n", __func__, tty);
>> +
>> +	data = w2sg_get_by_minor(tty->index);
>> +
>> +	if (!data)
>> +		return -ENODEV;
>> +
>> +	retval = tty_standard_install(driver, tty);
>> +	if (retval)
>> +		goto error_init_termios;
>> +
>> +	tty->driver_data = data;
>> +
>> +	return 0;
>> +
>> +error_init_termios:
>> +	tty_port_put(&data->port);
> 
> Where's the corresponding get?

I think we copied gb_tty_install or something alike

http://elixir.free-electrons.com/linux/v4.15-rc4/source/drivers/staging/greybus/uart.c#L393

but that might be buggy or we didn't copy all (tty_port-get) what is needed to make it correct.

> 
>> +	return retval;
>> +}
>> +
>> +static int w2sg_tty_open(struct tty_struct *tty, struct file *file)
>> +{
>> +	struct w2sg_data *data = tty->driver_data;
>> +
>> +	pr_debug("%s() data = %p open_count = ++%d\n", __func__,
>> +		 data, data->open_count);
>> +
>> +	w2sg_set_power(data, ++data->open_count > 0);
>> +
>> +	return tty_port_open(&data->port, tty, file);
> 
> You'd leave the open count incremented on errors here.

Ok.

> 
>> +}
>> +
>> +static void w2sg_tty_close(struct tty_struct *tty, struct file *file)
>> +{
>> +	struct w2sg_data *data = tty->driver_data;
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
>> +	struct w2sg_data *data = tty->driver_data;
>> +
>> +	/* simply pass down to UART */
>> +	return serdev_device_write_buf(data->uart, buffer, count);
>> +}
>> +
>> +static const struct tty_operations w2sg_serial_ops = {
>> +	.install = w2sg_tty_install,
>> +	.open = w2sg_tty_open,
>> +	.close = w2sg_tty_close,
>> +	.write = w2sg_tty_write,
>> +};
>> +
>> +static const struct tty_port_operations w2sg_port_ops = {
>> +	/* none defined, but we need the struct */
>> +};
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
>> +	/*
>> +	 * For future consideration:
>> +	 * for multiple such GPS receivers in one system
>> +	 * we need a mechanism to define distinct minor values
>> +	 * and search for an unused one.
>> +	 */
>> +	minor = 0;
>> +	if (w2sg_get_by_minor(minor)) {
>> +		pr_err("w2sg minor is already in use!\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	data = devm_kzalloc(&serdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (data == NULL)
>> +		return -ENOMEM;
>> +
>> +	serdev_device_set_drvdata(serdev, data);
>> +
>> +	data->on_off_gpio = of_get_named_gpio_flags(serdev->dev.of_node,
>> +						     "enable-gpios", 0,
>> +						     &flags);
> 
> You should be using gpio descriptors and not the legacy interface.

Ok.

> 
>> +	/* defer until we have all gpios */
>> +	if (data->on_off_gpio == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
>> +
>> +	data->lna_regulator = devm_regulator_get_optional(&serdev->dev,
>> +							"lna");
>> +	if (IS_ERR(data->lna_regulator)) {
>> +		/* defer until we can get the regulator */
>> +		if (PTR_ERR(data->lna_regulator) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +
>> +		data->lna_regulator = NULL;
>> +	}
>> +	pr_debug("%s() lna_regulator = %p\n", __func__, data->lna_regulator);
>> +
>> +	data->lna_blocked = true;
>> +	data->lna_is_off = true;
>> +
>> +	data->is_on = false;
>> +	data->requested = false;
>> +	data->state = W2SG_IDLE;
>> +	data->last_toggle = jiffies;
>> +	data->backoff = HZ;
>> +
>> +	data->uart = serdev;
>> +
>> +	INIT_DELAYED_WORK(&data->work, toggle_work);
>> +
>> +	err = devm_gpio_request(&serdev->dev, data->on_off_gpio,
>> +				"w2sg0004-on-off");
>> +	if (err < 0)
>> +		goto out;
> 
> Just return unless you're actually undwinding something.
> 
>> +
>> +	gpio_direction_output(data->on_off_gpio, false);
>> +
>> +	serdev_device_set_client_ops(data->uart, &serdev_ops);
>> +	serdev_device_open(data->uart);
> 
> Missing error handling.

> 
> And always keeping the port open would in most cases prevent the serial
> controller from runtime suspending.

Ok.

> 
>> +
>> +	serdev_device_set_baudrate(data->uart, 9600);
>> +	serdev_device_set_flow_control(data->uart, false);
> 
> So you hardcode these settings and provide no means for user space to
> change them. This may make sense for this GPS, but it looks like at
> least some of the wi2wi 0084 modules use 4800 baud ("i"-versions?).

That is new to me that there is an i-version (we don't have it in use).

If you have such a device, please feel free to integrate a dynamic
setting depending on chip variant (e.g. based on compatible string).

> 
>> +
>> +	rf_kill = rfkill_alloc("GPS", &serdev->dev, RFKILL_TYPE_GPS,
>> +				&w2sg0004_rfkill_ops, data);
>> +	if (rf_kill == NULL) {
>> +		err = -ENOMEM;
>> +		goto err_rfkill;
> 
> Name error labels after what they do (not where you jump from).

Ok.

> 
> That may have prevented the NULL deref you'd trigger in the error path
> here.
> 
>> +	}
>> +
>> +	err = rfkill_register(rf_kill);
>> +	if (err) {
>> +		dev_err(&serdev->dev, "Cannot register rfkill device\n");
>> +		goto err_rfkill;
>> +	}
>> +
>> +	data->rf_kill = rf_kill;
>> +
>> +	/* allocate the tty driver */
>> +	data->tty_drv = alloc_tty_driver(1);
> 
> As was already pointed out by Arnd in a review of an previous version of
> this series, this must not be done at probe (do it at module init). We
> don't want separate tty drivers for every device.

Looks as if we should use tty_alloc_driver() in addition.

> 
>> +	if (!data->tty_drv)
>> +		return -ENOMEM;
> 
> Here you'd leak the registered rfkill structure, and leave the port
> open.

Ok.

> 
>> +
>> +	/* initialize the tty driver */
>> +	data->tty_drv->owner = THIS_MODULE;
>> +	data->tty_drv->driver_name = "w2sg0004";
>> +	data->tty_drv->name = "ttyGPS";
> 
> I don't think you should be claiming this generic namespace for
> something as specific as this.

Suggestion?

> 
>> +	data->tty_drv->major = 0;
>> +	data->tty_drv->minor_start = 0;
>> +	data->tty_drv->type = TTY_DRIVER_TYPE_SERIAL;
>> +	data->tty_drv->subtype = SERIAL_TYPE_NORMAL;
>> +	data->tty_drv->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>> +	data->tty_drv->init_termios = tty_std_termios;
>> +	data->tty_drv->init_termios.c_cflag = B9600 | CS8 | CREAD |
>> +					      HUPCL | CLOCAL;
>> +	/*
>> +	 * optional:
>> +	 * tty_termios_encode_baud_rate(&data->tty_drv->init_termios,
>> +					115200, 115200);
>> +	 * w2sg_tty_termios(&data->tty_drv->init_termios);
>> +	 */
> 
> Why is this here?

Was planned to integrate in a second step.

> 
>> +	tty_set_operations(data->tty_drv, &w2sg_serial_ops);
>> +
>> +	/* register the tty driver */
>> +	err = tty_register_driver(data->tty_drv);
>> +	if (err) {
>> +		pr_err("%s - tty_register_driver failed(%d)\n",
>> +			__func__, err);
>> +		put_tty_driver(data->tty_drv);
>> +		goto err_rfkill;
>> +	}
>> +
>> +	/* minor (0) is now in use */
>> +	w2sg_by_minor = data;
>> +
>> +	tty_port_init(&data->port);
>> +	data->port.ops = &w2sg_port_ops;
>> +
>> +	data->dev = tty_port_register_device(&data->port,
>> +			data->tty_drv, minor, &serdev->dev);
> 
> Missing error handling.

Ok.

> 
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
>> +	struct w2sg_data *data = serdev_device_get_drvdata(serdev);
>> +	int minor;
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	/* what is the right sequence to avoid problems? */
> 
> Clearly that's something you need to determine.

Well, I had hoped that the review process helps us here.

I do not have the same deep understanding of tty and serdev as all reviewers.
And there isn't much documentation beyond the code.

So in other words: I have no idea how to determine.

> 
>> +	serdev_device_close(data->uart);
>> +
>> +	/* we should lookup in w2sg_by_minor */
>> +	minor = 0;
>> +	tty_unregister_device(data->tty_drv, minor);
>> +
>> +	tty_unregister_driver(data->tty_drv);
>> +}
>> +
>> +static int __maybe_unused w2sg_suspend(struct device *dev)
>> +{
>> +	struct w2sg_data *data = dev_get_drvdata(dev);
>> +
>> +	data->suspended = true;
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	w2sg_set_lna_power(data);	/* shuts down if needed */
>> +
>> +	if (data->state == W2SG_PULSE) {
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle = jiffies;
>> +		data->is_on = !data->is_on;
>> +		data->state = W2SG_NOPULSE;
>> +	}
>> +
>> +	if (data->state == W2SG_NOPULSE) {
>> +		msleep(10);
>> +		data->state = W2SG_IDLE;
>> +	}
>> +
>> +	if (data->is_on) {
>> +		pr_info("GPS off for suspend %d %d %d\n", data->requested,
>> +			data->is_on, data->lna_is_off);
>> +
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->is_on = 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused w2sg_resume(struct device *dev)
>> +{
>> +	struct w2sg_data *data = dev_get_drvdata(dev);
>> +
>> +	data->suspended = false;
>> +
>> +	pr_info("GPS resuming %d %d %d\n", data->requested,
>> +		data->is_on, data->lna_is_off);
>> +
>> +	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed */
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id w2sg0004_of_match[] = {
>> +	{ .compatible = "wi2wi,w2sg0004" },
>> +	{ .compatible = "wi2wi,w2sg0084" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
>> +
>> +SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_suspend, w2sg_resume);
>> +
>> +static struct serdev_device_driver w2sg_driver = {
>> +	.probe		= w2sg_probe,
>> +	.remove		= w2sg_remove,
>> +	.driver = {
>> +		.name	= "w2sg0004",
>> +		.owner	= THIS_MODULE,
>> +		.pm	= &w2sg_pm_ops,
>> +		.of_match_table = of_match_ptr(w2sg0004_of_match)
>> +	},
>> +};
>> +
>> +module_serdev_device_driver(w2sg_driver);
>> +
>> +MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
>> +MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>> +MODULE_LICENSE("GPL v2");
> 
> Johan

It looks as if you understand much better than us how this driver
should be written.

So, I would be happy if you take over development based on what we
suggest.

Please feel free to modify it as you think it is right. I can then
test your version on our hardware and report issues.

BR and thanks,
Nikolaus Schaller
