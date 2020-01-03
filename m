From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Date: Fri, 3 Jan 2020 19:29:03 +0100
Message-ID: <521CC383-1118-480F-BC3B-B0E12F9F4CFC@goldelico.com>
References: <20200103081726.GD15023@darkstar.musicnaut.iki.fi> <6D46CA13-2E50-4144-86F1-CE4988BD654D@goldelico.com> <20200103172326.GF15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103172326.GF15023@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

> Am 03.01.2020 um 18:23 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
>=20
> Hi,
>=20
> On Fri, Jan 03, 2020 at 09:46:58AM +0100, H. Nikolaus Schaller wrote:
>>> Am 03.01.2020 um 09:17 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
>>> When booting v5.4 (or v5.5-rc4) on N900, the console gets flooded =
with:
>>>=20
>>> [    8.335754] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.365753] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.395751] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.425750] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.455749] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.485748] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.515777] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.545776] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>> [    8.575775] omap2-onenand 1000000.onenand: timeout waiting for =
DMA
>>>=20
>>> making the system unusable.
>>=20
>> I can confirm that this issue exists but so far we failed to bisect
>> and make a proper report.
>>=20
>> Sometimes the system boots fine and sometimes it fails.

Well, we boot from =C2=B5SD and the number of the timeouts changes. So =
it may
be a race or depend on driver load sequence if we come to a login: or =
not.
But this is not the real bug.

>>=20
>> It happens on omap3-gta04a5one.dts only, but not with =
omap3-gta04a4.dts
>> (both dm3730 but different NAND).
>=20
> I tried three different boards (N810, N900 and N950) and it always
> fails reliably.

The big question is why the patch is harmful.

I tried to understand what the patch is doing (without any knowledge
about the DMA hard- or software architecture).

Basically it reorders error handling and some corner cases.
Maybe it handles one differently that happens only for OneNAND.

What did jump to my mind is that before the patch there is an
unconditional call to omap_dma_chan_read(c, CCR) if (!c->paused && =
c->running)=20

And then DMA_COMPLETE is returned or ret if txstate =3D=3D 0

With the new code the check for DMA_COMPLETE comes first and
directly leads to a return. Independently of txstate.

So if we have (!c->paused && c->running) and dma_cookie_status()
returns DMA_COMPLETE, there is no longer a call to omap_dma_chan_read()

Since I do not understand what omap_dma_chan_read() is doing,
and if (!c->paused && c->running) is relevant here,
I can not conclude if that is harmful.

But I can imagine that reading a register may have a side-effect of
resetting some bit like interrupt status registers.

I hope that Peter or Tony can respond soon.

BR and thanks,
Nikolaus
