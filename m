From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 16:04:41 +0530
Message-ID: <AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
 <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com> <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44312 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab0LBKfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:35:02 -0500
Received: by wwa36 with SMTP id 36so8547915wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 02:35:01 -0800 (PST)
In-Reply-To: <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Thu, Dec 2, 2010 at 2:38 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Paul,
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Paul Walmsley
>> Sent: Thursday, December 02, 2010 1:44 PM
>> To: linux-omap@vger.kernel.org; Govindraj
>> Cc: khilman@deeprootsystems.com
>> Subject: Re: Unbalanced IRQ wake disable during resume from static
> suspend
>>
>> On Thu, 2 Dec 2010, Paul Walmsley wrote:
>>
>> > On current linux-omap master (commit
>> > 7fd1cffc56ca9944fec583eb2ecda5ce88b36bff "Linux-omap rebuilt: Upda=
ted
> to
>> > -rc4"), when resuming from static suspend, several "Unbalanced IRQ
>> > wake disable" warnings are generated, one for each of the serial
> ports.
>> > This is on Beagle 35xx rev C2.
>>
>> Just to follow up on this, these messages are not logged when
>> /sys/devices/platform/omap/omap-hsuart.*/tty/ttyO*/power/wakeup are =
set
> to
>> 'disabled'.
>>
>> Also this is with omap2plus_defconfig.
>>
> Just a wild guess here but is this because the 'set_wake' is
> not setup and then fw might be returning some error whenever
> driver invoke this API as part of enable_irq_wake() callback
>
> If that being the case, below patch might might help. Can
> somebody try this out ?
>

Tested on 3630SDP.
The below patch helps to avoid the warnings.

--
Regards
Govindraj.R


> Regards,
> Santosh
>
> omap: irq: Dummy handler for enable_irq_wake
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/mach-omap2/irq.c | =A0 10 ++++++++++
> =A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 32eeabe..6a964d3 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -143,11 +143,21 @@ static void omap_mask_ack_irq(unsigned int irq)
> =A0 =A0 =A0 =A0omap_ack_irq(irq);
> =A0}
>
> +#ifdef CONFIG_PM
> +static int omap_set_wake(unsigned int irq, unsigned int on)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define omap_set_wake NULL
> +#endif
> +
> =A0static struct irq_chip omap_irq_chip =3D {
> =A0 =A0 =A0 =A0.name =A0 =3D "INTC",
> =A0 =A0 =A0 =A0.ack =A0 =A0=3D omap_mask_ack_irq,
> =A0 =A0 =A0 =A0.mask =A0 =3D omap_mask_irq,
> =A0 =A0 =A0 =A0.unmask =3D omap_unmask_irq,
> + =A0 =A0 =A0 .set_wake =3D omap_set_wake,
> =A0};
>
> =A0static void __init omap_irq_bank_init_one(struct omap_irq_bank *ba=
nk)
> --
> 1.6.0.4
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
