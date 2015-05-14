From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Wed, 13 May 2015 21:06:34 -0500
Message-ID: <20150514020634.GB20006@saruman.tx.rr.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <1431560196-5722-3-git-send-email-tony@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431560196-5722-3-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 13, 2015 at 04:36:33PM -0700, Tony Lindgren wrote:
> Turns out we can automate the handling for the device_may_wakeup()
> quite a bit by using the kernel wakeup source list.
>=20
> And as some hardware has separate dedicated wake-up interrupt
> in addition to the IO interrupt, we can automate the handling by
> adding a generic threaded interrupt handler that just calls the
> device PM runtime to wake up the device.
>=20
> This allows dropping code from device drivers as we currently
> are doing it in multiple ways, and often wrong.
>=20
> For most drivers, we should be able to drop the following
> boilerplate code from runtime_suspend and runtime_resume
> functions:
>=20
> 	...
> 	if (device_may_wakeup(dev)
> 		enable_irq_wake(irq);
> 	...
> 	if (device_may_wakeup(dev)
> 		enable_irq_wake(irq);
> 	...
>=20
> We can replace it with just the following init and exit
> time code:
>=20
> 	...
> 	device_init_wakeup(dev, true);
> 	dev_pm_set_wake_irq(dev, irq);
> 	...
> 	dev_pm_clear_wake_irq(dev);
> 	device_init_wakeup(dev, false);
> 	...
>=20
> And for hardware with dedicated wake-up interrupts:
>=20
> 	...
> 	device_init_wakeup(dev, true);
> 	dev_pm_request_wake_irq(dev, wakeirq, NULL, 0, NULL);
> 	...
> 	dev_pm_enable_wake_irq(dev);
> 	...
> 	dev_pm_disable_wake_irq(dev);
> 	...
> 	dev_pm_free_wake_irq(dev);
> 	device_init_wakeup(dev, false);
> 	...
>=20
> For now, let's only enable it for select PM_WAKEIRQ.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig  |   1 +
>  drivers/base/power/Makefile  |   1 +
>  drivers/base/power/main.c    |   2 +
>  drivers/base/power/power.h   |  38 ++++++
>  drivers/base/power/wakeirq.c | 316 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/base/power/wakeup.c  |  96 +++++++++++++
>  include/linux/pm.h           |   2 +
>  include/linux/pm_wakeirq.h   |  72 ++++++++++
>  include/linux/pm_wakeup.h    |   7 +
>  kernel/power/Kconfig         |   4 +
>  10 files changed, 539 insertions(+)
>  create mode 100644 drivers/base/power/wakeirq.c
>  create mode 100644 include/linux/pm_wakeirq.h
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 6468f15..ac7b570 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -85,6 +85,7 @@ config ARCH_OMAP2PLUS
>  	select OMAP_DM_TIMER
>  	select OMAP_GPMC
>  	select PINCTRL
> +	select PM_WAKEIRQ if PM_SLEEP
>  	select SOC_BUS
>  	select TI_PRIV_EDMA
>  	select OMAP_IRQCHIP

seems like enabling this for OMAP should be a patch of its own.

> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 1cb8544..527546e 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_TRACE_RTC)	+=3D trace.o
>  obj-$(CONFIG_PM_OPP)	+=3D opp.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=3D  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK)	+=3D clock_ops.o
> +obj-$(CONFIG_PM_WAKEIRQ)	+=3D wakeirq.o
> =20
>  ccflags-$(CONFIG_DEBUG_DRIVER) :=3D -DDEBUG
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..24515e7 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -587,6 +587,7 @@ void dpm_resume_noirq(pm_message_t state)
>  	async_synchronize_full();
>  	dpm_show_time(starttime, state, "noirq");
>  	resume_device_irqs();
> +	device_wakeup_disarm_wakeirqs();
>  	cpuidle_resume();
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
>  }
> @@ -1104,6 +1105,7 @@ int dpm_suspend_noirq(pm_message_t state)
> =20
>  	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
>  	cpuidle_pause();
> +	device_wakeup_arm_wakeirqs();
>  	suspend_device_irqs();
>  	mutex_lock(&dpm_list_mtx);
>  	pm_transition =3D state;
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index b6b8a27..6183c5d 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -20,6 +20,44 @@ static inline void pm_runtime_early_init(struct device=
 *dev)
