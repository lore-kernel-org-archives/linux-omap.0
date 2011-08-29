From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 22:25:10 +0800
Message-ID: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA@mail.gmail.com>
References: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g@mail.gmail.com>
	<Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1108281233270.3742-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Aug 29, 2011 at 1:00 AM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>=
 wrote:
> On Sun, 28 Aug 2011, Ming Lei wrote:
>
>> > I've been following this whole discussion. =A0I didn't understand =
the
>> > idea behind the original patch, and I don't understand this. =A0Wh=
at
>> > reason is there for adding a memory barrier after the "dummy->hw_t=
oken
>> > =3D token" line? =A0Such a barrier would not accomplish anything u=
seful,
>> > because there are no later memory accesses which need to be ordere=
d
>> > with respect to that line.
>>
>> Here, mb is used to synchronize =A0between writing of CPU and readin=
g of
>> ehci HC, see below:
>
> A memory barrier never synchronizes events between two processors (fo=
r
> example, between the CPU and HC). =A0It only affects ordering for the
> processor it executes on. =A0That's why you always have to use memory
> barriers in pairs for inter-CPU synchronization: one memory barrier
> instruction for each CPU.

IMO, for SMP case, memory barrier pairs(smp_*) are required to synchron=
ize
events between two processors. mb/wmb/rmb are mainly used to
synchronize events between CPU and device, and one barrier may be
enough, for example:

	CPU							device=09
	A=3D1;
	wmb
	B=3D2;
									read B
									read A

one wmb is used to order 'A=3D1' and 'B=3D2', which will make the two w=
rite
operations reach to physical memory as the order: 'A=3D1' first, 'B=3D1=
' second.
Then the device can observe the two write events as the order above,
so if device has seen 'B=3D=3D2', then device will surely see 'A=3D=3D1=
'.

>
>> =A0 =A0 =A0 CPU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EHC=
I
>> =A0 =A0 =A0 dummy->hw_token =3D token;
>> =A0 =A0 =A0 mb
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 read =A0dummy->hw_token
>>
>> The mb() introduced =A0was supposed to be used to make sure that EHC=
I
>> can see the correct value of =A0dummy->hw_token.
>
> It won't do that. =A0All it will do is guarantee that the CPU writes =
out
> dumy->hw_token before it writes out or reads in any values executed
> after the mb.
>
>> =A0If EHCI can't get the correct
>> hw_token in time, it will work badly, such as irq delay or irq lost =
which may be
>> caused by mistaken 'IOC' or 'total bytes to transfer' in hw_token.
>
> No. =A0All that will happen is that the HC will execute the qTD a lit=
tle
> later, when it does read the correct hw_token. =A0No IRQs will be los=
t,
> and there will be no mistaken IOC or "total bytes to transfer" values=
=2E

IMO, the dummy has been linked into queue pointed by qh->hw->hw_qtd_nex=
t,
so EHCI will fetch dummy qtd and execute the transaction and will not h=
ave
any delay on the transaction.

Let me explain the problem again: On ARM, the wmb() before
'dummy->hw_token =3D token;'
will flush l2 write buffer into memory and all parts of 'dummy' except
for hw_token field
have reached into memory already, but dummy->hw_token will stay at l2
write buffer
and not reach into memory at this time, so ehci may fetch a
inconsistent qtd and execute it,
then mistaken IOC or "total bytes to transfer"  are read by EHCI and
cause delayed irq
or lost irq.

It is not only a reasoning or guess, and I have traced this kind of
fact certainly.

>
>> =A0This is just
>> what the patch is to fix.
>
> The patch won't fix this. =A0You're trying to force the CPU to write =
out
> dummy->hw_token more quickly. =A0A memory barrier won't do that. =A0A=
nd
> even if the CPU does write out the value more quickly, that doesn't
> guarantee it will be in time for the HC to see the new value right
> away.
>
>> But I think the above is still not correct, and the correct way may =
be
>> like below:
>>
>> =A0 =A0 =A0 CPU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EHC=
I
>> =A0 =A0 =A0 dummy->hw_token =3D token;
>> =A0 =A0 =A0 wmb
>> =A0 =A0 =A0 qh->hw->hw_qtd_next =3D QTD_NEXT(ehci, dummy->qtd_dma);
>
> If you do this write, you will corrupt the hardware list. =A0You _mus=
t_
> _not_ modify the hardware fields of an active QH.

Yes, I agree on it. hw_qtd_next is write by HC and qh_refresh(), and it
should be written only by cpu when the qh is in idle state.

> Besides, qh_link_async() calls qh_refresh() -> qh_update(), which doe=
s
> this already. =A0And it does this correctly, with the appropriate che=
cks
> to make sure the QH isn't active.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 fetch next qtd from qh->hw->hw_qtd_next
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 read =A0qtd->hw_token
>>
>> The problem is that qh has already linked dummy into its queue befor=
e(as did in
>> qh_update), so even after 'dummy->hw_token =3D token;' is executed o=
n CPU, EHCI
>> still may not fetch the up-to-date value of the qtd(dummy in here),
>> and this should
>> be the root cause, IMO.
>
> There's no way to fix this. =A0The CPU and the HC are independent. =A0=
The
> HC is allowed to cache values whenever it likes (within certain
> limits). =A0If it has already cached an old value from the qTD, there=
's
> no way to force it to use a new value. =A0You just have to wait until=
 it
> refreshes its cache.

I don't think ehci will cache something inside hardware, and it will
always fetch qtd linked into qh from memory(not cache) to qh transfer o=
verlay.
We can find it in ehci spec 4.10.2.

As I explained above in the 'wmb' example, I hope we can use
the current memory barrier rules to fix this kind of problem and avoid
to invent new barrier. But because we can't write qh->hw->hw_qtd_next
when the qh has been linked into ehci async queue, it is not doable.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
