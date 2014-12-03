From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about patch "i2c: omap: resize fifos before each message"
Date: Wed, 3 Dec 2014 23:04:37 +0300
Message-ID: <7EACB0B2-7079-4FEB-8009-58682730F8A6@gmail.com>
References: <A20987D6-DEEC-488D-9655-36A4D186599B@gmail.com> <20141203154936.GF16138@saruman> <8C51B585-BFD6-48CC-A2C4-EB88CB820426@gmail.com> <20141203174938.GJ16138@saruman> <7602A84A-43B2-4C22-ACFA-FEA0640A6B7D@gmail.com> <20141203193826.GK16138@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203193826.GK16138@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


03 =C4=C5=CB. 2014 =C7., =D7 22:38, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> =CE=C1=D0=
=C9=D3=C1=CC(=C1):

> then handle slave interrupts :-) But handle them so that it won't rac=
e
> with a master transfer request. Moving omap_i2c_xfer() inside the IRQ
> handler isn't the best way to do it, however.

I do that with care :)

Currently, only 'resize fifo' and 'clear fifo' is the one thing what mu=
st=20
be moved into ISR (I'll check is it possible or late).=20
Because I can't ask ISR to generate interrupt to start master transfer.
I thought about that without luck.
I have to write to CON register. I can lock xfer for short time to
check STAT (for AAS) and either write CON or flag to start master after
slave complete.

'clear fifo' must be done in response to NACK. TRM states this[1]"
"TX and RX FIFOs must be cleared (the I2Ci.I2C_BUF[6] TXFIFO_CLR
and I2Ci.I2C_BUF[14] RXFIFO_CLR bits are set to 1)."

'resize fifo' could be avoided at all, but, it so nice feature.

And yes, if we could utilize full fifo to send message, we could set
threshold to message size and get only RRDY at the end.

If message size is greater than fifo size, we want to use double
buffer scheme to minimize ISR latencies.

But now, variable 'fifo_size' is set to half of IP real fifo size.
And for messages with fifo_size/2 ... fifo_size we use drainig
feature (get RDR, XRD). While we could receive only one IRQ.
I'll fix that.

>> And, I'll try to move fifo threshold init code into ISR. Don't see
>> something wrong.
>=20
> I wouldn't do that. It's just too late... look, IRQs won't fire until
> I2C_CON is setup to start a transfer (transmit or receive), you *must=
*
> resize FIFO before starting a transfer otherwise, well, you know...
Looks, like RRDY is fired after simple compare with threshold.
I'll check is this possible (but, that doesn't cover into TRM).
Or may be it is late to change it.

[1] AM-DM37x Multimedia Device Silicon Revision 1.x  - sprugn4r,
     p. 2796, Table 17-9. HS I2C Interrupt Events--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
