From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 23:18:14 +0800
Message-ID: <CACVXFVPPPUsntdCT=m=vRJ9XVksn6rGMzqJVvdD+sj=eOcTadg@mail.gmail.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<4E590756.9030307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E590756.9030307-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 27, 2011 at 11:03 PM, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org> wr=
ote:
> Hi,
>
> On Saturday 27 August 2011 08:18 PM, ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org wrote:
>>
>> From: Ming Lei<ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>>
>> This patch fixs one performance bug on ARM Cortex A9 dual core platf=
orm,
>> which has been reported on quite a few ARM machines(OMAP4, Tegra 2,
>> snowball...),
>> see details from link of https://bugs.launchpad.net/bugs/709245.
>>
>> In fact, one mb() on ARM is enough to flush L2 cache, but
>> 'dummy->hw_token =3D token;' after mb() is added just for obeying
>> correct mb() usage.
>>
> Who said "one mb() on ARM is enough to flush L2 cache" ?
> It's just a memory barrier and it doesn't flush any cache.
> What it cleans is the CPU write buffers and the L2 cache
> write buffers

Yes,  your description is more accurate, it should be L2 write buffer,
I see mb() will call outer_sync() on ARM.

>
>> The patch has been tested ok on OMAP4 panda A1 board, the performanc=
e
>> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
>> 14~16MB/sec after applying this patch.
>>
> Though number looks great, how is the below patch helping to get bett=
er
> numbers.

The patch can make ehci HC see the up-to-date qtd, so make usb transact=
ion
executed correctly. If a qtd->token is not updated, maybe IOC is not
set or set very
late, so interrupt can't be triggered in time, also mistaken 'total
bytes to transfer'
can make HC work badly.

In fact, I have traced the problem and found ehci irq is often delayed
by ehci HC.
also sometimes ehci irq is lost, so I start to trace ehci driver and
find the problem here.

>
>> Signed-off-by: Ming Lei<ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> ---
>> =A0drivers/usb/host/ehci-q.c | =A0 14 ++++++++++++++
>> =A01 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 0917e3a..65b5021 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wmb ();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dummy->hw_token =3D t=
oken;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The mb() below is a=
dded to make sure that
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 'token' can be wr=
iten into qtd, so that ehci
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* HC can see the up=
-to-date qtd descriptor. On
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* some archs(at lea=
st on ARM Cortex A9 dual
>> core),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* writing into cohe=
renet memory doesn't mean the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value written can=
 reach physical memory
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* immediately, and =
the value may be buffered
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* inside L2 cache. =
'dummy->hw_token =3D token;'
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after mb() is add=
ed for obeying correct mb()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* usage.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D dummy->hw_to=
ken;
>> +
>
> This patch at max fix some corruption if the memory buffer
> used is buffer-able. Infact I see there is already a write memory
> barrier above. So just pushing that down by one line should
> be enough.

The above wmb is used to order updating qtd->hw_next and
dummy->hw_token.

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy->hw_token =3D toke=
n;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb ();
>
> Is there another patch along with this which removes, some cache clea=
n
> on this buffer ?

No, I am not sure the wmb should be merged with mb().

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
