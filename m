From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Sun, 16 Nov 2014 09:45:58 -0600
Message-ID: <20141116154558.GA7422@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
 <20141115035328.GA3289@saruman>
 <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60297 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbaKPPpn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Nov 2014 10:45:43 -0500
Content-Disposition: inline
In-Reply-To: <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: balbi@ti.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 15, 2014 at 08:42:03AM +0300, Alexander Kochetkov wrote:
> Hello again.
>=20
> > (please, never top-post)
> Sorry.
>=20
> Sorry for the inaccurate presentation of ideas. I am not a native
> English speaker.

neither am I ;-)

> First about patches:
> [PATCH 1/2] and [PATCH 2/2] - intended to solve two independent problems.
> They were sent as series, In the future, try not to do so, In order
> not to mislead.

sending several fixes as a series is not a problem, a problem would be
to make fixes depend on new features or cleanups.

> > How could I ever call omap_i2c_complete_cmd() with 'err' set as 0 if I
> > had either a NACK or Arbitration Lost ?
>=20
> [PATCH 1/2] - fix AL, NACK handling and does not apply to [PATCH 2/2].
> It not cause of problem solved of [PATCH 2/2].

still, how could we ever have that situation ? We break out of the loop
as soon as an error is encountered.

> > =08right, this is the same as it was before. If count reaches 100 we wi=
ll
> > omap_i2c_complete_cmd().
> *No*
>=20
> During refactoring submitted a series of patches was made the mistake.
> This error alters the behavior of the interrupt handler, if it ends
> with the message "Too much work in one IRQ".
>
> Error in the commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1.=20
> All subsequent commits were correct and translate this error further.
>=20
> In the parent commit 3312d25e1abdc41be8a75a1b2c3ccaa39a14ed99
> (the commit before 66b9298878742f08cb6e79b7c7d5632d782fd1e1) in case
> count reaches 100, loop breaks *without* calling omap_i2c_complete_cmd().
>=20
> In commit 66b9298878742f08cb6e79b7c7d5632d782fd1e1, in case
> count reaches 100, loop breaks and omap_i2c_complete_cmd() *get called*.

aaa, now I see what you're talking about. I'll review that code on
Monday. Let me see if that was intentional or I missed something.

> To see that, you need to open two versions of a file i2c-omap.c, side
> by side.
>=20
> i2c-omap.c version corresponding to parent commit:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driv=
ers/i2c/busses/i2c-omap.c?id=3D3312d25e1abdc41be8a75a1b2c3ccaa39a14ed99#n823
>=20
> i2c-omap.c version corresponding next commit:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driv=
ers/i2c/busses/i2c-omap.c?id=3D66b9298878742f08cb6e79b7c7d5632d782fd1e1#n823
>=20
> According to wikipedia: "Code refactoring is the process of
> restructuring existing computer code =E2=80=93 changing the factoring =E2=
=80=93
> without changing its external behavior.'
>=20
> And commit's (66b9298878742f08cb6e79b7c7d5632d782fd1e1) message states wh=
at:
> i2c: omap: switch over to do {} while loop
> this will make sure that we execute at least once.
> No functional changes otherwise.
>=20
> But functional change present!
> It's call of omap_i2c_complete_cmd()!
>=20
> The next question: What affects this change?
> If count reaches 100 and loop breaks and no error occupy during loop proc=
essing,
> and no error would be set in err_cmd, omap_i2c_complete_cmd will set 0 as
> result of transfer and wakeup omap_i2c_xfer. In other words, current i2c =
transfer
> will be aborted with incorrect (success) status set. But, does transfer c=
ompleted in real?
> Do buf data was sent to i2c slave device or received from it in real?
> Upper layer code would thing, that data was sent successfully.
>=20
> How to see that bug in real live? Just add extra delayes into isr thread.
> I did it unintentionally inserting dev_warn into isr thread.

right, apparently it is a bug, but it's very difficult to reproduce
considering we break out of IRQ handler as soon as something gets
transferred. The possibility of that count reaching 100 is very minor. A
bug nevertheless.

