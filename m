From: Colin Cross <ccross@google.com>
Subject: Re: [pm-core][PATCH v3 01/21] OMAP4: PM: Add omap WakeupGen module support
Date: Fri, 1 Apr 2011 23:10:11 -0700
Message-ID: <BANLkTimWTX9HKhpkkjODCSEiuBNuV-rN-g@mail.gmail.com>
References: <1301304157-2466-1-git-send-email-santosh.shilimkar@ti.com>
	<1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:16890 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab1DBGKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Apr 2011 02:10:14 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p326ADN2000536
	for <linux-omap@vger.kernel.org>; Fri, 1 Apr 2011 23:10:13 -0700
Received: from vxi39 (vxi39.prod.google.com [10.241.35.39])
	by kpbe11.cbf.corp.google.com with ESMTP id p326AB33018942
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Fri, 1 Apr 2011 23:10:12 -0700
Received: by vxi39 with SMTP id 39so3195841vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 23:10:11 -0700 (PDT)
In-Reply-To: <1301304157-2466-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, Mar 28, 2011 at 2:22 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This patch adds OMAP WakeupGen support. The WakeupGen unit is respons=
ible
> for generating wakeup event from the incoming interrupts and enable b=
its.
> The WakeupGen is implemented in MPU Always-On power domain. During no=
rmal
> operation, WakeupGen delivers external interrupts directly to the GIC=
=2E
> When the CPUx asserts StandbyWFI, indicating it wants to enter lowpow=
er
> state, the Standby Controller checks with the WakeupGen unit using th=
e
> idlereq/idleack handshake to make sure there is no incoming interrupt=
s.
> The GIC and WakeupGen needs to be kept in synchronisation for proper
> interrupt functioning.
>
> Hence this patch hooks up the omap WakeupGen mask/unmask along with G=
IC using
> architecture specific hooks.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

<snip >

> +static void _wakeupgen_clear(unsigned int irq)
> +{
> + =A0 =A0 =A0 unsigned int cpu =3D smp_processor_id();
> + =A0 =A0 =A0 u32 val, bit_number;
> + =A0 =A0 =A0 u8 i;
> +
> + =A0 =A0 =A0 if (_wakeupgen_get_irq_info(irq, &bit_number, &i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 val =3D wakeupgen_readl(i, cpu);
> + =A0 =A0 =A0 val &=3D ~BIT(bit_number);
> + =A0 =A0 =A0 wakeupgen_writel(val, i, cpu);
> +}
> +
> +static void _wakeupgen_set(unsigned int irq)
> +{
> + =A0 =A0 =A0 unsigned int cpu =3D smp_processor_id();
> + =A0 =A0 =A0 u32 val, bit_number;
> + =A0 =A0 =A0 u8 i;
> +
> + =A0 =A0 =A0 if (_wakeupgen_get_irq_info(irq, &bit_number, &i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 val =3D wakeupgen_readl(i, cpu);
> + =A0 =A0 =A0 val |=3D BIT(bit_number);
> + =A0 =A0 =A0 wakeupgen_writel(val, i, cpu);
> +}
Since you already call these from a function that takes a bool as an
argument, using a bool argument here instead of duplicating everything
for set and clear would be simpler.

<snip>

> +/*
> + * Architecture specific Mask extensiom
> + */
> +static void wakeupgen_mask(struct irq_data *d)
> +{
> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
> + =A0 =A0 =A0 _wakeupgen_clear(d->irq);
> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
> +}
> +
> +/*
> + * Architecture specific Unmask extensiom
> + */
> +static void wakeupgen_unmask(struct irq_data *d)
> +{
> +
> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
> + =A0 =A0 =A0 _wakeupgen_set(d->irq);
> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
> +}
> +
> +#ifdef CONFIG_PM
> +/*
> + * Architecture specific set_wake extension
> + */
> +static int wakeupgen_set_wake(struct irq_data *d, unsigned int on)
> +{
> + =A0 =A0 =A0 spin_lock(&wakeupgen_lock);
> + =A0 =A0 =A0 if (on)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _wakeupgen_set(d->irq);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _wakeupgen_clear(d->irq);
> + =A0 =A0 =A0 spin_unlock(&wakeupgen_lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#else
> +#define wakeupgen_set_wake =A0 =A0 NULL
> +#endif

I don't think these are correct, and it probably only works at all due
to lazy disabling of interrupts during suspend.

=46irst, unless I'm missing some code somewhere, all interrupts are
still enabled during suspend.  Any interrupt that has had enable_irq
on it resulted in a call to wakeupgen_unmask, but when disable_irq is
called on all the interrupts during suspend, masking is delayed until
an interrupt is delivered.  If no interrupt is delivered, all enabled
irqs will still be enabled in the wakeupgen module in suspend, and
they will all wake the device out of suspend.

Second, it is possible for a wake interrupt that should be enabled to
end up disabled in suspend.  Consider the following calls that occur
in a driver during its suspend handler:

enable_irq_wake
  ...
  wakeupgen_unmask (irq is now unmasked)
disable_irq (lazy disable, wakeupgen_mask is not called, irq is still u=
nmasked)
<irq occurs>
handle_level_irq
  ...
  wakeupgen_mask (irq is now masked)

The irq will never get unmasked because it is marked disabled, and the
irq will not wake the device from suspend.

wakeupgen_set_wake needs to set or clear bits in memory, and then
those suspend masks need to be copied into the wakeupgen registers
very late in suspend, after interrupts have been disabled at the cpu.
I think syscore_ops is the right place.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
