From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()
Date: Tue, 02 Oct 2012 14:37:35 -0700
Message-ID: <87d3108sio.fsf@deeprootsystems.com>
References: <CAPgLHd-q3rF822NrpJQcMgr2=BNAp=p_rbRdEXp-gSutnjuBFQ@mail.gmail.com>
	<CAORVsuWGPw6Q4Z-nnPqMMBAf=tYXGydHqXSnd-JdXRV9NtGP=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39683 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582Ab2JBVhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 17:37:35 -0400
Received: by pbbrr4 with SMTP id rr4so9172400pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 14:37:35 -0700 (PDT)
In-Reply-To: <CAORVsuWGPw6Q4Z-nnPqMMBAf=tYXGydHqXSnd-JdXRV9NtGP=A@mail.gmail.com>
	(Jean Pihet's message of "Fri, 28 Sep 2012 12:42:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, tony@atomide.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Sep 27, 2012 at 7:54 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function voltdm_lookup() returns NULL
>> not ERR_PTR(). The IS_ERR() test in the return value check
>> should be replaced with NULL test.
>>
>> dpatch engine is used to auto generate this patch.
>> (https://github.com/weiyj/dpatch)
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  arch/arm/mach-omap2/pm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index 9cb5ced..ab15e5c 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -176,7 +176,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
>>         }
>>
>>         voltdm = voltdm_lookup(vdd_name);
>> -       if (IS_ERR(voltdm)) {
>> +       if (!voltdm) {
>>                 pr_err("%s: unable to get vdd pointer for vdd_%s\n",
>>                         __func__, vdd_name);
>>                 goto exit;
>
> This looks good, so here is the ack:
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks, queuing this one for v3.7-rc.

Kevin
