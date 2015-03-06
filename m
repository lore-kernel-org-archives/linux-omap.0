From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised
 DRM encoder
Date: Fri, 6 Mar 2015 10:33:27 +0200
Message-ID: <54F96657.10200@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com> <20150302160135.GA29584@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55084 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbCFIds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 03:33:48 -0500
In-Reply-To: <20150302160135.GA29584@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, tomi.valkeinen@ti.com, detheridge@ti.com, moinejf@free.fr, laurent.pinchart@ideasonboard.com

On 03/02/15 18:01, Russell King - ARM Linux wrote:
> On Thu, Feb 26, 2015 at 04:55:32PM +0200, Jyri Sarha wrote:
>> +	ret = component_bind_all(dev->dev, dev);
>> +	if (ret < 0) {
>> +		dev_err(dev->dev, "Binding subcomponents failed: %d\n", ret);
>
> Do you need to print this?  The component helper is already fairly
> verbose about what succeeds and fails.
>

Will remove.

>> +static const struct component_master_ops tilcdc_comp_ops = {
>> +	.add_components = tilcdc_add_external_components,
>
> I'd much rather you used the new matching support rather than using the
> old .add_components.  The new matching support is more efficient as you
> only have to scan DT once, rather than each time we try to probe.  That
> will mean...
>

That is otherwise fine, but with the match code it not possible to 
implement a master that may not have any components.

Would it be Ok to add a check that master->ops->add_components is 
defined, before calling it in find_componets() 
(drivers/base/component.c:120) and return 0 if it is not?

Best regards,
Jyri

>> @@ -613,12 +643,12 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
>>   		return -ENXIO;
>>   	}
>
> You need to build a struct component_match array here using
> component_match_add()...
>
>>
>> -	return drm_platform_init(&tilcdc_driver, pdev);
>> +	return component_master_add(&pdev->dev, &tilcdc_comp_ops);
>
> and then finally register the ops with component_master_add_with_match().
>
> Thanks.
>

