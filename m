From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: Fix incorrect 730 vs 850 detection, v2 (Re: Patch
	missing in 2.6.32-rc1)
Date: Wed, 30 Sep 2009 18:53:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDB70CF4@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com>
 <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com>
 <20090819131752.GC7629@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3F19@dbde02.ent.ti.com>
 <20090929203525.GF16865@atomide.com>
 <3d374d00909291652m3f52fbf6y1ea45ac7bec99018@mail.gmail.com>
 <20090930003218.GH16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbZI3NXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 09:23:23 -0400
In-Reply-To: <20090930003218.GH16865@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alistair Buxton <a.j.buxton@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]=20
> Sent: Wednesday, September 30, 2009 6:02 AM
> To: Alistair Buxton
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: [PATCH] omap: Fix incorrect 730 vs 850 detection, v2=20
> (Re: Patch missing in 2.6.32-rc1)
>=20
> * Alistair Buxton <a.j.buxton@gmail.com> [090929 16:52]:
> > 2009/9/29 Tony Lindgren <tony@atomide.com>:
> > > * Premi, Sanjeev <premi@ti.com> [090929 04:34]:
> > >> Hi Tony,
> > >>
> > >> Can you push this patch to 2.6.32-rc1?
> > >>
> > >> 7a8d53a0: =A0arch: arm: omap: terminate ifndef
> > >>
> > >> I was unable to refresh my patches against this baseline.
> > >> OR, is it okay if I re-submit against the 'master'.
> > >
> > > Sorry, I was meaning to look where the mismatch really came
> > > from but forgot.
> > >
> > > Looks like adding omap850 support added an #else without removing
> > > the #endif above it, and also removed another #endif in commit
> > > ae302f40061235f6bc58ae9ba02aa849d60223b5.
> >=20
> > The #else immediately after the removed #endif needs to go as well,
> > because the block that the #endif(s) belongs to already has=20
> an #else.
> >=20
> > That means the bug not only caused everything after the extra #endi=
f
> > to have no multiple inclusion protection (causing the=20
> redefinitions),
> > but the extra #else also caused cpu_is_omap850() to be true=20
> only when
> > cpu.h was included twice.
>=20
> Ah, right! So we're back to http://patchwork.kernel.org/patch/42292/
> and we also need to add back the missing #endif to the end of file
> file.
>=20
> Here's an updated version of 42292, hopefully this will do the trick.

[sp] Tested working fine for me.

>=20
> Regards,
>=20
> Tony
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
