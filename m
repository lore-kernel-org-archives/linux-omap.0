From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 1/8] OMAP: hwmod: Fix the addr spaces, irq, dma count
 APIs.
Date: Sun, 18 Sep 2011 14:28:42 +0530
Message-ID: <4E75B2C2.6070904@ti.com>
References: <1315584134-3869-1-git-send-email-r.sricharan@ti.com> <4E736DDE.9090300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40428 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755370Ab1IRI6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Sep 2011 04:58:47 -0400
Received: by mail-gx0-f182.google.com with SMTP id 28so4966805gxk.13
        for <linux-omap@vger.kernel.org>; Sun, 18 Sep 2011 01:58:46 -0700 (PDT)
In-Reply-To: <4E736DDE.9090300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "R, Sricharan" <r.sricharan@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pswan.com" <paul@pswan.com>

On Friday 16 September 2011 09:10 PM, Cousson, Benoit wrote:
> Hi Sricharan,
> 
> On 9/9/2011 6:02 PM, R, Sricharan wrote:
>> The address spaces, irqs and dma reqs count API returns the
>> number of corresponding entries in a hwmod including a additional
>> null value or a -1 terminator in the structure introduced
>> recently. More information here:
>>
>>     212738a4 (omap_hwmod: use a terminator record with
>> omap_hwmod_mpu_irqs arrays)
>>     78183f3f (omap_hwmod: use a null structure record to terminate
>> omap_hwmod_addr_space arrays)
>>     bc614958 (omap_hwmod: use a terminator record with
>> omap_hwmod_dma_info arrays)
>>
>> The devices which have multiple hwmods and use device_build_ss are
>> broken with this, as their resources are populated with a
>> extra null value, subsequently the probe fails. So fix the API not to
>> include the array terminator in the count.
>>
>> Signed-off-by: sricharan<r.sricharan@ti.com>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> Cc: Kevin Hilman<khilman@ti.com>
> 
> It would have been nice to give me the credit for the bug report on the
> other functions, but otherwise:
> 
Sure. Will add reported-by of yours.

> Acked-by: Benoit Cousson <b-cousson@ti.com>
> 
Thanks

> And I still prefer the return i - 1 :-)
> 
Let's do "i-1" as you prefer. Maintainer
always have final say !!

Regards,
Santosh
