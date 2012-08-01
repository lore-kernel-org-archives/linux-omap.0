From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: omap_device: query on "fck" clk alias created
Date: Wed, 1 Aug 2012 15:42:59 +0200
Message-ID: <50193263.8070907@ti.com>
References: <50191F00.1040501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59368 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2HANnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Aug 2012 09:43:07 -0400
In-Reply-To: <50191F00.1040501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi Vaibhav,

On 08/01/2012 02:20 PM, Vaibhav Hiremath wrote:
> Hi,
> 
> In OMAP world, we have omap_device layer, which exports api's like
> omap_device_build() to create and register platform_device to the
> kernel. This layer understands hwmod infrastructure and parses all the
> platform specific information from it.
> Now with DT migration, the same thing is achieved using a notifier,
> which in turn omap_device_build_from_dt(), which in turn does same thing.
> 
> One of the thing which is happening in both execution path is, creating
> alias for functional clock (hwmod_data->main_clk) for each device
> getting created with the con_id = "fck".
> 
> Now the problem with this is,
> 
> The clk_get() api will not work, unless we pass both the arguments (dev,
> con_id) properly. Now expecting driver to always label con_id with "fck"
> is undesirable, as the same driver can be reused on multiple platforms,
> which can be non-omap and/or non-ti platforms.
> Also we have multiple examples where driver simply calls (which is right)
> 
> clk = clk_get(&pdev->dev, NULL);

Mmm, I don't know, but even if this is right, shouldn't we avoid such
usage. It might be better to be explicit than assuming that the IP will
always have an unique clock.
Some IP does have several inputs that might or not be connected
depending or the integration or on the version. So even if only one
clock is useful at some point it will not always be true.
We had similar issue with the IRQ lines in the past.

> This would fail on OMAP platforms, unless you modify clockxxx_data.c
> file with,
> 
> CLK("<device>",  NULL,           &xxx_fck,    CK_34XX),
> 
> 
> Devices specially with only one clock source always prefer not to
> specify con_id.

How many devices do you have with only one clock source? Could you
provide the list of drivers that assume that?

Most IPs in OMAP does have a fck and an ick so that does not seems nice
or even consistent to me to do a clk_get(&pdev->dev, NULL) for "fck" and
clk_get(&pdev->dev, "ick") for the ick.

> And it seems wrong thing, as across platforms IP integration can be very
> different and you can not expect to change the clock-tree table always.

FWIW, that table is done for that exact purpose. And we introduced the
automatic "fck" alias creation mainly to make things easier, but that
method is still very valid, and if the default alias is not good enough
for the driver nothing should prevent you to create a new one.

> So the option here we have is,
> 
> 1. Instead of creating alias with "fck", create an alias only with dev
> pointer, that means con_id = NULL.
> I have already tested this and it works on AM33xx platform.

Do you mean assuming that the fck is always the clock with a NULL
con_id? And any other clocks for that device will have thus to use a
explicit name?

> 2. Add a new flag inside hwmod or omap_device, so that it can be read at
> omap_device layer and based on that we can decide whether to add con_id
> or not while invoking clkdev_alloc().

hwmod is supposed to contain only HW related information. In that case
it will be Linux driver dependent and not really HW dependent.
That one is thus not really acceptable.

> This may be required to support legacy drivers which are not migrated to
> runtime_pm and still calls clk_get() for both "fck" and "ick", so here
> we need "fck" clk alias.

We can use "fck" even with runtime_pm. Just because sometime you need to
get the clock rate of the main clock.

> Any comments or opinion on this? Based on the feedback I can create the
> changes and submit it to the list.

Well, a #3 suggestion might be to enforce the usage of fck alias in the
drivers instead of assuming that the "NULL" entry is the proper one.

And a #4 will be to create a extra entry in the clkdev like you have done.

For my point of view, the #4 seems to be the one that will minimize the
overall change in the drivers and is probably the best one.

That being said, since the DT clock binding is merged now, the whole
automatic alias creation might disappear as soon as we will have DT boot
on all the platforms... OK, we are not really there still :-)

Regards,
Benoit

