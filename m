From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Fri, 7 Jun 2013 16:37:32 +0530
Message-ID: <51B1BEF4.6080606@ti.com>
References: <1370600827-21679-1-git-send-email-r.sricharan@ti.com> <51B1B936.5030302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44026 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047Ab3FGLIB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 07:08:01 -0400
In-Reply-To: <51B1B936.5030302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, rnayak@ti.com, paul@pwsan.com, t-kristo@ti.com, ambresh@ti.com

Hi Benoit,

On Friday 07 June 2013 04:13 PM, Benoit Cousson wrote:
> Hi Sricharan,
>
> On 06/07/2013 12:27 PM, Sricharan R wrote:
>> - The IO resource information like dma request lines, irq number and
>>   ocp address space can be populated via dt blob. So such data is stripped
>>   from OMAP4 SOC hwmod data file.
>>
>> - The devices which are still missing the device tree bindings,
>>   address space entries are not removed yet. When such devices add
>>   the dt bindings, respective address space data can be deleted.
>>
>> - Also other unnessecary hwmods like firewalls are removed as a part of this.
> typo.
 Ok, will correct.

> That part is fine, but you should add that by doing that you have to
> create new direct link from MPU to EMIFs that did no exist before.
 Yes, the mpu->emif link is already added in the patch

>> The above update, results in reduction of about ~1650 lines of code.
>>
>> The comment about autogeneration is removed temporarily. Should be brought
>> back after syncing the scripts.
> You'd better keep it and append a note stating that.
> If you remove it, I fairly know nobody will ever add it again :-)
 Ok, will change this then :-)
> Otherwise the patch looks fine.
>
> Thanks,
> Benoit
Regards,
 Sricharan
