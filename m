From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH v7 00/12] omap3: pm: TWL4030 power scripts and
	workaround for TWL errata 27
Date: Mon, 21 Feb 2011 13:57:09 +0200
Message-ID: <20110221115709.GJ11250@nokia.com>
References: <1298048938-1480-1-git-send-email-leslyam@ti.com> <AANLkTinTAVuK=CJaCgve4LQa-4jPhHf1ycUf-BhEz5i0@mail.gmail.com> <AANLkTi=O+ouOsgkOHKgPZuDEQO7Nu255dYZvUVyEVV6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:18680 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428Ab1BUL6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 06:58:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=O+ouOsgkOHKgPZuDEQO7Nu255dYZvUVyEVV6a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Manuel, Lesly Arackal" <leslyam@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Feb 21, 2011 at 12:25:01PM +0530, ext Manuel, Lesly Arackal wro=
te:
> Hi Jean,
>=20
> On Fri, Feb 18, 2011 at 10:57 PM, Jean Pihet <jean.pihet@newoldbits.c=
om> wrote:
> > On Fri, Feb 18, 2011 at 6:08 PM, Lesly A M <leslyam@ti.com> wrote:
> >> Patch series for TWL4030 power scripts and workaround for TWL erra=
ta 27.
> >>
> >> Changes for implementing TWL4030 power scripts recommended by hard=
ware team.
> >> Introduced a new TWL4030 power script file, which can be used by d=
ifferent
> >> OMAP3 board with the power companion chip TWL4030.
> >>
> >> Updated the changes for TWL4030 errata 27 & 28, modified the
> >> TWL4030 power script and voltage controller setuptime.
> >> Workaround for TWL4030 errata 27 & 28 is required for
> >> Si version less than or equal to TWL5030 ES1.1.
> >>
> >> TWL4030 script changes rebased on Kevin's PM tree in pm branch.
> >>
> >> Changes in v7:
> >> =A0 =A0 =A0 =A0changes to fix Nishanth Menon's comments
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) Added the TWL4030 Errata 27 fix
> >>
> >> =A0 =A0 =A0 =A0split the first patch in v6
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) =A0fix for twl4030 script load
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) correct the warning print durin=
g script loading
> >>
> >> =A0 =A0 =A0 =A0Added new patch files
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i) pmic_info struct cleanup
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ii) changing sys_off signal polarit=
y
> >>
> >> =A0 =A0 =A0 =A0Updated the change logs
> >>
> >> This changes are tested on OMAP3430 & OMAP3630 SDP with off mode e=
nabled in suspend path.
> >> =A0 =A0 =A0 =A0Tested with suspend/resume script, which will test =
system suspend in a loop.
> >> =A0 =A0 =A0 =A0Tested for more than 1000 iterations.
> >
> > Good to see the TWL scripts back in the mainline kernel!
> > Are the scripts compatible with the OMAP3 Beagleboard? I would like=
 to
> > test the changes on that board.
>=20
> I have not tested on Beagleboard.
> I think Beagleboard is using different PM IC TPSxxxx.
> If its equivalent to TRITON then this script should work on it.

As far as I know they are equivalent. I don't know if the errata need t=
o
be applied though. Maybe someone from TI can comment?

Cheers,

Peter.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
