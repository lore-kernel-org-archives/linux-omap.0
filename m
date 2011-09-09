From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 08/25] OMAP4: PM: Keep static dep between MPUSS-EMIF and
 MPUSS-L3 and DUCATI-L3
Date: Fri, 09 Sep 2011 09:51:53 +0530
Message-ID: <4E699461.9070609@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-9-git-send-email-santosh.shilimkar@ti.com> <87ehzqhpsk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35501 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1IIEV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 00:21:59 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so789641gxk.37
        for <linux-omap@vger.kernel.org>; Thu, 08 Sep 2011 21:21:58 -0700 (PDT)
In-Reply-To: <87ehzqhpsk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Thursday 08 September 2011 11:36 PM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> As per OMAP4430 TRM, the dynamic dependency between MPUSS ->  EMIF
>> and MPUSS ->  L3* and DUCATI ->  L3 *clockdomains is enable by default.
>> Refer register CM_MPU_DYNAMICDEP description for details.
>>
>> But these dynamic dependencies doesn't work as expected. The hardware
>> recommendation is to keep above dependencies.
>
> Minor nit on changelog wording...
>
> The use of "above dependencies" here is a bit confusing, since the only
> thing refered to above are dynamic dependencies.
>
> I think this should be worked to be clear that what is being kept are
> the *static* dependencies (assuming I understand it correctly.)
>
Will mention about static deps.

>
>> Without this system locks up or randomly crashesh.
>
> Is 'crashesh' a particular kind of crash. maybe a silent one?  ;)
>
My typo made it special :)
Will fix it.

Regards
Santosh


