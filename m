From: Tony Lindgren <tony@atomide.com>
Subject: Re: Commit 0c8219f0... breaks omap7xx support
Date: Mon, 31 May 2010 11:21:22 +0300
Message-ID: <20100531082122.GB30216@atomide.com>
References: <6cb013311003062056v3ed83a53u2636838348bf4845@mail.gmail.com>
 <20100309004832.GK2900@atomide.com>
 <6cb013311003081751u2c7cd8c6v59472ee85ac90e77@mail.gmail.com>
 <20100309024602.GQ2900@atomide.com>
 <6cb013311003081906n751bedb4k2794ed40ed68d7ec@mail.gmail.com>
 <20100309155636.GS2900@atomide.com>
 <6cb013311003091541k6a18c16bv4bb3d35f101e5bab@mail.gmail.com>
 <20100315182939.GV2900@atomide.com>
 <AANLkTini1wjhRXEfW4AjSdkVEYGpYXpuLcct-1l4pq0o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63703 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847Ab0EaIVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 04:21:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTini1wjhRXEfW4AjSdkVEYGpYXpuLcct-1l4pq0o@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, miknix@gmail.com, a.j.buxton@gmail.com, linwizard-devel@lists.sf.net

* Cory Maccarrone <darkstar6262@gmail.com> [100529 06:56]:
> On Mon, Mar 15, 2010 at 11:29 AM, Tony Lindgren <tony@atomide.com> wr=
ote:
> >
> > * Cory Maccarrone <darkstar6262@gmail.com> [100309 15:38]:
> > > On Tue, Mar 9, 2010 at 7:56 AM, Tony Lindgren <tony@atomide.com> =
wrote:
> > > >
> > > > Does your system boot without any patches if DEBUG_LL is not se=
t
> > > > in your .config?
> > >
> > > No, it doesn't. =C2=A0Seems like the debugging code is still tryi=
ng to run,
> > > even disabled. =C2=A0If I add in that check, it'll boot with DEBU=
G_LL not
> > > set, but won't without that.
> >
> > Sorry for the delay on this. How about with the following patch wit=
h
> > DEBUG_LL not set?
> >
> > Note that this is using the shift register now too.
> >
> > Regards,
> >
> > Tony
>=20
> Sorry I took so long on this one.  This patch worked beautifully for
> me on the latest kernel tree.  Any chance of it getting in for one of
> the RCs of this next kernel?

Yeah this we should be able to merge as a fix. Can I add your Testedy-b=
y
to the patch?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
