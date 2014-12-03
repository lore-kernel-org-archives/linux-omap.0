From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about patch "i2c: omap: resize fifos before each message"
Date: Wed, 3 Dec 2014 20:34:21 +0300
Message-ID: <8C51B585-BFD6-48CC-A2C4-EB88CB820426@gmail.com>
References: <A20987D6-DEEC-488D-9655-36A4D186599B@gmail.com> <20141203154936.GF16138@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203154936.GF16138@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


03 =C4=C5=CB. 2014 =C7., =D7 18:49, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> =CE=C1=D0=
=C9=D3=C1=CC(=C1):

>=20
>> 2. I want to avoid changing fifos before message submission, because
>> IP can start receiving message in a slave mode (race).
>=20
> I2C is not full-duplex. There's no way it will receive any data while
> you're transmitting, right ?
>=20

I2C is half duplex, right. But, IP work in slave receiver and master tr=
ansmitter modes.
And IP switch to slave receiver mode after master transfer (simply clea=
r MST bit and ready for
reception and that TRM state about).=20
And question sounds like: what happen if we reset or change FIFO thresh=
old value
(in order to submit new master transfer) when IP start receiving data t=
o the fifo.
How many bytes we have to read on RRDY?
That race I'am talking about. And there is only one place where race co=
uldn't happen: it's
ISR (thread). So I want to move almost all master initialization code i=
nto ISR.


>> 3. dev->threshold is changed in range 1-fifo_size/2. So instead of R=
DR
>> we get RRDY and for messages larger then fifo_size/2 we still get RR=
DY
>> and RDR.
>=20
> we will only get RDR if message_size % threshold > 0. If we have a 16
> byte transfer and we program threshold to 8 bytes, we will get two RR=
DY
> IRQs.
>=20
>> Felipe, do you have in mind why do you want to avoid RDR and XDR eve=
nts?
>> Something about errata?
>=20
> nothing about errata. As the commit log say (or tried to say), if the
> entire message fits into the FIFO we save one interrupt. It's a
> micro-optimization.

I see, thank you. But due to error only half of fifo is utilized for th=
at.
And, I'll try to move fifo threshold init code into ISR. Don't see some=
thing wrong.

Thank you a lot!

Regards,
Alexander.
