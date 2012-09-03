From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCHv3 2/9] ir-rx51: Handle signals properly
Date: Mon, 3 Sep 2012 23:41:55 +0200
Message-ID: <20120903214155.GA6393@hardeman.nu>
References: <1346349271-28073-1-git-send-email-timo.t.kokkonen@iki.fi>
 <1346349271-28073-3-git-send-email-timo.t.kokkonen@iki.fi>
 <20120901171420.GC6638@valkosipuli.retiisi.org.uk>
 <50437328.9050903@iki.fi>
 <504375FA.1030209@iki.fi>
 <20120902152027.GA5236@itanic.dhcp.inet.fi>
 <20120902194110.GA6834@valkosipuli.retiisi.org.uk>
 <5043BCB4.1040308@iki.fi>
 <20120903123653.GA7218@pequod.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120903123653.GA7218@pequod.mess.org>
Sender: linux-media-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>, Sakari Ailus <sakari.ailus@iki.fi>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hej,

On Mon, Sep 03, 2012 at 01:36:53PM +0100, Sean Young wrote:
>On Sun, Sep 02, 2012 at 11:08:20PM +0300, Timo Kokkonen wrote:
>> I guess the assumption is to avoid
>> breaking the transmission in the middle in case the process is signa=
led.
>> And that's why we shouldn't use interruptible waits.
>>
>> However, if we allow simply breaking the transmitting in case the
>> process is signaled any way during the transmission, then the handli=
ng
>> would be trivial in the driver. That is, if someone for example kill=
s or
>> stops the lirc daemon process, then the IR code just wouldn't finish=
 ever.
>>=20
>> Sean, do you have an opinion how this should or is allowed to work?
>
>You want to know when the hardware is done sending the IR. If you retu=
rn
>EINTR to user space, how would user space know how much IR has been se=
nt,=20
>if any?
>
>This ABI is not particularily elegant so there are proposals for a bet=
ter
>interface which would obsolete the lirc interface. David Hardeman has
>worked on this:
>
>http://patchwork.linuxtv.org/patch/11411/
>

Yes, the first step is an asynchronous interface using a kfifo which is
managed/fed using functionality in rc-core and drained by the drivers.

The size of the kfifo() itself is the only limiting factor right now,
but I do think we should eventually add some restrictions on the combin=
ed
duration of the pulse/space timings that are in the queue at any given
point.

Say, for example, that any given pulse/space value is not allowed to be
above 500ms and the total duration of the queue is not allowed to be
above 1000ms. In case user-space wants (for whatever reason)...to write
a 4000ms space, it would have to do so in 8 messages of 500ms each.

Each message write() provides the opportunity for a interruptible wait
(in the regular case) or returning EAGAIN (in the O_NONBLOCK case) -
assuming that the kfifo already holds pulse/space timing totalling
1000ms and/or is full.

EINTR should only be returned if nothing has been written to the kfifo
at all.

That way we would avoid policy in kernel while still making it possible
to kill a misbehaving user-space process by forcing it to drip feed lon=
g
TX sequences.

--=20
David H=E4rdeman
