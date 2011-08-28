From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sun, 28 Aug 2011 13:00:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
References: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Santosh <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, 28 Aug 2011, Ming Lei wrote:

> > I've been following this whole discussion. =A0I didn't understand t=
he
> > idea behind the original patch, and I don't understand this. =A0Wha=
t
> > reason is there for adding a memory barrier after the "dummy->hw_to=
ken
> > =3D token" line? =A0Such a barrier would not accomplish anything us=
eful,
> > because there are no later memory accesses which need to be ordered
> > with respect to that line.
>=20
> Here, mb is used to synchronize  between writing of CPU and reading o=
f
> ehci HC, see below:

A memory barrier never synchronizes events between two processors (for
example, between the CPU and HC).  It only affects ordering for the
processor it executes on.  That's why you always have to use memory
barriers in pairs for inter-CPU synchronization: one memory barrier=20
instruction for each CPU.

> 	CPU								EHCI
> 	dummy->hw_token =3D token;
> 	mb
> 									read  dummy->hw_token
>=20
> The mb() introduced  was supposed to be used to make sure that EHCI
> can see the correct value of  dummy->hw_token.

It won't do that.  All it will do is guarantee that the CPU writes out=20
dumy->hw_token before it writes out or reads in any values executed=20
after the mb.

>  If EHCI can't get the correct
> hw_token in time, it will work badly, such as irq delay or irq lost w=
hich may be
> caused by mistaken 'IOC' or 'total bytes to transfer' in hw_token.

No.  All that will happen is that the HC will execute the qTD a little=20
later, when it does read the correct hw_token.  No IRQs will be lost,=20
and there will be no mistaken IOC or "total bytes to transfer" values.

>  This is just
> what the patch is to fix.

The patch won't fix this.  You're trying to force the CPU to write out=20
dummy->hw_token more quickly.  A memory barrier won't do that.  And=20
even if the CPU does write out the value more quickly, that doesn't=20
guarantee it will be in time for the HC to see the new value right=20
away.

> But I think the above is still not correct, and the correct way may b=
e
> like below:
>=20
> 	CPU								EHCI
> 	dummy->hw_token =3D token;
> 	wmb
> 	qh->hw->hw_qtd_next =3D QTD_NEXT(ehci, dummy->qtd_dma);

If you do this write, you will corrupt the hardware list.  You _must_
_not_ modify the hardware fields of an active QH.

Besides, qh_link_async() calls qh_refresh() -> qh_update(), which does=20
this already.  And it does this correctly, with the appropriate checks=20
to make sure the QH isn't active.

> 									fetch next qtd from qh->hw->hw_qtd_next
> 									read  qtd->hw_token
>=20
> The problem is that qh has already linked dummy into its queue before=
(as did in
> qh_update), so even after 'dummy->hw_token =3D token;' is executed on=
 CPU, EHCI
> still may not fetch the up-to-date value of the qtd(dummy in here),
> and this should
> be the root cause, IMO.

There's no way to fix this.  The CPU and the HC are independent.  The=20
HC is allowed to cache values whenever it likes (within certain=20
limits).  If it has already cached an old value from the qTD, there's=20
no way to force it to use a new value.  You just have to wait until it=20
refreshes its cache.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
