From: Nishanth Menon <nm@ti.com>
Subject: Re: SGX support on AM572x
Date: Tue, 11 Nov 2014 16:22:25 -0600
Message-ID: <20141111222225.GB10132@kahuna>
References: <D087A0BB.5A41E%john3909@gmail.com>
 <20141111195403.GA16958@kahuna>
 <D087AB25.5A4A5%john3909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbaKKWW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2014 17:22:26 -0500
Content-Disposition: inline
In-Reply-To: <D087AB25.5A4A5%john3909@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Syn <john3909@gmail.com>
Cc: linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>

On 13:58-20141111, John Syn wrote:
>=20
> On 11/11/14, 11:54 AM, "Nishanth Menon" <nm@ti.com> wrote:
>=20
> >On 11:17-20141111, John Syn wrote:
> >> With the release of the Beagleboard-X15 in February 2015, I=C2=B9m=
 trying to
> >> get a handle on the status of SGX support for the AM572x processor=
=2E Is
> >> anyone working on adding this support and is there any schedule fo=
r
> >> releasing SGX on AM572x? There is a lot of interest on the beagleb=
oard
> >> mailing list, but SGX support seems to be a big stumbling block.
> >
> >1. Are you looking for SGX driver support in
> >https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/ ?
> >
> >OR
> >
> >2. Are you looking for distro support?
> >
> >OR
> >3. Are you looking for what TI release(if any) will contain?
> >
> >for (1) you already have response from beagleboard mailing list - TI=
, to
> >my knowledge will not support IMG[1] drivers in kernel.org - at leas=
t no
> >known activity in the past present or future to do that.
> Yeah, I think this is clearly understood.
> >
> >For (2): as the distro folks how they want to do things - again depe=
nds
> >on where you are getting your distro from.
> The official distro for Beagleboard-X15 is Robert Nelson=E2=80=99s De=
bian distro,
> but as long as SGX is available for AM572x, I=E2=80=99m sure Robert w=
ill find a
> way to get this working.

I suppose - you should probably use which ever mailing list meant for
Debian and Robert for that discussion. we discuss kernel.org kernel in
this list. obviously many stuff Robert does pick up comes from here -
lets stick with that.

> >
> >For (3): use TI support channel over e2e Phorums[2] and look at rele=
vant
> >TI release's release notes. Things like [3] are handled properly tha=
t
> >way.
> I took a look in e2e and I did find one promising posting:
>=20
> http://e2e.ti.com/support/omap/f/885/t/366372.aspx
>=20
> However, this article and your reference [3] are for V3.8 and I belie=
ve
> BeagleBoard-X15 will be released with V3.14 or V3.18. So my question =
is
> related to [3] and SGX support for either V3.14 or V3.18.

I do think that discussion has the wrong audience in this mailing list.

We dont deal with SGX drivers in upstream kernel. If you need to know
from TI, use e2e and ask on the thread - TI formal reply can only come
from that source.

>=20
> Regards,
> John
> >
> >
> >Other recent references:
> >https://plus.google.com/100242854243155306943/posts/TKX7GfHkTow
> >http://beagleboard.org/Community/Forums?place=3Dmsg%2Fbeagleboard%2F=
1t3yxkPY
> >SB8%2FxCbkoWC_GhQJ
> >
> >
> >[1] http://www.imgtec.com/community/
> >[2] e2e.ti.com
> >[3]=20
> >http://git.omapzoom.org/?p=3Ddevice/ti/proprietary-open.git;a=3Dtree=
;f=3Djacinto
> >6;h=3D6203e0dfe7cf89456517a1b877610f8ac2b4fd86;hb=3Drefs/heads/d-lol=
lipop-rele
> >ase
> >--=20
> >Regards,
> >Nishanth Menon
>=20
>=20

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
