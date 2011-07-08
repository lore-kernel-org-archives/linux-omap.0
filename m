From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
Date: Fri, 8 Jul 2011 00:39:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com> <4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-946255418-1310106841=:24181"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41887 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab1GHGjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 02:39:13 -0400
In-Reply-To: <20110707055549.GC15815@atomide.com>
Content-ID: <alpine.DEB.2.00.1107080034240.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-946255418-1310106841=:24181
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1107080034241.24181@utopia.booyaka.com>

On Thu, 7 Jul 2011, Tony Lindgren wrote:

> * Rajendra Nayak <rnayak@ti.com> [110706 22:26]:
> > On 7/6/2011 12:19 AM, Paul Walmsley wrote:
> > >
> > >Patch 16, to me, belongs best with the 4460 support series and so I'll=
 see
> > >if it makes sense to fit it in there somewhere.
> >=20
> > Paul,
> >=20
> > Do you want me to base the 4460 support series on one of your branches
> > and re-post including the above patch?
>=20
> Do we really need to do that patching right now to add base 4460 support?
>=20
> If we're just doing a bunch of renames all over the place to add support
> for a new processor variant, something is wrong. This is exactly the kind
> of "crazy churn" Linus was complaining about. In this case the crazy chur=
n
> is "let's rename 4430 to 44XX all over the place".
>=20
> To me it's sane to assume that we can have most of 4430 features on 4460
> and don't need to rename 4430 to 44XX for that. Adding 4460 should be
> just add few new 4460 defines, then do an arch_initcall to fixup things
> between 4430 and 4460.
>=20
> It would be nice to get the base 4460 support merged as the patches look
> ready to go otherwise. Rajendra, I suggest you take a quick look and see
> if you can leave out the dependency to the 4430 to 44XX rename patch to
> add minimal 4460 support. Then we can patch in the missing features later
> on, most likely we don't even need the arch_initcall fixup initially eith=
er.
>=20
> This would also leave out the dependency between the various patch
> series which will always lead into issues with merging code. Changes to
> the infrastructure issues like this should have been patched away early.
> The merge window is about to start and we're still waiting for the
> dependencies to get sorted out.

Rajendra's patch series doesn't require the 4430 -> 44XX changes in the=20
PRM/CM macros (Beno=EEt's patch 16).  That patch can be put in a separate=
=20
series, if you like. =20

It does require changing CHIP_IS_OMAP4430 to CHIP_IS_OMAP44XX in the=20
powerdomains, clockdomains, etc.  To me, that seems reasonable since the=20
4460 isn't simply a die shrink, it has some other changes on it; but I=20
guess you have a different view on that.

I will add acks/reviewed-by:s on the 4460 patches, and maybe you can=20
decide which ones you'd like to merge, if any.


- Paul
--155748971-946255418-1310106841=:24181--
