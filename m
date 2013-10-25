From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 4/5] mtd: nand: omap2: Use devm_kzalloc
Date: Fri, 25 Oct 2013 08:19:07 -0300
Message-ID: <20131025111906.GC2489@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382696277-9063-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AD60@DBDE04.ent.ti.com>
 <20131025104246.GA2489@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE0F@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54516 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751466Ab3JYLTS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:19:18 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2AE0F@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Oct 25, 2013 at 11:09:14AM +0000, Gupta, Pekon wrote:
> > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> >=20
> > Hm.. well the problem with that patch is that it's in the middle of=
 an
> > unrelated series. As I already told you, I think you should have pu=
shed
> > that as a one-patch fix. Have you seen that suggestion?
> >=20
> Yes, I know.. actually the original patch series, when it started som=
ewhere
> April (or before) is very different from the version v11 now :-).
> This devm_ update was added in middle of v6-v7 version change
> (Most of the changes since first version of this patchset is captured=
 in=20
> Cover-letter).
>=20
>=20

Well, in order to *avoid* having a patchset flowing for 5 months and 11
revisions you coudl try to keep series small. You could have that singl=
e
fix merged if you send it alone. Not sure why you insist in *not* doing
that.

> > On the other side, you're fixing too many things in that single pat=
ch,
> > for my taste. Maybe I'm not the smarter developer, but going throug=
h
> > that patch is not easy to catch if there's no mistake done.
> >=20
> > Usually if it's possible to split a patch (maintaining consistency)=
 it makes
> > the reviewing process easier.
> > If you'd rather send this devm_xxx change yourself that's fine by m=
e,
> >=20
> Ahh nothing like that.. Brian had already reviewed these couple of ti=
mes

Ah, good. In that case you should add "Reviewed-by" if Brian already
reviewed it. IMHO, the patch could be cleaner and the commit message
could be better.

> And it was only [Patch 04/10] which was last one remaining..

Yes, and because you added *another* patch to the series you keep
spinning patchset versions.

> I just said it because this might show up in merge conflict .. or rej=
ects..
>=20
> > but *please* split the patch in two and write proper commit message=
s.
> >=20
> > Anyway: this is just a silly change, the important one is the other
> > nand_scan_ident() fix. Could you help me review that?
> >=20
> > I'm interested in knowing how will that work with 8-bit and 16-bit =
devices.
> > --
> Yes, I'm just preparing the scenario where BUSWIDTH_AUTO would fail..
> unless you do GPMC driver changes also.. same issue was found by
> Matthieu CASTET (matthieu.castet@parrot.com)
> (please see my other mail)
>=20

OK, let's try to focus in that patch alone, I'd like to move forward.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
