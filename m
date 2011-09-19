From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] OMAP: omap_device: Add omap_device_[alloc|delete]
 for DT integration
Date: Mon, 19 Sep 2011 17:07:42 +0200
Message-ID: <4E775ABE.8020905@ti.com>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com> <1316184199-12599-2-git-send-email-b-cousson@ti.com> <20110917160514.GU3523@ponder.secretlab.ca> <4E773F91.3030704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab1ISPHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 11:07:49 -0400
In-Reply-To: <4E773F91.3030704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 9/19/2011 3:11 PM, Cousson, Benoit wrote:
> On 9/17/2011 6:05 PM, Grant Likely wrote:
>> On Fri, Sep 16, 2011 at 04:43:18PM +0200, Benoit Cousson wrote:

[...]

>>> - pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
>>> - oh_cnt);
>>> + /* Set the dev_name early to allow dev_xxx in omap_device_alloc */
>>> + if (pdev->id != -1)
>>> + dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
>>> + else
>>> + dev_set_name(&pdev->dev, "%s", pdev->name);
>>
>> This is duplicated from the core platform_device code. What is the
>> reasoning for doing it again here?
>
> Well, it is written in the comment... But this is maybe not that obvious
> :-)
> That part is only needed for the legacy path that will create a
> omap_device before having created the device, and thus at that time the
> dev_xxx will not give the device name. This is not a big deal, but that
> was painful for the debug.
>
> That being said, by writing that, I'm now realizing that this is due to
> the way the legacy code was working, because I didn't try to change the
> sequence.
> But maybe, I can easily avoid that by changing the original sequence.
> In fact If I create the omap_device after the omap_device_register, the
> platform_device will already have the correct name...
>
> That should work, I'll give it a try.

Mmm, that's funny because it still does require to copy some part of the 
platform_device_add to make that work.
This is now the resource name that are missing in that case :-(
So I will have to add at least that part to make that work:

		if (r->name == NULL)
			r->name = dev_name(&pdev->dev);

And the real function is doing s little bit more:

                 p = r->parent;
                 if (!p) {
                         if (resource_type(r) == IORESOURCE_MEM)
                                 p = &iomem_resource;
                         else if (resource_type(r) == IORESOURCE_IO)
                                 p = &ioport_resource;
                 }

                 if (p && insert_resource(p, r)) {
                         printk(KERN_ERR
                                "%s: failed to claim resource %d\n",
                                dev_name(&pdev->dev), i);
                         ret = -EBUSY;
                         goto failed;
                 }

It seems that in both cases, some part of the platform core code has to 
be copied to make that work properly.

Except if someone has a better idea, I'd rather stick to the original 
dev_set_name hack. Considering that this code should be removed at some 
point anyway.

Any thoughts?

Regards,
Benoit

