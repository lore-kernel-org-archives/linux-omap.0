From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] tidspbridge: remove revision history
Date: Tue, 17 Mar 2009 08:32:09 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E233202C9@dlee03.ent.ti.com>
References: <1237241138-4516-1-git-send-email-felipe.contreras@gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A499A@dlee02.ent.ti.com>
	 <94a0d4530903170216x4253ee07r6fdfb38cfccce78d@mail.gmail.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A49BC@dlee02.ent.ti.com>
 <94a0d4530903170320g7fc8eef5t4b8da6ab7e768a56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37625 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbZCQNcY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 09:32:24 -0400
In-Reply-To: <94a0d4530903170320g7fc8eef5t4b8da6ab7e768a56@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

> > Note: There are folks whose contributions are reduced to=20
> "vp" "rr" "sp" etc.. I personally have no clue who they are=20
> but I guess they would rather be in git log than in anonymous=20
> initials if given a choice today..

-- You and me might not know who "vp", "rr", and "sb" are :), but these=
 guys know who they are and it is upto them as how they want to refer t=
hemselves. I think it is a disregard to these developers who might have=
 worked over the years on Bridge if we just remove their names complete=
ly.

> Contributors can be specified as such: a contributors section=20
> at the top. No need to keep the revision history just for that.

-- This looks like the way to go.

Thank you,
Best regards,
Hari
=20

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
> Sent: Tuesday, March 17, 2009 5:21 AM
> To: Menon, Nishanth
> Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Hiroshi DOYU;=20
> Ameya Palande; Guzman Lugo, Fernando
> Subject: Re: [PATCH] tidspbridge: remove revision history
>=20
> On Tue, Mar 17, 2009 at 11:40 AM, Menon, Nishanth <nm@ti.com> wrote:
> > Hi Felipe,
> >> -----Original Message-----
> >> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> >> Sent: Tuesday, March 17, 2009 11:17 AM
> >> To: Menon, Nishanth
> >> Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Hiroshi=20
> DOYU; Ameya=20
> >> Palande; Guzman Lugo, Fernando
> >> Subject: Re: [PATCH] tidspbridge: remove revision history
> >>
> >> >> - *! Revision History:
> >> >> - *! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> - *! 24-Feb-2003 vp: Code Review Updates.
> >> >> - *! 18-Oct-2002 sb: Ported to Linux platform.
> >> >> - *! 03-Jul-2001 rr: Removed kfuncs.h because of build errors.
> >> >> - *! 07-Dec-1999 ag: Fxn error now causes a WinCE DebugBreak;
> >> >> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
> >> >> - *!
> >> > But we did not have git history 1999-2003. we planning=20
> on loosing=20
> >> > these
> >> contribs?
> >>
> >> Only if you want dspbridge to be merged which as time passes it's=20
> >> becoming more clear that you don't. I'm not a kernel=20
> developer, but I
> > Errr.. Not my attempt at a flame war ;).. But then, I am=20
> not sure if my comment meant anything of the sort :)...
>=20
> Contrary to what it might seem I'm not attempting a flame war either.
>=20
> It's not because of your comment, it's because TI has been=20
> very slow cleaning up the driver and reluctant of integrating=20
> clean-up patches.
>=20
> It seems to me as if TI thinks this driver is just fine,=20
> which is clearly not the case.
>=20
> >> would challenge you to find a diver that has 1000 lines of=20
> revision=20
> >> history in the source code.
> > <snip>
> >>
> >> >> - *! 30-Aug-1999 ag: Now uses GP_printf for printf and error.
> >>
> >> Not printk? I assume this is not related to Linux then.
> >>
> >>
> >> Are we going to find an issue at some point in time that=20
> we'll say:=20
> >> oh crap! if only we had the revision history log we could solve it=
!
> > Errr... in the old times of cvs kernel, before we shifted=20
> to bitkeeper and later to git, rev history was unfortunately=20
> necessary to maintain some sort of acknowledgement of=20
> contributions. Just greping linux-omap master branch " grep=20
> -Ri "Revision History" drivers/|cut -d ":" -f1|wc -l" shows=20
> me 227 files of similar drivers- legacy =A0- agreed. I think=20
> bridge is in such a legacy driver.
>=20
> That shows me 31 files, none of which have more than a couple=20
> hundred lines, that is of course on linux mainline.
>=20
> BTW this is faster:
> git grep -i -l "Revision History" -- drivers/ | wc -l
>=20
> > If any new changes are done, it makes no sense to introduce=20
> an entry in the revision history - agreed. These driver files=20
> have a history and folks have done some work to make it=20
> useful, to remove their contributions would be, IMHO, our=20
> disregard for what ever they did (good or bad).. ;) But then,=20
> that is just my opinion..
> >
> > Note: There are folks whose contributions are reduced to=20
> "vp" "rr" "sp" etc.. I personally have no clue who they are=20
> but I guess they would rather be in git log than in anonymous=20
> initials if given a choice today..
>=20
> Contributors can be specified as such: a contributors section=20
> at the top. No need to keep the revision history just for that.
>=20
> >> I doubt that, the revision history is useless without the actual=20
> >> changes. These lines are just introducing noise.
> >>
> >
> > DSPBridge has definitely a long way to go before being=20
> merged into mainline kernel. Coding standard is one part of=20
> the story. Is this part of a code cleanup effort to prep the=20
> code for merge to kernel? I think I have seen tons of=20
> discussion on this previously.. If we are planning on=20
> prepping this driver for mainline integration that is another=20
> discussion and this patch probably is a tiny fragment to=20
> that. The bunch of history starts at [1] though..
>=20
> I'm interested on getting this into the mainline so I took=20
> the simplest of my cleanup patches and the one I thought=20
> would be less controversial.
>=20
> If TI does not intend to submit this to mainline it would be=20
> nice to say so, that way the people interested can stop=20
> waiting and take action.
>=20
> I myself am tired of waiting.
>=20
> --
> Felipe Contreras
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
