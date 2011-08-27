From: Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 21:16:55 +0530
Message-ID: <4E59116F.5000905@ti.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>	<4E590756.9030307@ti.com> <CACVXFVPPPUsntdCT=m=vRJ9XVksn6rGMzqJVvdD+sj=eOcTadg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVPPPUsntdCT=m=vRJ9XVksn6rGMzqJVvdD+sj=eOcTadg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 27 August 2011 08:48 PM, Ming Lei wrote:
> On Sat, Aug 27, 2011 at 11:03 PM, Santosh<santosh.shilimkar-l0cyMroinI0@public.gmane.org>  wrote:
>> Hi,
>>
>> On Saturday 27 August 2011 08:18 PM, ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org wrote:
>>>
>>> From: Ming Lei<ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>>>
>>> This patch fixs one performance bug on ARM Cortex A9 dual core platform,
>>> which has been reported on quite a few ARM machines(OMAP4, Tegra 2,
>>> snowball...),
>>> see details from link of https://bugs.launchpad.net/bugs/709245.
>>>
>>> In fact, one mb() on ARM is enough to flush L2 cache, but
>>> 'dummy->hw_token = token;' after mb() is added just for obeying
>>> correct mb() usage.
>>>
>> Who said "one mb() on ARM is enough to flush L2 cache" ?
>> It's just a memory barrier and it doesn't flush any cache.
>> What it cleans is the CPU write buffers and the L2 cache
>> write buffers
>
> Yes,  your description is more accurate, it should be L2 write buffer,
> I see mb() will call outer_sync() on ARM.
>
>>
>>> The patch has been tested ok on OMAP4 panda A1 board, the performance
>>> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
>>> 14~16MB/sec after applying this patch.
>>>
>> Though number looks great, how is the below patch helping to get better
>> numbers.
>
> The patch can make ehci HC see the up-to-date qtd, so make usb transaction
> executed correctly. If a qtd->token is not updated, maybe IOC is not
> set or set very
> late, so interrupt can't be triggered in time, also mistaken 'total
> bytes to transfer'
> can make HC work badly.
>
> In fact, I have traced the problem and found ehci irq is often delayed
> by ehci HC.
> also sometimes ehci irq is lost, so I start to trace ehci driver and
> find the problem here.
>
You are missing all of this important description in change log.

>>
>>> Signed-off-by: Ming Lei<ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>>> ---
>>>   drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>>>   1 files changed, 14 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>>> index 0917e3a..65b5021 100644
>>> --- a/drivers/usb/host/ehci-q.c
>>> +++ b/drivers/usb/host/ehci-q.c
>>> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>>>                         wmb ();
>>>                         dummy->hw_token = token;
>>>
>>> +                       /* The mb() below is added to make sure that
>>> +                        * 'token' can be writen into qtd, so that ehci
>>> +                        * HC can see the up-to-date qtd descriptor. On
>>> +                        * some archs(at least on ARM Cortex A9 dual
>>> core),
>>> +                        * writing into coherenet memory doesn't mean the
>>> +                        * value written can reach physical memory
>>> +                        * immediately, and the value may be buffered
>>> +                        * inside L2 cache. 'dummy->hw_token = token;'
>>> +                        * after mb() is added for obeying correct mb()
>>> +                        * usage.
>>> +                        * */
>>> +                       mb();
>>> +                       token = dummy->hw_token;
>>> +
>>
>> This patch at max fix some corruption if the memory buffer
>> used is buffer-able. Infact I see there is already a write memory
>> barrier above. So just pushing that down by one line should
>> be enough.
>
> The above wmb is used to order updating qtd->hw_next and
> dummy->hw_token.
>
>>
>>>                        dummy->hw_token = token;
>>>                        wmb ();
>>
>> Is there another patch along with this which removes, some cache clean
>> on this buffer ?
>
> No, I am not sure the wmb should be merged with mb().
>
It will work but I leave that call to you since I don't understand much
what that function is doing. Infact I see, excessive usage of wmb()
in qh_append_tds()

Regards
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
