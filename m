From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip specific GPIO
Date: Tue, 11 May 2010 08:25:29 -0700
Message-ID: <87iq6ucvfa.fsf@deeprootsystems.com>
References: <87och0bl1d.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C52D12CC@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5455533@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36724 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0EKPZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 11:25:34 -0400
Received: by pwi5 with SMTP id 5so2293426pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 08:25:33 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5455533@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Tue\, 11 May 2010 20\:13\:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:


>> > -----Original Message-----
>> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> > Sent: Saturday, May 01, 2010 4:33 AM
>> > To: Varadarajan, Charulatha
>> > Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
>> tony@atomide.com
>> > Subject: Re: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip
>> specific
>> > GPIO
>> >
>> > Charulatha V <charu@ti.com> writes:
>> >
>> > > This patch adds support for handling GPIO as a HWMOD adapted
>> > > platform device for OMAP2PLUS chips.
>> > >
>> > > Signed-off-by: Charulatha V <charu@ti.com>
>> > > ---
>> > >  arch/arm/mach-omap2/gpio.c |  101
>> ++++++++++++++++++++++++++++++++++++++++++++
>> > >  1 files changed, 101 insertions(+), 0 deletions(-)
>> > >  create mode 100644 arch/arm/mach-omap2/gpio.c
>> > >
>> > > diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> > > new file mode 100644
>> > > index 0000000..6424050
>> > > --- /dev/null
>> > > +++ b/arch/arm/mach-omap2/gpio.c
>> > > @@ -0,0 +1,101 @@
>
> ..[snip]..
>
>> > > +		if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> > > +			pdata->method = METHOD_GPIO_24XX;
>> > > +		if (cpu_is_omap44xx())
>> > > +			pdata->method = METHOD_GPIO_44XX;
>> > > +		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
>> > > +		pdata->device_enable = omap_device_enable;
>> > > +		pdata->device_idle = omap_device_idle;
>> > > +		pdata->device_shutdown = omap_device_shutdown;
>> >
>> > These aren't valid for GPIO1 which is in WKUP.  Maybe we need
>> > to check if the hwmod is not in wkup_pwrdm before setting these?
>> 
>> I need to check how to implement this.
>> 
>
> There are two ways to implement this:
> 1. Use a flag in dev_attr of the device to indicate if the device belongs to
>    WKUP domain
> 2. We can add an API in powerdomain FW to provide information if the 
>    device belongs to a "always_on" domain or otherwise, and use 
>    this API for each device.
>

Actually, as I think about this more, my initial comment is wrong.

the omap_device* functions are perfectly valid for GPIO1 as they have
independent control that is managed by hwmod, so please ignore my
comment.  Your approach is fine.

Thanks,

Kevin


