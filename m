From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Fri, 20 May 2011 20:51:28 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09AD0D@dbde02.ent.ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <87fwocrmr9.fsf@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CFDCEE1@dbde02.ent.ti.com>
 <BANLkTi=9hP2Hve-DfeM8QR-D5qvcn3omgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39407 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933888Ab1ETPVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 11:21:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4KFLXZq031926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 10:21:35 -0500
In-Reply-To: <BANLkTi=9hP2Hve-DfeM8QR-D5qvcn3omgg@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth=20
> Sent: Thursday, May 19, 2011 7:28 PM
> To: Premi, Sanjeev
> Cc: Hilman, Kevin; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with=20
> debugfs disabled
>=20
> On Thu, May 19, 2011 at 05:30, Premi, Sanjeev <premi@ti.com> wrote:
> >> -----Original Message-----
> >> From: Hilman, Kevin
> >> Sent: Wednesday, May 18, 2011 10:04 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with
> >> debugfs disabled
> >>
> >> Hi Sanjeev,
> >>
> >> Sanjeev Premi <premi@ti.com> writes:
> >>
> >> > There is an implicit assumption in current implementation that
> >> > debugfs is always enabled.
> >> >
> >> > When debugfs is disabled, these errors are noticed during boot:
> >> > =A0 omap_voltage_late_init: Unable to create voltage=20
> debugfs main dir
> >> > =A0 vdd_debugfs_init: Unable to create debugfs directory=20
> for vdd_mpu
> >> > =A0 vdd_debugfs_init: Unable to create debugfs directory=20
> for vdd_core
> >> >
> >> > This patch fixes these errors by enclosing code related=20
> to debugfs
> >> > in #ifdef CONFIG_DEBUG_FS..#endif.
> >> >
> >> > Boot tested on OMAP3EVM.
> >> >
> >> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> >>
> >> Sorry for the delay here, I've been on the road and finally
> >> catching up
> >> on the list.
> >>
> >> Basically, I'm in the process of a pretty major cleanup of
> >> the VC/VP and
> >> SR layers. =A0For example, in my pm-wip/voltdm_* branches,=20
> the debugfs
> >> interface to the voltage layer has been completely=20
> removed. =A0I'm also
> >> thinking of removing the SR debugfs interface also, as I=20
> don't really
> >> think we need a userspace interface for this. =A0A=20
> board-level interface
> >> is probably enough (/me waits for flame from Nishanth :)
> >>
> >> That being said, your approach below isn't quite right in=20
> its usage of
> >> #ifdefs. =A0Use of #ifdefs like this is frowned upon for=20
> many reasons.
> >> For starters, take a look the '#ifdefs are ugly' section of
> >> Documentation/SubmittingPatches.
> >
> > [sp] I don't like #ifdefs either but each time we cannot create
> > =A0 =A0 a new file changes like this.
> >
> > =A0 =A0 The current code is a mess with debugfs used too frequently=
=2E
> > =A0 =A0 And - all of it is not for debug. The location of ifdefs in
> > =A0 =A0 in the patch illustrates it quite well.
> >
> > =A0 =A0 BTW, this isn't the only use of ifdefs in a C file in Linux=
=2E
> in reality the only reason you've had to do this patch was because we
> had a wicked handling of debugfs entries in voltage layer - with
> voltdm_c these are all gone. further any entries remaining (e.g. SR)
> are:
> dentry for debugfs file -> just a minor overhead not=20
> deserving a #ifdef
> all other functions of debugfs (as per include/linux/debugfs.h) when
> debugfs is disabled in .config will be static inlined and we will not
> need any #ifdefs at all
>=20
> The real pending question is about functional SR debugfs entries that
> need to loose it's critical functionality.

[sp] good argument for future not the present and past. Fact is that
     "wicked handling of debugfs entries" made their way.

     I am not worried about the patch in or out - few folks who were
     stuck on the issue would have used it anyway. But, whether each
     fix for today can be postponed for future restructuring.

     #ifdefs were just easy target for the postponement.

~sanjeev

> Regards,
> Nishanth Menon
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
