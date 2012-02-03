From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Fri, 3 Feb 2012 23:11:13 +1100
Message-ID: <20120203231113.25ae2d3a@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//lAh3i/SDYh.FNuHS__a+X7"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47559 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2BCMLa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 07:11:30 -0500
In-Reply-To: <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Greg KH <gregkh@suse.de>, greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_//lAh3i/SDYh.FNuHS__a+X7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 13:42:13 +0200 Grazvydas Ignotas <notasas@gmail.com> wro=
te:

> On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
> > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> >> On Fri, 3 Feb 2012, NeilBrown wrote:
> >>
> >> > then CPUIDLE enters lower states and I think it uses less power but I
> >> > sometimes lose the first char I type (that is known) but also I some=
times get
> >> > corruption on output.
> >>
> >> I don't see any output corruption on 35xx BeagleBoard, either with or
> >> without these patches. =C2=A0So this is presumably a 37xx-centric prob=
lem, and
> >> unrelated to these patches, I would guess.
> >
> > Maybe it is 37xx specific. =C2=A0I think this is a DM3730.
>=20
> Not sure if it's the same problem but with 3530 on 3.2 with
> sleep_timeout set, I usually get first char dropped (as expected) but
> sometimes I get corrupted char instead too. Corrupt char seems to
> almost always happen if I set cpufreq to powersave, on performace it's
> almost always ok, so maybe it's some timing problem,

I see that too - I'm glad someone else does :-)

If I look at the corruption as compared to the expected character, it is
always the case some it has been shifted down a few bits, with '1's shifted
in the top.
As bytes are sent lsb first followed by stop bits which are '1', this is
completely consistent with clocking the bits in a little bit late.

I see this with baud rates of 115200 and higher, but never with lower.

My theory is that there is a delay between the falling RX line waking the
system up, and the CPU enabling the UART - whether enabling the clocks or
doing a full config, I am not sure - though I think the former.

Maybe if we could enable the UART clocks immediately after returning from t=
he
WFI instruction we could avoid the corruption....

NeilBrown


--Sig_//lAh3i/SDYh.FNuHS__a+X7
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyvO4Tnsnt1WYoG5AQLebhAAj2LIQ6GoEPQ98hvEEB8Ar5o9jQj8u6EJ
YpgEBM2RZpx2/XBnaIs2oRSNC0h3tLgErJo9sNISCJTez9ZTmFV1z0Q9sA1dOFRU
JkvAN34fobqcyfrhM9ftFxAHtkg+uHeO4oreCT45VePPvM3MGZsosEkNHGe8lJL7
nwGYB9aOTLglkID1FJz7kWNS/YodzSXF37FxXWhQew6Dnl/UeXITZZS1MvTvwthv
kYG/3akp2+whRYcQfVnCnfUCdFZ87cbgUntMo5W4jRa+sTtCRlP2pw2C+RkJYXQx
Aym4kupe+ggWcYgXI4bbMQK1ey8WXzYCSJXO5aUo0dmRC8vEqQV6EU4QLPcvpUJ0
TlFhDiMS7Xu8Nn8mRKHQU09Xdx9pAqZiHwNHUM1s4SG1lEdYmI7npl/n4CCOj1EC
VJAP4QVwnB1Ew48mvjmIPrrc9QTXYmDhU1NxK0QZ/P4qw0hYrnCvFylNP8Hd9a6k
mIxmTW8sYGkodlafujAEgt3JqJ3LMOLaStnPAS4nnaPVdELtIQ6VbYF4V6PagP8k
D0SB9Tfnn1jv0qwlqKz48rleRgcKa4NxPPSMqZcpfOJcs3HCTZKFWo9aeqb09u/7
dMBDXSZ9LHeOHfQmIPMHSFVi3ZrBeo7CRe8pJ8X4EsuvcKxm7kQKJiuck3AmsQsg
0miw117LdAg=
=DTxT
-----END PGP SIGNATURE-----

--Sig_//lAh3i/SDYh.FNuHS__a+X7--
