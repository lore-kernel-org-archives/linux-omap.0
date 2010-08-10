From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 09/13 v5] OMAP: GPIO: Introduce support for OMAP2PLUS
 chip GPIO init
Date: Tue, 10 Aug 2010 11:26:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65533DF@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
 <87eie7bao6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0HJF4R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 01:56:17 -0400
In-Reply-To: <87eie7bao6.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 10, 2010 5:29 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Nayak,
> Rajendra; Basak, Partha
> Subject: Re: [PATCH 09/13 v5] OMAP: GPIO: Introduce support for OMAP2PLUS
> chip GPIO init
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch adds support for handling GPIO as a HWMOD FW adapted
> > platform device for OMAP2PLUS chips.
> >
> > gpio_init needs to be done before machine_init functions access
> > gpio APIs.Hence gpio_init is made as a postcore_initcall.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Basak, Partha <p-basak2@ti.com>
> > ---
> 
> [...]
> 
> > +static int omap2_init_gpio(struct omap_hwmod *oh, void *user)
> > +{
> > +	struct omap_device *od;
> > +	struct omap_gpio_platform_data *pdata;
> > +	char *name = "omap-gpio";
> > +	static int id;
> > +	struct omap_gpio_dev_attr *gpio_dev_data;
> > +
> > +	if (!oh) {
> > +		pr_err("Could not look up omap gpio %d\n", id + 1);
> > +		return -EINVAL;
> > +	}
> > +
> > +	pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
> > +					GFP_KERNEL);
> > +	if (!pdata) {
> > +		pr_err("Memory allocation failed gpio%d\n", id + 1);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	gpio_dev_data = (struct omap_gpio_dev_attr *)oh->dev_attr;
> > +
> > +	pdata->gpio_attr = gpio_dev_data;
> > +	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * id;
> > +	switch (oh->class->rev) {
> > +	case 0:
> > +	case 1:
> > +		pdata->bank_type = METHOD_GPIO_24XX;
> > +		break;
> > +	case 2:
> > +		pdata->bank_type = METHOD_GPIO_44XX;
> > +		break;
> > +	default:
> > +		WARN(1, "Invalid gpio bank_type\n");
> > +		break;
> > +	}
> > +	gpio_bank_count++;
> > +
> > +	od = omap_device_build(name, id, oh, pdata,
> > +				sizeof(*pdata),	omap_gpio_latency,
> > +				ARRAY_SIZE(omap_gpio_latency),
> > +				false);
> > +	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
> > +				name, oh->name);
> > +
> 
> pdata should be free'd here as omap_device_build makes a copy for
> itself.
> 

Okay.

> Kevin
