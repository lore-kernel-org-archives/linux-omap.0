From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Fri, 1 Mar 2013 16:24:27 -0600
Message-ID: <51312A9B.10704@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <CALF0-+Xb-+ByPWm7AHzOOtZaasHV9MXLKHixHsBi2PZ==h0GAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36374 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab3CAWYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 17:24:46 -0500
In-Reply-To: <CALF0-+Xb-+ByPWm7AHzOOtZaasHV9MXLKHixHsBi2PZ==h0GAw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/01/2013 03:25 PM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Tue, Feb 26, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> [...]
>> +static int gpmc_probe_nor_child(struct platform_device *pdev,
>> +                               struct device_node *child)
>> +{
>> +       struct gpmc_settings gpmc_s;
>> +       struct gpmc_timings gpmc_t;
>> +       struct resource res;
>> +       unsigned long base;
>> +       int ret, cs;
>> +
>> +       if (of_property_read_u32(child, "reg", &cs) < 0) {
>> +               dev_err(&pdev->dev, "%s has no 'reg' property\n",
>> +                       child->full_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       if (of_address_to_resource(child, 0, &res)) {
>> +               dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
>> +                       child->full_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = gpmc_cs_request(cs, res.end - res.start, &base);
> 
> How about using resource_size() above?
> 
> BTW, I believe it's size = end - start + 1.

Thanks, yes I can update.

Cheers
Jon

