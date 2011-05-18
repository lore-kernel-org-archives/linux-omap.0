From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 14:30:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDC82C@dbde02.ent.ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
 <BANLkTinxvCNdr7qQTWjRZ2KceSvanGQ0Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56535 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab1ERJA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 05:00:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I90OrE023060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:00:27 -0500
In-Reply-To: <BANLkTinxvCNdr7qQTWjRZ2KceSvanGQ0Sg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth=20
> Sent: Wednesday, May 18, 2011 1:55 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with=20
> debugfs disabled
>=20
> On Thu, May 12, 2011 at 14:16, Premi, Sanjeev <premi@ti.com> wrote:
> [...]
> >> > This patch fixes these errors by enclosing code related=20
> to debugfs
> >> > in #ifdef CONFIG_DEBUG_FS..#endif.
> >>
> >> generic - couple of comments - I think the #defs should be isolate=
d
> >> off to headers - maybe the right approach may be to move=20
> the debugfs
> >
> > [sp] None of the code encapsulated here is "header" material.
> > =A0 =A0 I guess you have seen the patch below.
> >
> >> entries off to a separate file? or pm-debug.c??
> >
> > [sp] I wish it was all debug code. It is "operational" code.
> > =A0 =A0 Check the Kconfig in plat-omap. Smartreflex is not even exp=
ected
> > =A0 =A0 to work without debugfs. Though I believe much of the=20
> data put in
> > =A0 =A0 debugfs can be in local lists/structures.
> >
> > =A0 =A0 That was supposed to be my next set of patches - as I under=
stand
> > =A0 =A0 the implementation better.
> [...]
> >> Could I suggest Kevin's volt cleanup series - based off _c=20
> branch if
> >> there are cleanups to be done?
> >
> > [sp] I didn't see it updated for 5 weeks. hence used this.
> > =A0 =A0 but patch should apply cleanly...
>=20
>=20
> While cleaning up voltdm_c set earlier this week, I think your change=
s
> apply better there.
> btw, I could incorporate a bit of your code into my patch, esp the on=
e
> Tony commented on http://marc.info/?l=3Dlinux-omap&m=3D13057055951597=
7&w=3D2
> but, overall, on the topic of SR, either:
> a)  move SR autocomp into sysfs (and dump the rest of the debugfs - i=
t
> is useful for validation, but does'nt really provide additional info)
> - given that it used to reside in /sys/power/sr_vddx_autocomp and the=
n
> moved to debugfs, I am not sure if this is the right path
> b) move SR autocomp into a board defined configuration.. more
> intrusive, but folks would really want to enable SR as an option at
> times from userspace - many distros and devices do this (e.g. N900)..

[sp] I am not sure what you are suggesting. Can't we take in the patch =
and
     then do the movements? ... the ones that doesn't seem to be implem=
ented
     so far (based on your comments).

~sanjeev

>=20
> Regards,
> Nishanth Menon
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
