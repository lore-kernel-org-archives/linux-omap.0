From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add
 required debugfs interfaces
Date: Wed, 18 May 2011 11:34:34 +0300
Message-ID: <20110518083434.GE6815@atomide.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
 <1305695854-9638-3-git-send-email-nm@ti.com>
 <20110518075948.GD6815@atomide.com>
 <BANLkTinH8Rs8Tn8A8gf++UuM2zAxd1e54Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61718 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755502Ab1ERIej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 04:34:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinH8Rs8Tn8A8gf++UuM2zAxd1e54Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: kevin <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Menon, Nishanth <nm@ti.com> [110518 11:03]:
> On Wed, May 18, 2011 at 02:59, Tony Lindgren <tony@atomide.com> wrote=
:
> > * Nishanth Menon <nm@ti.com> [110518 08:13]:
> >> Kevin's patch:
> >> OMAP3+: voltage: remove unneeded debugfs interface
> >>
> >> removed ability to check the voltages in the domains.
> >> This puts a crunch on validation we can do, hence we
> >> re-introduce them back in
> >
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> ---
> >> =C2=A0arch/arm/mach-omap2/voltage.c | =C2=A0 66 ++++++++++++++++++=
+++++++++++++++++++++++
> >> =C2=A0arch/arm/mach-omap2/voltage.h | =C2=A0 =C2=A01 +
> >> =C2=A02 files changed, 67 insertions(+), 0 deletions(-)
> >
> > Hmm, this seems to be adding the debug code instead?
>=20
> Yes, we need some interface to know what the current voltages are for
> each of the domain when verifying if dvfs is actually scaling voltage
> or not. the other option is to use omapconf (not yet public and only
> supports OMAP4) to see what the voltages are. Though omapconf is an
> option, it shows what it's computation of voltage from vsel is, not
> what the kernel internally thinks (vsel_uv functions) it is.

I guess I just got confused reading the patch description..

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