>  extern void pm_runtime_init(struct device *dev);
>  extern void pm_runtime_remove(struct device *dev);
> =20
> +#ifdef CONFIG_PM_WAKEIRQ
> +
> +extern int device_wakeup_attach_irq(struct device *dev,
> +				    struct wake_irq *wakeirq);
> +extern void device_wakeup_detach_irq(struct device *dev);
> +extern void device_wakeup_arm_wakeirqs(void);
> +extern void device_wakeup_disarm_wakeirqs(void);
> +
> +extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
> +extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
> +
> +#else
> +
> +static inline int
> +device_wakeup_attach_irq(struct device *dev,
> +			 struct wake_irq *wakeirq)
> +{
> +	return 0;
> +}
> +
> +static inline void device_wakeup_detach_irq(struct device *dev)
> +{
> +}
> +
> +static inline void device_wakeup_arm_wakeirqs(void)
> +{
> +}
> +
> +static inline void dev_pm_arm_wake_irq(struct wake_irq *wirq)
> +{
> +}
> +
> +static inline void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
> +{
> +}
> +
> +#endif /* CONFIG_PM_WAKEIRQ */
> +
>  /*
>   * sysfs.c
>   */
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> new file mode 100644
> index 0000000..579157b
> --- /dev/null
> +++ b/drivers/base/power/wakeirq.c
> @@ -0,0 +1,316 @@
> +/*
> + * wakeirq.c - Device wakeirq helper functions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
> +
> +#include "power.h"
> +
> +/**
> + * dev_pm_attach_wake_irq - Attach device interrupt as a wake IRQ
> + * @dev: Device entry
> + * @irq: Device wake-up capable interrupt
> + * @wirq: Wake irq specific data
> + *
> + * Internal function to attach either a device IO interrupt or a
> + * dedicated wake-up interrupt as a wake IRQ.
> + */
> +static int dev_pm_attach_wake_irq(struct device *dev, int irq,
> +				  struct wake_irq *wirq)
> +{
> +	unsigned long flags;
> +	int err;
> +
> +	if (!dev || !wirq)
> +		return -EINVAL;
> +
> +	if (!dev->power.wakeup) {
> +		dev_err(dev, "forgot to call call device_init_wakeup?\n");
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	if (WARN_ON(dev->power.wakeirq)) {
> +		dev_err(dev, "wake irq already initialized\n");
> +		err =3D -EEXIST;
> +		goto err_unlock;
> +	}
> +
> +	dev->power.wakeirq =3D wirq;
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +	err =3D device_wakeup_attach_irq(dev, wirq);
> +	if (err)
> +		goto err_free_mem;
> +
> +	return 0;
> +
> +err_unlock:
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +err_free_mem:

minor nit, there's no memory being freed here :-)

> +	return err;
> +}
> +
> +/**
> + * dev_pm_set_wake_irq - Attach device IO interrupt as wake IRQ
> + * @dev: Device entry
> + * @irq: Device IO interrupt
> + *
> + * Attach a device IO interrupt as a wake IRQ. The wake IRQ gets
> + * automatically configured for wake-up from suspend  based
> + * on the device specific sysfs wakeup entry. Typically called
> + * during driver probe after calling device_init_wakeup().
> + */
> +int dev_pm_set_wake_irq(struct device *dev, int irq)
> +{
> +	struct wake_irq *wirq;
> +	int err;
> +
> +	wirq =3D devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
> +	if (!wirq)
> +		return -ENOMEM;
> +
> +	wirq->dev =3D dev;
> +	wirq->irq =3D irq;
> +
> +	err =3D dev_pm_attach_wake_irq(dev, irq, wirq);
> +	if (err)
> +		devm_kfree(dev, wirq);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
> +
> +/**
> + * dev_pm_clear_wake_irq - Detach a device IO interrupt wake IRQ
> + * @dev: Device entry
> + *
> + * Detach a device IO interrupt wake IRQ and free resources.
> + */
> +void dev_pm_clear_wake_irq(struct device *dev)
> +{
> +	struct wake_irq *wirq =3D dev->power.wakeirq;
> +	unsigned long flags;
> +
> +	if (!wirq)

WARN() to catch bad users ? Maybe with unlikely() around to give
compiler a hint that this is likely not going to happen ?

> +		return;
> +
> +	device_wakeup_detach_irq(dev);
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	dev->power.wakeirq =3D NULL;
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +	wirq->irq =3D -EINVAL;
> +	devm_kfree(dev, wirq);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
> +
> +/**
> + * handle_threaded_wakeirq - Handler for dedicated wake-up interrupts
> + * @irq: Device dedicated wake-up interrupt
> + * @_wirq: Wake IRQ data
> + *
> + * Some devices have a separate wake-up interrupt in addition to the
> + * device IO interrupt. The wake-up interrupts signal that the device
> + * should be woken up from a idle state. This handler uses device
> + * specific pm_runtime functions to wake the device and then it's
> + * up to the device to do whatever it needs to. Note as the device
> + * may need to restore context and start up regulators, we use a
> + * threaded IRQ.
> + *
> + * Also note that we are not resending the lost device interrupts.
> + * We assume that the wake-up interrupt just needs to wake-up the
> + * device, and the device pm_runtime_resume() can deal with the
> + * situation.
> + */
> +static irqreturn_t handle_threaded_wakeirq(int wakeirq, void *_wirq)
> +{
> +	struct wake_irq *wirq =3D _wirq;
> +	irqreturn_t ret =3D IRQ_NONE;
> +
> +	if (!pm_runtime_suspended(wirq->dev))

should you WARN() here ? Why would this IRQ fire if we're not
pm_runtime_suspended() ?

> +		goto out;
> +
> +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> +	pm_runtime_resume(wirq->dev);
> +	ret =3D IRQ_HANDLED;
> +
> +	if (wirq->handler)
> +		ret =3D wirq->handler(wakeirq, wirq->data);
> +out:
> +	return ret;
> +}
> +
> +/**
> + * dev_pm_request_wake_irq - Request a dedicated wake-up interrupt
> + * @dev: Device entry
> + * @irq: Device wake-up interrupt
> + * @handler: Optional device specific handler
> + * @irqflags: Optional irqflags, IRQF_ONESHOT if not specified
> + * @data: Optional device specific data
> + *
> + * Unless your hardware has separate wake-up interrupts in addition
> + * to the device IO interrupts, you don't need this.
> + *
> + * Sets up a threaded interrupt handler for a device that has
> + * a dedicated wake-up interrupt in addition to the device IO
> + * interrupt.
> + *
> + * The interrupt starts disabled, and needs to be managed for
> + * the device by the bus code or the device driver using
> + * dev_pm_enable_wake_irq() and dev_pm_disable_wake_irq()
> + * functions.
> + */
> +int dev_pm_request_wake_irq(struct device *dev,
> +			    int irq,
> +			    irq_handler_t handler,
> +			    unsigned long irqflags,
> +			    void *data)
> +{
> +	struct wake_irq *wirq;
> +	int err;
> +
> +	wirq =3D devm_kzalloc(dev, sizeof(*wirq), GFP_KERNEL);
> +	if (!wirq)
> +		return -ENOMEM;
> +
> +	wirq->dev =3D dev;
> +	wirq->irq =3D irq;
> +	wirq->handler =3D handler;

you need to make sure that IRQF_ONESHOT is set in cases where handler is
NULL. Either set it by default:

	if (!handler)
		irqflags |=3D IRQF_ONESHOT;

or WARN() about it:

	WARN_ON((!handler && !(irqflags & IRQF_ONESHOT));

Actually, after reading more of the code, you have some weird circular
call chain going on here. If handler is a valid function pointer, you
use as primary handler, so IRQ core will call it from hardirq context.
But you also save that pointer as wirq->handler, and call that from
within handle_threaded_wakeirq(). Essentially, handler() is called
twice, once with IRQs disabled, one with IRQs (potentially) enabled.

What did you have in mind for handler() anyway, it seems completely
unnecessary.

> +	wirq->data =3D data;
> +	if (!irqflags) {
> +		irqflags =3D IRQF_ONESHOT;
> +		wirq->manage_irq =3D true;
> +	}
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +
> +	/*
> +	 * Consumer device may need to power up and restore state
> +	 * so we use a threaded irq.
> +	 */
> +	err =3D devm_request_threaded_irq(dev, irq, handler,
> +					handle_threaded_wakeirq,
> +					irqflags, dev_name(dev),
> +					wirq);
> +	if (err)
> +		goto err_free;
> +
> +	err =3D dev_pm_attach_wake_irq(dev, irq, wirq);
> +	if (err)
> +		goto err_free_irq;
> +
> +	return err;
> +
> +err_free_irq:
> +	devm_free_irq(dev, irq, wirq);
> +err_free:
> +	devm_kfree(dev, wirq);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_request_wake_irq);
> +
> +/**
> + * dev_pm_free_wake_irq - Free a wake-up interrupt
> + * @wirq: Device wake-up interrupt
> + */
> +void dev_pm_free_wake_irq(struct device *dev)
> +{
> +	struct wake_irq *wirq =3D dev->power.wakeirq;
> +	unsigned long flags;
> +
> +	if (!wirq)
> +		return;
> +
> +	spin_lock_irqsave(&dev->power.lock, flags);
> +	wirq->manage_irq =3D false;
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
> +	devm_free_irq(wirq->dev, wirq->irq, wirq);

this seems unnecessary, the IRQ will be freed anyway when the device
kobj is destroyed, dev_pm_clear_wake_irq() seems important, however.

> +	dev_pm_clear_wake_irq(dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_free_wake_irq);
> +
> +/**
> + * dev_pm_enable_wake_irq - Enable device wake-up interrupt
> + * @dev: Device
> + *
> + * Called from the bus code or the device driver for
> + * runtime_suspend() to enable the wake-up interrupt while
> + * the device is running.
> + *
> + * Note that for runtime_suspend()) the wake-up interrupts
> + * should be unconditionally enabled unlike for suspend()
> + * that is conditional.
> + */
> +void dev_pm_enable_wake_irq(struct device *dev)
> +{
> +	struct wake_irq *wirq =3D dev->power.wakeirq;
> +
> +	if (wirq && wirq->manage_irq)
> +		enable_irq(wirq->irq);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_enable_wake_irq);

you probably want to enable dev_pm_enable_wake_irq() automatically for
=66rom rpm_suspend(). According to runtime_pm documentation, wakeup should
always be enabled for runtime suspended devices. I didn't really look
through the whole thing yet to know if you did call it or not.

> +/**
> + * dev_pm_disable_wake_irq - Disable device wake-up interrupt
> + * @dev: Device
> + *
> + * Called from the bus code or the device driver for
> + * runtime_resume() to disable the wake-up interrupt while
> + * the device is running.
> + */
> +void dev_pm_disable_wake_irq(struct device *dev)
> +{
> +	struct wake_irq *wirq =3D dev->power.wakeirq;
> +
> +	if (wirq && wirq->manage_irq)
> +		disable_irq_nosync(wirq->irq);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_disable_wake_irq);

likewise, call this automatically from rpm_resume().

This brings up a question, actually. What to do with devices which were
already runtime suspended when user initiated suspend-to-ram ? Do we
leave wakeups enabled, or do we revisit device_may_wakeup() and
conditionally runtime_resume the device, disable wakeup, and let its
->suspend() callback be called ?

--=20
balbi

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVAMqAAoJEIaOsuA1yqREnpQP/1BGuBU/fwyBKjMFpUCioH23
uCy+x67FDobZ7x8haaqMgw1RmoezNprjs7gPGJGkU04QAZ+SVS9V2glk+0adavhL
H60dCuCKsjR47X/OnU0KMYz2jNOjaqrPuz2RCP+1LFJRmyQrQ8JCxkJNq/BuKNNn
CgrKLFA0xnGAiOmwsGrAtRQc20GQJBcWdYGA8pC3MD0GFtOu6sVnZMJJoprQHquT
rXmWcGyZlSpvd3oDWcoZaky4GkUWaQa2Cw9TQYC5TcXzV07k24jJt+SlDEU87v8k
pcgS+kAAB0m3dbjIhUqVVH+GR+I7tkR/pAkK4aYsMgHt7Rw8HNhJ6XOyO1abjv33
J4hSiBTM8li/nmHCTDJ/fKeFJG4mFPHigjU0NI78VXlFmFUFSs48yoN0+CInT2Hl
Q/3GRVx+2d7uvtnwryanIxdz2tt63Mj3hluUt4GzFnMFr3eELMO1qVW3J/+Qqsil
dVrygNWhmAYZDSsPj+3PLtNb7Vwfp4sWfIYBfjVh8sljLzVvO+JQ5Jc472v+AaKP
7hSiH4+yE1Nzm49gsXSVcL8RVWc+U1JrGC2YccE2qDYaCaHLvERqsymXv/IkYaDP
g1UsmBB43VqIr3FwOuGld7+DKHNf0Q5RwKkgE5conSKOzOWuM76cV6wwkPSi20Df
0ASd+HDt7iDhzb6Gnct7
=odhO
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
