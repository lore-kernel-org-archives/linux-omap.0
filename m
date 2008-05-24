From: "nick loeve" <trickie@gmail.com>
Subject: Re: [PATCH] Fix compile on n800 if CONFIG_MACH_NOKIA_N810 is not set
Date: Sat, 24 May 2008 22:20:02 +0200
Message-ID: <83c2b2e00805241320w3b27e2bdj62956e568855b53d@mail.gmail.com>
References: <1211654630-15547-1-git-send-email-trickie@gmail.com>
	 <20080524194209.GF25685@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:42171 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbYEXUUE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 May 2008 16:20:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so780912fgg.17
        for <linux-omap@vger.kernel.org>; Sat, 24 May 2008 13:20:02 -0700 (PDT)
In-Reply-To: <20080524194209.GF25685@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Hi,

On Sat, May 24, 2008 at 9:42 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sat, May 24, 2008 at 08:43:50PM +0200, trickie@gmail.com wrote:
>>
>> Signed-off-by: Nick Loeve <trickie@gmail.com>
>> ---
>>  arch/arm/mach-omap2/board-n800-camera.c |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
>> index b525125..63bca1f 100644
>> --- a/arch/arm/mach-omap2/board-n800-camera.c
>> +++ b/arch/arm/mach-omap2/board-n800-camera.c
>> @@ -221,9 +221,10 @@ static int tcm825x_power_set(int power)
>>
>>  static const struct tcm825x_reg *tcm825x_default_regs(void)
>>  {
>> -     if (machine_is_nokia_n810())
>> +#ifdef CONFIG_MACH_NOKIA_N810
>> +        if (machine_is_nokia_n810())
>>               return tcm825x_regs_n810;
>> -
>> +#endif
>>       return tcm825x_regs_n800;
>>  }
>
> I think the best way would be removing the ifdefs on tcm825x_regs_*
> Could you try it ?

Yes you are right. Builds and and boots fine on a n800. I will send a
new patch.

>
> --
> Best Regards,
>
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
>



-- 
Nick Loeve
