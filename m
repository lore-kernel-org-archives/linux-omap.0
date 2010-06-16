From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 11/13 v3] OMAP: GPIO: Introduce support for OMAP2PLUS
 chip GPIO init
Date: Wed, 16 Jun 2010 21:13:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B9B5@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
 <1276614348-5201-2-git-send-email-charu@ti.com>
 <1276614348-5201-3-git-send-email-charu@ti.com>
 <1276614348-5201-4-git-send-email-charu@ti.com>
 <1276614348-5201-5-git-send-email-charu@ti.com>
 <1276614348-5201-6-git-send-email-charu@ti.com>
 <1276614348-5201-7-git-send-email-charu@ti.com>
 <1276614348-5201-8-git-send-email-charu@ti.com>
 <1276614348-5201-9-git-send-email-charu@ti.com>
 <1276614348-5201-10-git-send-email-charu@ti.com>
 <1276614348-5201-11-git-send-email-charu@ti.com>
 <1276614348-5201-12-git-send-email-charu@ti.com> <4C17B6ED.203@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B62C@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B659@dbde02.ent.ti.com>
 <4C189422.7020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136Ab0FPPng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 11:43:36 -0400
In-Reply-To: <4C189422.7020700@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>


> >>> On 6/15/2010 5:05 PM, Varadarajan, Charulatha wrote:
> >>>> From: Charulatha V<charu@ti.com>
> >>>>
> >>>> This patch adds support for handling GPIO as a HWMOD FW adapted
> >>>> platform device for OMAP2PLUS chips.
> >>>>
> >>>> gpio_init needs to be done before machine_init functions access gpio APIs.
> >>>> Hence gpio_init is made as a postcore_initcall.
> >>>>
> >>>> Signed-off-by: Charulatha V<charu@ti.com>
> >>>> ---
> >>>>    arch/arm/mach-omap2/gpio.c |  104
> ++++++++++++++++++++++++++++++++++++++++++++
> >>>>    1 files changed, 104 insertions(+), 0 deletions(-)
> >>>>    create mode 100644 arch/arm/mach-omap2/gpio.c
> >>>>
> >>>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> >>>> new file mode 100644
> >>>> index 0000000..993995a
> >>>> --- /dev/null
> >>>> +++ b/arch/arm/mach-omap2/gpio.c

[snip]

> >>>> +static int omap2_init_gpio(struct omap_hwmod *oh, void *user)
> >>>> +{
> >>>> +	struct omap_device *od;
> >>>> +	struct omap_gpio_platform_data *pdata;
> >>>> +	char *name = "omap-gpio";
> >>>> +	static int id;
> >>>> +	struct omap_gpio_dev_attr *gpio_dev_data;
> >>>> +
> >>>> +	if (!oh)
> >>>> +		pr_err("Could not look up omap gpio %d\n", id + 1);
> >>>> +
> >>>> +	pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
> >>>> +					GFP_KERNEL);
> >>>> +	if (!pdata) {
> >>>> +		pr_err("Memory allocation failed gpio%d\n", id + 1);
> >>>> +		return -ENOMEM;
> >>>> +	}
> >>>> +
> >>>> +	gpio_dev_data = (struct omap_gpio_dev_attr *)oh->dev_attr;
> >>>> +	pdata->gpio_attr = gpio_dev_data;
> >>>> +	pdata->method = (int)user;
> >>>
> >>> That method seems to be an IP version specific information and not a Soc
> >>> specific one. You should store that in the hwmod dev_attr.
> >>
> >> 'method' is chip ID information mapped to GPIO driver specific enum that is
> passed to the driver
> >> (eg., METHOD_GPIO_24XX, METHOD_GPIO_44XX). I think this should not be moved to
> hwmod dev_attr because
> >> this is only an info required for the driver to identify the chip ID and
> accordingly access
> >> functions/ registers.
> >>
> >> Also this 'method' would be removed once GPIO code undergoes a complete
> cleanup.
> >>
> >>>
> >>> What does 'method' mean in that context? Maybe the name should be revisited?
> >>
> >> Agree. 'method' is used throughout OMAP GPIO code. As mentioned above, this
> field would be removed
> >> once the whole GPIO code is cleaned up. This patch series doesn't bother to
> clean up GPIO code as the
> >> changes would be huge and intended only for HWMOD FW adaptation. Cleaning up
> GPIO code would come as
> >> a separate series and we can address this then.
> >>
> > Sorry if my comment is not aligned but I thought we are addressing the
> > gpio clean up as well.
> >
> > If we are re-vamping the code so much, is it not the right time to clean up as
> well ??
> 
> I agree with Santosh, you are already cleaning a bunch of things, and in
> that case you can easily take advantage of HWMOD to remove a good amount
> of useless code.
> 
> We'd better do that right now, instead of waiting a next phase that
> might never happen...

Since hwmod migration would change mainly the init part of the code, I started working on hwmod migration as part of the first series. Once we agree upon the final patch set for GPIO hwmod migration, I can work on top of the hwmod migration patch series to clean up the GPIO code and send a dependent series. This will help sending the changes in smaller chunks.

I would add a TODO section in patch description outlining the cleanup to be done in the next patch series.

Tony,
Can you add your feedback?

Please refer http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26065.html for the old context.

> 
> And BTW, this 'method' is a IP version dependent information and not a
> Soc specific one. You can potentially use the HW revision field, if it
> is available for the GPIO.

I agree that it is not SoC specific. But I still feel that it is better not to have 'method' as part of dev_attr, considering that, after clean-up, this information will no longer be needed.

> 
> Regards,
> Benoit
