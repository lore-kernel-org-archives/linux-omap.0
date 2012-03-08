From: Aneesh V <aneesh@ti.com>
Subject: Re: [PATCH 1/8] OMAP4: hwmod: add EMIF hw mod data
Date: Thu, 08 Mar 2012 22:13:49 +0530
Message-ID: <4F58E1C5.5090704@ti.com>
References: <1331222065-3579-1-git-send-email-aneesh@ti.com> <1331222065-3579-2-git-send-email-aneesh@ti.com> <4F58E13C.8040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:34447 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757269Ab2CHQnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 11:43:55 -0500
Received: by mail-gx0-f170.google.com with SMTP id b2so586358ggm.1
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 08:43:54 -0800 (PST)
In-Reply-To: <4F58E13C.8040906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 08 March 2012 10:11 PM, Cousson, Benoit wrote:
> Hi Aneesh
>
> On 3/8/2012 4:54 PM, Aneesh V wrote:
>> From: Benoit Cousson<b-cousson@ti.com>
>>
>> Add hwmod data for EMIF IP instances in OMAP4.
>
> Paul has just posted an OMAP4 hwmod series (ARM: OMAP4: hwmod data: add
> almost all remaining IP blocks) that does contain the EMIF hwmods, so
> assuming that you are not adding some custom dev_attr here, it should
> work for you.

Ok. I will test with that tomorrow and drop this patch.

Thanks,
Aneesh
