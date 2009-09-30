From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Wed, 30 Sep 2009 11:35:32 +0300
Message-ID: <1254299732.23991.57.camel@tubuntu>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
	 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
	 <1254236004.23991.17.camel@tubuntu>  <20090930005310.GI16865@atomide.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51346 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZI3Ifr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 04:35:47 -0400
In-Reply-To: <20090930005310.GI16865@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-09-30 at 02:53 +0200, ext Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [090929 07:54]:
> > On Tue, 2009-09-29 at 16:34 +0200, ext Aguirre Rodriguez, Sergio Alberto
> > wrote:
> > > From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
> > > Sent: Tuesday, September 29, 2009 9:22 AM
> > > > On Tue, 2009-09-29 at 16:14 +0200, ext Aguirre Rodriguez, Sergio Alberto
> > > > wrote:
> > > > > From: Sergio Aguirre <saaguirre@ti.com>
> > > > >
> > > > > Acquiring mutex before framebuffer registration doesn't make sense,
> > > > > As there's no danger of external access to the memory related fields.
> > > > 
> > > > What problem does this patch solve? It makes the code more complex.
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
> > > It is actually initialized later in omapfb_do_probe in register_framebuffer call.
> > > 
> > > So, how is the best to solve this then?
> > 
> > Oh, I wasn't implying that there's something wrong with the fix, I just
> > didn't know what it was fixing =).
> > 
> > Looks like a valid fix to me.
> 
> Tomi & Imre, do you want me to add this to the omap-fixes queue,
> or are you planning to send other fixes too?
> 
> If you want me to add it, please reply with your ack.
> 
> I'll added it into omap-fixes-testing branch for now so we can
> get the omaps booted.

I don't know if Imre wants to handle this (probably not =), but I would
rather concentrate on DSS2 patches. I have enough of them already, and
my progress in upstreaming them seems to be... slow... =).

So if you can take any minor old-omapfb patches to omap-fixes queue,
it'd be great.

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tomi


