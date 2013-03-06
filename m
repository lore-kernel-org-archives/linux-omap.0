From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Wed, 6 Mar 2013 11:00:28 -0600
Message-ID: <5137762C.6090300@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <513664EC.2050508@ti.com> <5137192E.1010101@mimc.co.uk> <513744F4.7050503@mimc.co.uk> <5137726D.10702@ti.com> <5137736B.9050501@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56102 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3CFRAo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 12:00:44 -0500
In-Reply-To: <5137736B.9050501@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/06/2013 10:48 AM, Mark Jackson wrote:
> On 06/03/13 16:44, Jon Hunter wrote:
>>
>> On 03/06/2013 07:30 AM, Mark Jackson wrote:
>>> On 06/03/13 10:23, Mark Jackson wrote:
> 
> <snip>
> 
>>>> [    1.541884] gpmc_probe_nor_child 1
>>>> [    1.545483] GPMC_CS_CONFIG7_0 : 00000f48
>>>> [    1.549621] GPMC_CS_CONFIG7_1 : 00000f58
>>>> [    1.553812] GPMC_CS_CONFIG7_2 : 00000f00
>>>> [    1.557951] GPMC_CS_CONFIG7_3 : 00000c5a
>>>
>>> 0x00000c5a is an invalid mode !!
>>>
>>> I'm trying to use a 64MB address space but not on a 64MB boundary ... oops.
>>
>> Good catch. So this is now working for you then?
> 
> Not yet ... I got distracted by something else !?!
> 
> I'll take another look tomorrow.
> 
> Do you think it might be worth adding some sanity checking to the cs config
> routines to trap similar errors ?

Yes, I see what you mean. We should check to ensure that the the base is
aligned on a boundary that matches the size being configured.

I can add some checking for this case.

Cheers
Jon
