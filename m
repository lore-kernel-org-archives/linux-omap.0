From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 10:20:43 +0530
Message-ID: <dfeb90390809232150x782afba6me09c0d0a78c400d1@mail.gmail.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com>
	 <20080923224339.GI10156@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:18847 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYIXEuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 00:50:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2524720rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 21:50:43 -0700 (PDT)
In-Reply-To: <20080923224339.GI10156@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Sep 24, 2008 at 4:13 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Tue, Sep 23, 2008 at 08:53:09PM +0530, Arun KS wrote:
>> This patch is a temporary fix for a kernel panic causing at omap1_clk_init
>>
>> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
>> ---
>>  arch/arm/plat-omap/include/mach/clock.h |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/mach/clock.h
>> b/arch/arm/plat-omap/include/mach/clock.h
>> index f26ad8c..b9c471e 100644
>> --- a/arch/arm/plat-omap/include/mach/clock.h
>> +++ b/arch/arm/plat-omap/include/mach/clock.h
>> @@ -67,7 +67,11 @@ struct clk {
>>       struct clk              *parent;
>>       unsigned long           rate;
>>       __u32                   flags;
>> +#if defined(CONFIG_ARCH_OMAP1)
>> +     void __iomem            *enable_reg;
>> +#elif
>>       u16                     enable_reg;
>> +#endif
>
> Did you try removing those (void __iomem *) casts from
> arch/arm/mach-omap1/clock.h ??
>
> with vim you can fix it by:
>
> :%s/(void\ __iomem\ \*)//g
>

This is not working, still panic.

enable_reg variable is u16 now(which is offset). clock.c file of omap2
is modified to support this, but clock.c of omap1 is not.


> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
