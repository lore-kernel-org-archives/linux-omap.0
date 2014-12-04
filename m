From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: omap: fix buffer overruns during RX/TX data
 processing
Date: Thu, 4 Dec 2014 10:09:47 -0800
Message-ID: <20141204180946.GG2817@atomide.com>
References: <1417294803-14729-1-git-send-email-al.kochet@gmail.com>
 <1417294803-14729-2-git-send-email-al.kochet@gmail.com>
 <20141201195841.GD2817@atomide.com>
 <B3F4FEFF-2333-473D-8A35-7D4EF1C44D90@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B3F4FEFF-2333-473D-8A35-7D4EF1C44D90-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexander Kochetkov <al.kochet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [141202 03:19]:
>=20
> 01 =D0=B4=D0=B5=D0=BA. 2014 =D0=B3., =D0=B2 22:58, Tony Lindgren <ton=
y@atomide.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> > I think this is a different issue than what I'm seeing.
>=20
> Hello, Tony!
>=20
> Thank you for testing!
>=20
> Could check i2c-omap.c from commit ca1f8da9ac5ce6e63d8f6933f83fabc1f3=
f961f4.
> As all my changes comes after it[1]. So I can understand was the prob=
lem before my work.

The issue I'm seeing on 2430sdp is some earlier regression that
has started happening over the past year or so. No idea when
though as it sometimes works and sometimes does not. So it does
not have anything to do with your patches.
=20
> I there was no problems, then try with my first commit:
> 27caca9d2e01c92b26d0690f065aad093fea01c7
>=20
> The problems you talk about is this?
> [    9.675994] omap_i2c 48072000.i2c: controller timed out
> [   10.704010] omap_i2c 48072000.i2c: controller timed out
> [   11.734069] omap_i2c 48072000.i2c: controller timed out
> root@omap2430sdp:/# [   12.823638] omap_i2c 48072000.i2c: controller =
timed out

No, I'm seeing just this:

omap_i2c 48070000.i2c: bus 0 rev3.3 at 100 kHz
omap_i2c 48072000.i2c: bus 1 rev3.3 at 100 kHz
twl 1-0048: PIH (irq 216) chaining IRQs 217..225
twl 1-0048: power (irq 222) chaining IRQs 225..232

And the system just hangs. With i2c-omap debug enabled, the lines
around the twl are:

omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
twl 1-0048: PIH (irq 216) chaining IRQs 217..225
twl 1-0048: power (irq 222) chaining IRQs 225..232
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 2, flags: 0x0, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 2, flags: 0x0, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)

And then it hangs. In the working case, the output continues with:

omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
twl 1-0048: PIH (irq 216) chaining IRQs 217..225
twl 1-0048: power (irq 222) chaining IRQs 225..232
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x0049, len: 2, flags: 0x0, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 2, flags: 0x0, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 2, flags: 0x0, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x0, stop: 0
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0010)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
omap_i2c 48072000.i2c: addr: 0x004b, len: 1, flags: 0x1, stop: 1
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0008)
omap_i2c 48072000.i2c: IRQ (ISR =3D 0x0004)
=2E..


=20
> And how it is possible to switch from ti,omap2430-i2c to ti,omap2420-=
i2c?
> They are so different IP, from the driver point of view. They have di=
fferent
> data bus width.

Yes sorry, you're right. Downgrading it to  ti,omap2420-i2c just
seems to quiet down the errors as the I2C then does not work
at all :)

Of course the issue I'm seeing could be caused by hung twl4030
PMIC too.

Regards,

Tony

=20
> Alexander.
>=20
> [1]
> alexander@ubuntu:busses$ git log --pretty=3Doneline --reverse ca1f8da=
9ac5ce6e63d8f6933f83fabc1f3f961f4^..HEAD -- i2c-omap.c=20
> ca1f8da9ac5ce6e63d8f6933f83fabc1f3f961f4 i2c: remove FSF address
> 27caca9d2e01c92b26d0690f065aad093fea01c7 i2c: omap: fix NACK and Arbi=
tration Lost irq handling
> 854a59425a0b9600ee974b113aae081c873163f6 i2c: omap: cleanup register =
definitions
> 903c3859f77f9b0aace551da03267ef7a211dbc4 i2c: omap: implement workaro=
und for handling invalid BB-bit values
> 80cc361f14e8fa97119afa3324c2c913915e7252 i2c: omap: don't reset contr=
oller if Arbitration Lost detected
> 39370ab406933efdedb425910f0a36c16667c45f i2c: omap: add notes related=
 to i2c multimaster mode
> ccfc866356674cb3a61829d239c685af6e85f197 i2c: omap: fix i207 errata h=
andling
> 7d168dc7ed384e50bb7bff4920b73550fd2e9fcb Merge branch 'i2c/for-3.19' =
into i2c/for-next
> 2f769d173f0e6a2e85d75fe396f18f794fc4a615 omap: i2c: don't check bus s=
tate IP rev3.3 and earlier
> 2b6f66d87b44aaf1f34f071e6f6430c3ccaa8812 i2c: omap: fix buffer overru=
ns during RX/TX data processing
> 30c52545106785405856c7e7e40b683b79c8084a i2c: omap: show that the rea=
son of system lockup is an unhandled ISR event
>=20
>=20
