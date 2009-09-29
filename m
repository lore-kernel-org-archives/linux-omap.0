From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 23:56:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436C4483D@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
	 ,<1254234160.23991.1.camel@tubuntu>
	 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>,<1254236004.23991.17.camel@tubuntu>
 <A24693684029E5489D1D202277BE89444B781B72@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47320 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbZI2S0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 14:26:34 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B72@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio
> Alberto
> Sent: Tuesday, September 29, 2009 8:27 PM
> To: tomi.valkeinen@nokia.com
> Cc: Deak Imre (Nokia-D/Helsinki); linux-omap@vger.kernel.org
> Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
> 
> From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
> Sent: Tuesday, September 29, 2009 9:53 AM
> > On Tue, 2009-09-29 at 16:34 +0200, ext Aguirre Rodriguez, Sergio
> Alberto
> > wrote:
> > > From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
> > > Sent: Tuesday, September 29, 2009 9:22 AM
> > > > On Tue, 2009-09-29 at 16:14 +0200, ext Aguirre Rodriguez,
> Sergio Alberto
> > > > wrote:
> > > > > From: Sergio Aguirre <saaguirre@ti.com>
> > > > >
> > > > > Acquiring mutex before framebuffer registration doesn't make
> sense,
> > > > > As there's no danger of external access to the memory
> related fields.
> > > >
> > > > What problem does this patch solve? It makes the code more
> complex.
> > > >
> > >
> > > Tomi,
> > >
> > > Thanks for your time.
> > >
> > > The problem was that, during platform driver registration,
> > > this sequence was executed:
> > >
> > > -> omapfb_probe
> > >    -> omapfb_do_probe
> > >       -> planes_init
> > >          -> fbinfo_init
> > >             -> set_fb_fix
> > >       ...
> > >       -> register_framebuffer
> > >
> > > And then, inside that function, an attempt of acquiring a
> > > mutex failed, because it wasn't initialized before trying it:
> > >
> > > mutex_lock(&fbi->mm_lock);
> > >
> > > It is actually initialized later in omapfb_do_probe in
> register_framebuffer call.
> > >
> > > So, how is the best to solve this then?
> >
> > Oh, I wasn't implying that there's something wrong with the fix, I
> just
> > didn't know what it was fixing =).
> 
> Ok, no prob :) Should I improve the patch description?
> Any suggestion coming from an expert ;) ?
> 
> >
> > Looks like a valid fix to me.
> 
> Great! :) Once you're ok with the description, I can add your
> "Acked-by:" and
> send to linux-fb-devel ML. Would that be ok?
> 
[Hiremath, Vaibhav] Hi Sergio,

I also think this is valid fix.

Tomi,

Don't you think we should also make use of mm_lock in new OMAP2 Fbdev driver, to be more specific and safer side?

Thanks,
Vaibhav

> Regards,
> Sergio
> 
> >
> >  Tomi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

