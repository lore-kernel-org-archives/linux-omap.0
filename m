From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PULL] fixes for tidspbridge 2.6.37-rc1
Date: Tue, 9 Nov 2010 09:25:11 -0800
Message-ID: <20101109172511.GA10958@kroah.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
 <AANLkTikB0zhN13u5OtRwviOv-rFDW-vFTmq0t7ALuO7N@mail.gmail.com>
 <201011091729.17679.arnd@arndb.de>
 <20101109165509.GA9698@kroah.com>
 <AANLkTinFW431t9XFqHc=wZAws9gjT0ikrc03J83kH7iF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:37904 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab0KIRZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Nov 2010 12:25:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinFW431t9XFqHc=wZAws9gjT0ikrc03J83kH7iF@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Nov 09, 2010 at 11:04:18AM -0600, Guzman Lugo, Fernando wrote:
> On Tue, Nov 9, 2010 at 10:55 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 09, 2010 at 05:29:17PM +0100, Arnd Bergmann wrote:
> >> On Tuesday 09 November 2010, Felipe Contreras wrote:
> >> > Felipe Contreras (14):
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - update Kconfig to sel=
ect IOMMU module"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove dmm custom mod=
ule"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - deprecate reserve/unr=
eserve_memory funtions"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove reserved memor=
y clean up"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge: remove dw_dmmu_base fr=
om cfg_hostres struct"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - move all iommu relate=
d code to a new file"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove hw directory"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - fix mmufault support"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - remove custom mmu cod=
e from tiomap3430.c"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - rename bridge_brd_mem=
_map/unmap to a proper name"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge - move shared memory io=
mmu maps to tiomap3430.c"
> >> > =A0 =A0 =A0 Revert "staging: tidspbridge: replace iommu custom f=
or opensource implementation"
> >>
> >> That adds quite a lot of crap back in that was removed by Fernando=
 earlier:
> >>
> >> =A044 files changed, 3733 insertions(+), 847 deletions(-)
> >>
> >> It may have been premature to merge the patches as you say, but no=
w that
> >> they are in, I'd vote for giving Fernando a chance to fix up any d=
amage
> >> that was done in the process rather than just reverting all the us=
eful
> >> changes.
> >
> > In looking at this further, I agree.
> >
> > Felipe, are all of these really needing to be reverted? =A0How abou=
t
> > picking out the functional changes that need to be resolved instead=
 of
> > just rolling back everything that has been done here. =A0Surely not=
 all of
> > these are wrong, right?
>=20
> Patches are _NOT_ wrong, missing dependencies break the bridge.
> Without that dependencies the first patch of the set won't work and
> all other patches have dependency on the first one, so all of them
> need to be reverted.

How about hand-reverting only the wrong patch, so the other work isn't
lost?  I'd much prefer that.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
