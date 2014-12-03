From: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about patch "i2c: omap: resize fifos before each message"
Date: Wed, 3 Dec 2014 22:01:33 +0300
Message-ID: <7602A84A-43B2-4C22-ACFA-FEA0640A6B7D@gmail.com>
References: <A20987D6-DEEC-488D-9655-36A4D186599B@gmail.com> <20141203154936.GF16138@saruman> <8C51B585-BFD6-48CC-A2C4-EB88CB820426@gmail.com> <20141203174938.GJ16138@saruman>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141203174938.GJ16138@saruman>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


03 =C4=C5=CB. 2014 =C7., =D7 20:49, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> =CE=C1=D0=
=C9=D3=C1=CC(=C1):


>  It can also be a master receiver and a
> slave transmitter.=20
Agree, but this unrelated to races.

>  Note also that MST bit does *not* auto clear.

Yes, it *does* auto clear!
MST bit automatically clear when IP receive AL.
See TRM [1]. All other TRMs (omap3530, omap3430,=20
omap4, omap5) has the same picture.

=46rom TRM:
2Ci.I2C_CON[10] MST bits are cleared by hardware

And MST bit clear after IP send STP (success transfer).

Did you see what value is in CON register after successful master trans=
fer?
Apply my patch and see that.
It doesn't have MST bit set. That mean IP is in slave mode
(receiver or transmitter - doesn't matter) after *any* master transfer.

And simple test show that. IP respond to GC address (address 0).
And respond to SA address (if programmed).

And TRM[1] figure has comment for 'end' state:
"I2C controller goes into slave receiver mode."

And IP keeps into slave mode until 'suspend'.

Then, after 'resume' IP initialized into slave receiver mode. There is =
short=20
time after resume and master start initialize new transfer.

So, then we start new transfer IP could start receiving slave command.

> Also,
> the IP won't do anything (considering it's always in master mode) unt=
il
> STT bit is set again
Yes, it do slave reception or tranmittion with STT bit set to 0.

You could set STT bit to 1, and then it got cleared to 0, you
now, that IP received Start condition with slave transfer.

You could leave STT bit set to 0, but IP still respond to slave transfe=
r.
(at least the IP on dm3730).

And we can't set MST bit again after master transfer to leave IP in the
master mode. We must disable IP (clear EN bit) before transfers to
disable slave mode, or we must handle slave interrupts.
Because un handled  slave interrupt leave SCL low.

[1] AM-DM37x Multimedia Device Silicon Revision 1.x  - sprugn4r,
    p.2815, Figure 17-32. HS I2C Master Receiver Mode,=20
    Interrupt Method, in F/S and HS Modes (I2C Mode)
