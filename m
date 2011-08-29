From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 23:21:52 +0800
Message-ID: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
References: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA@mail.gmail.com>
	<Pine.LNX.4.44L0.1108291046540.2525-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1108291046540.2525-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Aug 29, 2011 at 11:03 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org=
> wrote:
> On Mon, 29 Aug 2011, Ming Lei wrote:
>
>> IMO, the dummy has been linked into queue pointed by qh->hw->hw_qtd_=
next,
>> so EHCI will fetch dummy qtd and execute the transaction and will no=
t have
>> any delay on the transaction.
>>
>> Let me explain the problem again: On ARM, the wmb() before
>> 'dummy->hw_token =3D token;'
>> will flush l2 write buffer into memory and all parts of 'dummy' exce=
pt
>> for hw_token field
>> have reached into memory already, but dummy->hw_token will stay at l=
2
>> write buffer
>> and not reach into memory at this time, so ehci may fetch a
>> inconsistent qtd and execute it,
>> then mistaken IOC or "total bytes to transfer" =A0are read by EHCI a=
nd
>> cause delayed irq
>> or lost irq.
>
> No. =A0Even if the HC reads dummy before dummy->hw_token has been wri=
tten
> out to memory from the L2 cache, it will not see any inconsistencies.
> It will see the old value in hw_token, which has the ACTIVE bit clear=
=2E
> Therefore it will not try to execute the qTD but will move on to the
> next QH. =A0See what the fourth paragraph in section 4.10.2 of the EH=
CI
> spec says about the case where a qTD's ACTIVE bit is set to 0.

Suppose HC can see the old value in hw_token, which has the ACTIVE bit =
clear.

The qtd transaction will not be executed until the new token is
flushed into memory.
=46rom view of CPU, the irq is still be delayed because ioc irq is gene=
rated
after the qtd transaction is executed when new token is flushed into
memory. The delay
depends on how long the token will be flushed into memory.

=46rom my observation, the delay is commonly over 5ms for CSW, sometime=
s the delay
is more than 20ms, so caused the bad performance.

Also I am not sure if EHCI can read the old hw_token correctly in this =
kind of
inconsistent memory state.

>
> Some EHCI implementations have a quirk, in which they perform the
> overlay even when ACTIVE is clear. =A0But even these implementations
> won't try to execute the qTD, because the old value of dummy->hw_toke=
n
> also has the HALT bit set.
>
>> It is not only a reasoning or guess, and I have traced this kind of
>> fact certainly.
>
> If your controller behaves as you suggest then it is buggy. =A0And in
> that case, adding another memory barrier won't fix it. =A0There is st=
ill
> the possibility that the HC will read dummy during the brief time aft=
er
> the existing wmb() and before the CPU has written dummy->hw_token.

No, the mb after 'dummy->hw_token=3Dtoken' does fix the problem. As
said above, IOC IRQ is surely delayed from view of CPU.


thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
