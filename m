From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Date: Fri, 7 Dec 2012 16:45:02 +0200
Message-ID: <20121207144502.GG32230@intel.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com>
 <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
 <20121207125350.GE32230@intel.com>
 <50C1F232.80508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18593 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965002Ab2LGOpH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Dec 2012 09:45:07 -0500
Content-Disposition: inline
In-Reply-To: <50C1F232.80508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Dec 07, 2012 at 03:42:10PM +0200, Tomi Valkeinen wrote:
> On 2012-12-07 14:53, Ville Syrj=E4l=E4 wrote:
> > On Fri, Dec 07, 2012 at 01:55:06PM +0200, Tomi Valkeinen wrote:
> >> Kernel lock verification code has lately detected possible circula=
r
> >> locking in omapfb. The exact problem is unclear, but omapfb's curr=
ent
> >> locking seems to be overly complex.
> >>
> >> This patch simplifies the locking in the following ways:
> >>
> >> - Remove explicit omapfb mem region locking. I couldn't figure out=
 the
> >>   need for this, as long as we take care to take omapfb lock.
> >=20
> > I suppose the idea with that was that you wouldn't need the global
> > omapfb lock, and also it was an rwsem so it allowed parallel access=
 to
> > the mem regions, unless the region size was being changed, in which
> > case it took the write lock. I can't really remember what the reaso=
n
> > for using an rwsem was, but I suppose there was one at the time.
>=20
> Right. Yes, I have no recollection either of the possible reason for =
it
> =3D). Did we have multiple concurrerent users for the fbs? It still s=
ounds
> like a useless optimization, as all the region locks were only held f=
or
> a short time, as far as I saw.
>=20
> It could also be that we're missing something from the mainline kerne=
l,
> which we had in the Nokia kernel, and which would explain the need fo=
r
> region locks.

Yeah, perhaps there was some use for it at the time. Possibly the
zero copy video playback benefited from it in the beginning. But
IIRC almost everything was handled via the X server in the end,
so I don't think there's any compelling reason for keeping the
rwsem.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
