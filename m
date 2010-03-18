From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@Nokia.com>
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
 regions
Date: Thu, 18 Mar 2010 17:26:04 +0200
Message-ID: <20100318152604.GM18243@nokia.com>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
 <20100317173407.GD30422@localhost>
 <20100317201425.GI18243@nokia.com>
 <20100318085239.GE30422@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:47192 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0CRP0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 11:26:13 -0400
Content-Disposition: inline
In-Reply-To: <20100318085239.GE30422@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@Nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@Nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Mar 18, 2010 at 09:52:39AM +0100, Deak Imre (Nokia-D/Helsinki) =
wrote:
> On Wed, Mar 17, 2010 at 09:14:25PM +0100, Syrjala Ville (Nokia-D/Hels=
inki) wrote:
> > On Wed, Mar 17, 2010 at 06:34:07PM +0100, Deak Imre (Nokia-D/Helsin=
ki) wrote:
> > > Hi,
> > >=20
> > > couple of minor comments inlined.
> > >=20
> > > On Fri, Mar 05, 2010 at 02:26:19PM +0100, Syrjala Ville (Nokia-D/=
Helsinki) wrote:
> > > [...]
> > > > @@ -115,30 +184,57 @@ static int omapfb_setup_mem(struct fb_inf=
o *fbi, struct omapfb_mem_info *mi)
> > > >         struct omapfb_info *ofbi =3D FB2OFB(fbi);
> > > >         struct omapfb2_device *fbdev =3D ofbi->fbdev;
> > > >         struct omapfb2_mem_region *rg;
> > > > -       int r, i;
> > > > +       int r =3D 0;
> > > >         size_t size;
> > > > +       int i;
> > > >=20
> > > >         if (mi->type > OMAPFB_MEMTYPE_MAX)
> > > >                 return -EINVAL;
> > > >=20
> > > >         size =3D PAGE_ALIGN(mi->size);
> > > >=20
> > > > -       rg =3D &ofbi->region;
> > > > +       rg =3D ofbi->region;
> > > >=20
> > > > -       for (i =3D 0; i < ofbi->num_overlays; i++) {
> > > > -               if (ofbi->overlays[i]->info.enabled)
> > > > -                       return -EBUSY;
> > > > +       /* FIXME probably should be a rwsem ... */
> > > > +       mutex_lock(&rg->mtx);
> > > > +       while (rg->ref) {
> > > > +               mutex_unlock(&rg->mtx);
> > > > +               schedule();
> > > > +               mutex_lock(&rg->mtx);
> > > > +       }
> > >=20
> > > Yes, rwsem would mean no unnecessary scheduling and also make thi=
ngs
> > > clearer.
> >=20
> > Just tried it and seems to be mostly OK. We get lockdep checking as=
 a
> > bonus. It didn't like setup_plane taking the same rwsem twice so I
> > added a check to see if the old and new regions are the same and ju=
st
> > lock once in that case. I thought rwsem was supposed to be OK with
> > read recursion but perhaps I was mitaken, or perhaps it's just lock=
dep
> > that's misbehaving.
>=20
> Ah ok, so it's not so obvious change. Nested read locks could really =
lead
> to a deadlock I think. A read lock will block if there is a write wai=
ter
> in the queue to avoid write starvation..

Yes but I think in out case it should be fine because if we hit this:

 t  thread 1     thread 2
 |
 |  down_read(0)
 |               down_write(1)
 v  down_read(1)

then thread 2 will eventually do a up_write() without taking any
other region rwsem, and thread 1 can then continue.

The other locks we have to worry about are the fb_info mutex which
should always be taken before any region lock, and mmap_sem which in
mmap() is taken before the region lock. I'm hoping there are no
mmap_sem users lurking in the driver that already hold the region
rwsem.

--=20
Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
