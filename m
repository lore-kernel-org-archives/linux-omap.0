From: archit taneja <archit@ti.com>
Subject: Re: [PATCH v4] OMAP: DSS2: Have separate irq handlers for DISPC and
 DSI
Date: Wed, 23 Feb 2011 16:10:26 +0530
Message-ID: <4D64E41A.3070000@ti.com>
References: <1298450463-31087-1-git-send-email-archit@ti.com> <1298455904.29392.9.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43347 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab1BWKi1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 05:38:27 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1NAcO3N020199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 04:38:26 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1NAcNnc013315
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 16:08:23 +0530 (IST)
In-Reply-To: <1298455904.29392.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Wednesday 23 February 2011 03:41 PM, Valkeinen, Tomi wrote:
> On Wed, 2011-02-23 at 02:41 -0600, Taneja, Archit wrote:
>> Currently, the core DSS platform device requests for an irq line for OMAP2 and
>> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
>>
>> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
>> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
>>
>> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
>> DSS_IRQSTATUS register.
>>
>> Hence, it makes more sense to have separate irq handlers corresponding to the
>> DSS sub modules instead of having a common handler.
>>
>> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
>> among the IRQ handlers.
>>
>> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
>> hwmod databases. The Probes of DISPC and DSI now request for irq handlers.
>
> <snip>
>
>> +       r = request_irq(dispc.irq, omap_dispc_irq_handler, IRQF_SHARED,
>> +               "OMAP DISPC", dispc.pdev);
>> +       if (r<  0) {
>> +               DSSERR("request_irq failed\n");
>> +               goto fail1;
>>          }
>>
>>          enable_clocks(1);
>> @@ -3361,10 +3388,15 @@ static int omap_dispchw_probe(struct platform_device *pdev)
>>          enable_clocks(0);
>>
>>          return 0;
>> +fail1:
>> +       iounmap(dispc.base);
>> +fail0:
>> +       return r;
>>   }
>>
>>   static int omap_dispchw_remove(struct platform_device *pdev)
>>   {
>> +       free_irq(dispc.irq, NULL);
>
> This fails when unloading the DSS module. free_irq() needs the same data
> that was used in request_irq, dispc.pdev in this case. And the same
> thing in dsi.

Okay, I should test by building modules also.

>
> I fixed this, and a minor conflict in dsi's fail path. The commit is in
> my master branch. Please check the commit to see that I didn't mess
> anything up.

It looks fine, I'll do some tests and get back. Thanks.

Archit
