From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac
 mode
Date: Fri, 18 May 2018 11:37:20 -0500
Message-ID: <9e2ef403-4b67-f141-aed7-9f18714e16a6@ti.com>
References: <20180501174122.11323-1-grygorii.strashko@ti.com>
 <20180502.110841.378324128079268584.davem@davemloft.net>
 <CA+G9fYv5yXD4_hyUSxWra+gxux1NFv+sD2HgB7LyJ4E78bgh+A@mail.gmail.com>
 <20180517191037.GE504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517191037.GE504@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, nsekhar@ti.com, open list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05/17/2018 02:10 PM, Greg Kroah-Hartman wrote:
> On Thu, May 17, 2018 at 11:18:16PM +0530, Naresh Kamboju wrote:
>> On 2 May 2018 at 20:38, David Miller <davem@davemloft.net> wrote:
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Date: Tue, 1 May 2018 12:41:22 -0500
>> <trim>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> Applied and queued up for -stable, thank you.
>>
>> 4.4 stable-rc build failed for arm32.
>> MACHINE=am57xx-evm
>>
>> Build error log:
>> --------------------
>> drivers/net/ethernet/ti/cpsw.c:
>>   In function 'cpsw_add_dual_emac_def_ale_entries':
>> drivers/net/ethernet/ti/cpsw.c:1112:23:
>>   error: 'cpsw' undeclared (first use in this function)
>>     cpsw_ale_control_set(cpsw->ale, slave_port,
>>                          ^~~~
>> drivers/net/ethernet/ti/cpsw.c:1112:23: note:
>>   each undeclared identifier is reported only once for each function it appears
>>   in
>> scripts/Makefile.build:269: recipe for target 'drivers/net/ethernet/ti/cpsw.o'
>>   failed
>>   make[6]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
>> scripts/Makefile.build:476: recipe for target 'drivers/net/ethernet/ti' failed
>>   make[5]: *** [drivers/net/ethernet/ti] Error 2
>>
> 
> Now dropped, it's nice to see I got 3 reports about this :)
> 

Sry, my bad. I've tested till 4.4 if it can be applied without 
conflicts, but not tested build.

-- 
regards,
-grygorii
