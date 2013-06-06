From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Thu, 6 Jun 2013 14:30:34 -0400
Message-ID: <51B0D54A.1090107@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com> <1369845494-30231-15-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.02.1306061754560.5152@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55507 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab3FFSa6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Jun 2013 14:30:58 -0400
In-Reply-To: <alpine.DEB.2.02.1306061754560.5152@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Sricharan R <r.sricharan@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 06 June 2013 01:57 PM, Paul Walmsley wrote:
> On Wed, 29 May 2013, Santosh Shilimkar wrote:
> 
>> From: Sricharan R <r.sricharan@ti.com>
>>
>> - The IO resource information like dma request lines, irq number and
>>   ocp address space can be populated via dt blob. So such data is stripped
>>   from OMAP4 SOC hwmod data file.
>>
>> - The devices which are still missing the device tree bindings,
>>   address space entries are not removed yet. When such devices add
>>   the dt bindings, respective address space data can be deleted.
>>
>> - Also other unnessecary hwmods like firewalls are removed as a part of this.
>>
>> The above update, results in reduction of about ~1650 lines of code.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> 
> I assume that you're not autogenerating this data any more, based on
> your change list above.  If that's correct, please also remove
> the paragraph at the top of the file:
> 
The data is auto-generated. I let Sricharan comment if it is otherwise
in the final version of the patch. 

Sricharan ?

Regards,
Santosh
