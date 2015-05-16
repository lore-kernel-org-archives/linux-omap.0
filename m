From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] PM / Wakeirq: Add automated device wake IRQ handling
Date: Fri, 15 May 2015 20:56:51 -0500
Message-ID: <20150516015651.GA7493@saruman.tx.rr.com>
References: <1431560196-5722-1-git-send-email-tony@atomide.com>
 <20150514155945.GL15563@atomide.com>
 <20150514211501.GO15563@atomide.com>
 <3499196.MCAcS31ICO@vostro.rjw.lan>
 <20150514215921.GQ15563@atomide.com>
 <20150515222513.GB10274@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150515222513.GB10274@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Balbi <balbi@ti.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2015 at 03:25:13PM -0700, Tony Lindgren wrote:

<snip>

> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> new file mode 100644
> index 0000000..1125481
> --- /dev/null
> +++ b/drivers/base/power/wakeirq.c
> @@ -0,0 +1,276 @@
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
> +#include <linux/slab.h>
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

these two can be combined if you can live with a WARN_ONCE() instead:

	if (dev_WARN_ONCE(dev, dev->power.wakeirq,
		"wake irq already initialized\n")) {
		spin_unlock_irqrestore(&dev->power.lock, flags);
		return -EEXIST;
	}

dev_WARN() needs to be fixed at some point to accept a "condition"
argument :s

But really, no strong feelings.

> +static irqreturn_t handle_threaded_wakeirq(int wakeirq, void *_wirq)
> +{
> +	struct wake_irq *wirq =3D _wirq;
> +
> +	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
> +	return pm_runtime_resume(wirq->dev) ? IRQ_NONE : IRQ_HANDLED;

I wonder if you should add a pm_runtime_mark_last_busy() here. I guess
not after your previous patch ?

> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 7726200..7191519 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -238,6 +239,100 @@ int device_wakeup_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_wakeup_enable);
> =20
> +#ifdef CONFIG_PM_WAKEIRQ
> +
> +/**
> + * device_wakeup_attach_irq - Attach a wakeirq to a wakeup source
> + * @dev: Device to handle
> + * @irq: Device specific wakeirq entry

s/irq/wakeirq to match argument name below ?

> + * Attach a device specific wakeirq to the device specific
> + * wakeup source so the device wakeirq can be configured
> + * automatically for suspend and resume.
> + */
> +int device_wakeup_attach_irq(struct device *dev,
> +			     struct wake_irq *wakeirq)
> +{
> +	struct wakeup_source *ws;
> +	int ret =3D 0;
> +
> +	spin_lock_irq(&dev->power.lock);
> +	ws =3D dev->power.wakeup;
> +	if (!ws) {
> +		ret =3D -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (ws->wakeirq) {
> +		ret =3D -EEXIST;
> +		goto unlock;
> +	}
> +
> +	ws->wakeirq =3D wakeirq;
> +
> +unlock:
> +	spin_unlock_irq(&dev->power.lock);
> +
> +	return ret;
> +}

<snip>

--=20
balbi

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVqPjAAoJEIaOsuA1yqRE2fAQAIQKuBWi+jm4UhtXaqpEOF0+
tCKSrX+W5gdWWi0hXzOhCLBuDxObxaCPYszPoCP/WnDsDJttz54+DIybMFjJcqPV
QaX6WBZIBlOgIoPKhpIHgUJuoFQIoWN7NxLlwqHNfyXa+dDzSc9WVkSE4BDyTbB1
MFVcx2K3TM1sWRqJon7BtUihWR7BTGO1f91h335rXU40DTT2MHjwaYEbfrQfjmc5
sevDIuOqNnDTLeUHmhxmq95tUM5IbLErrMCc+AN/cOuk62GkChi8C5QE9G0oasdQ
Nqd3H4hxDk5NMGPsqyVJGHt5oNi7LrkjftwSGCdi1DfrwyGoqxx+wNRzAsvSmP8g
ojPma47ki2tV6c0EL2nes+9yZEmV2dqQbGFiufJokN0G5KpmH02hTEbDrRyrKS+M
iPOVFbQ48iYOtzf+YRi49kCXdPZa8CL8V8PS75ZCMKaPzSGHafptlkGK4t1z2akT
M6X8n47a5lL6i4DtIoKsuQ4Yj0xAj+Dmn59siRfEQY5lfd8fB6HXqvjMEtcT7Kgs
HLyS9NtlRk9WqJUXhj6SrkxcZ972/MYfQIeT4ymVE0tvieFs7jjewcEiLBPtKmHQ
zfnOxgoqdJzhpnp2t2t2cNXL+73kAb1p2UARby8E/fL2NGxuJBzEVvgPlg2kOv68
SJH3XH7Lbubp2Fuj80UO
=02Dt
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
