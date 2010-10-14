From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Thu, 14 Oct 2010 10:06:13 +0530
Message-ID: <4CB688BD.5070406@ti.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com> <4CAF014D.7000909@ti.com> <20101008232237.GC10975@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33658 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0JNEga (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 00:36:30 -0400
In-Reply-To: <20101008232237.GC10975@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Menon, Nishanth" <nm@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

On Saturday 09 October 2010 04:52 AM, Russell King - ARM Linux wrote:
> On Fri, Oct 08, 2010 at 06:32:29AM -0500, Nishanth Menon wrote:
>    
>> Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
>>      
>>> Fix the sparse warnings generated due to conflicts in variables used in readl/writel.
>>>
>>>
>>> drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows an earlier one
>>> drivers/net/smc91x.c:312:8: originally declared here
>>>
>>> With this change, about 200 sparse warnings are fixed.
>>>        
>> The commit message could be a little more detailed.
>> see http://marc.info/?l=linux-omap&m=128648102511076&w=2
>>
>> also should $subject say ARM: io: fix namespace conflict
>> to better reflect the fix? sparse warnings are just an indication IMHO
>>      
> afaics, this patch will cause checkpatch to issue warnings due to lines
> over 80 characters.
>
> I can't check that because I don't have the original patch via the
> linux-arm-kernel mailing list.
>    
     Hi,

      I have posted a new patch with  the checkpatch issues fixed.
      Link to this patch is:
         http://marc.info/?l=linux-arm-kernel&m=128697013901237&w=2

      Regards,
      Sourav