> BTW. I made more testing and provide more logs to demonstrate affected
> changes.
>=20
>=20
> > which deadlock are you talking about ? How do you trigger it ? Where are
> > the lockup debug traces ?
> >=20
> > Well, I tried to debug I2C ISR hang issue (thats another question I
> > want to discuss later) using output to console. I places few dev_warn
> >=20
> > if you found a bug with the ISR, why discuss it later ? How can I
> > understand if you found a real bug without proper logs ?
>=20
>=20
> I put in order my thoughts and describe. It's next problem, not
> related to patch1/patch2.
>=20
> In general, the problem (the 3rd one) is that linux either hang or
> segfault in the i2c-omap driver if another master on the i2c bus
> (multimaster environment),

multimaster is not supported by this driver, so you can't call that a
bug. It's a missing feature, it needs to be implemented. Nobody has ever
had access to a multimaster environment where to develop it, so it was
never done.

> submit write request to General Call Address. In that case ISR could
> not correctly handle RDR (or XRDY, ARDY, or that ever). Thats becase
> i2c-omap driver doesn't correctly handle i2c-controller's slave mode.

right, Linux doesn't support being the slave. That's also a missing
feature, not a bug.

> But controller enter slave mode after each master transfer. Yes, AAS
> and GC interrupts masked, but i2c-controller still sends RDR (or that
> ever events) when it detect slave access from another master on the
> bus.
>=20
> I have two safe solutions of the (3rd) problem in the mind:
> - keep interrupts disabled between i2c-master access (I think about imple=
menting
> i2c_omap_interrupt_enable_clr/i2c_omap_interrupt_enable_set helpers and p=
utting
> them in the right places)
> - keep controller disabled between i2c-master access (keep EN-bit of CON =
register 0)

send a patch and we'll see, but keep in mind if you want to support
multimaster, you need to implement it as per documentation.

> That solutions also help with races between isr and xfer_msg.

what races ? If you found races, that's another problem which should be
fixed separately from implementing a new feature.

> What do you think about that?
>=20
> How to reproduce 3-rd problem:
> In order to ease reproduce, you should disable i2c controller from
> entering suspend mode:
> echo on > /sys/devices/platform/omap/omap_i2c.2/power/control
>=20
> And then, using another i2c-master, connected to the same (i2c.2) bus,
> initiate I2C write transfer to Generall Call Address, than linux ether
> hang or isr thread segfault :)

right, it has never been implemented, what would you expect ? ;-)

--=20
balbi

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUaMa2AAoJEIaOsuA1yqRE0zkQAKAvmzesHql099KsXPl0e7JI
v+z80KbowPTFhp+HEoG4FtjlVFmRMDpUCZoUg51dJw02Bq3L/hrHmhP7vh/0JiKd
HVGr22M9lHbWIge45CvJW01JuwcjKPWLgaDizIxIK66uZG8L6i5IDZr+XYveh/e4
780lvLPCb1atZWEDx1mrjur5HWGHWpgb8nh7l5vfVznsAJ/8kVgC+MFS6wHJhzJ4
Wx2PugsWMkWUNZuaqee2IjZGXPWl2evTbo/jCwlffUh8Mi1t29YjyrIV7k+3aNAJ
ALa16cATFvjn9lsC6HKDGL9Ibof2YIeDLIt+sgsZQBWMzHYDQe3mqFTqIPIqf2q6
oBsWIyw/p9Gu0IDMgPdDxvfHLg9VTiuXAk/P8+F/2lMDqv9eUWqEnu10FMh61cWb
wroYSE/Shw0qnLO06+hcZiYn0lECeUlI7W5ob7C8sicY9j9g9ZOQvixLGzx7k8Qn
w1tu3LdzB6Yam2f/xet9AoglIUNhDI14kEIL6KGU9EqyKMmPumlSyUwaYDnUMWKO
Hf6/trrSbj/873dWWxrCfshqiaOMCHTHxy5dcPftfAsBGnlGt2oQs38aA1qzt/jn
6oVGebqBqJ2+ksjkUVzN6hHDvcjf9kKmDRxmsPa97S9d1zrbUzIo9EjTrW9gJ1zO
0vxbVOLfFqxhF+FtSVdQ
=onCe
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
