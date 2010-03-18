From: Imre Deak <imre.deak@nokia.com>
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
	regions
Date: Thu, 18 Mar 2010 10:52:39 +0200
Message-ID: <20100318085239.GE30422@localhost>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com> <20100317173407.GD30422@localhost> <20100317201425.GI18243@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23231 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab0CRIxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 04:53:24 -0400
Content-Disposition: inline
In-Reply-To: <20100317201425.GI18243@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 17, 2010 at 09:14:25PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> On Wed, Mar 17, 2010 at 06:34:07PM +0100, Deak Imre (Nokia-D/Helsinki) wrote:
> > Hi,
> > 
> > couple of minor comments inlined.
> > 
> > On Fri, Mar 05, 2010 at 02:26:19PM +0100, Syrjala Ville (Nokia-D/Helsinki) wrote:
> > [...]
> > > @@ -115,30 +184,57 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
> > >         struct omapfb_info *ofbi = FB2OFB(fbi);
> > >         struct omapfb2_device *fbdev = ofbi->fbdev;
> > >         struct omapfb2_mem_region *rg;
> > > -       int r, i;
> > > +       int r = 0;
> > >         size_t size;
> > > +       int i;
> > > 
> > >         if (mi->type > OMAPFB_MEMTYPE_MAX)
> > >                 return -EINVAL;
> > > 
> > >         size = PAGE_ALIGN(mi->size);
> > > 
> > > -       rg = &ofbi->region;
> > > +       rg = ofbi->region;
> > > 
> > > -       for (i = 0; i < ofbi->num_overlays; i++) {
> > > -               if (ofbi->overlays[i]->info.enabled)
> > > -                       return -EBUSY;
> > > +       /* FIXME probably should be a rwsem ... */
> > > +       mutex_lock(&rg->mtx);
> > > +       while (rg->ref) {
> > > +               mutex_unlock(&rg->mtx);
> > > +               schedule();
> > > +               mutex_lock(&rg->mtx);
> > > +       }
> > 
> > Yes, rwsem would mean no unnecessary scheduling and also make things
> > clearer.
> 
> Just tried it and seems to be mostly OK. We get lockdep checking as a
> bonus. It didn't like setup_plane taking the same rwsem twice so I
> added a check to see if the old and new regions are the same and just
> lock once in that case. I thought rwsem was supposed to be OK with
> read recursion but perhaps I was mitaken, or perhaps it's just lockdep
> that's misbehaving.

Ah ok, so it's not so obvious change. Nested read locks could really lead
to a deadlock I think. A read lock will block if there is a write waiter
in the queue to avoid write starvation..

--Imre

