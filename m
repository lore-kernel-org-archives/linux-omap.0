From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 09:37:53 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781B71@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>,<1254234160.23991.1.camel@tubuntu>,<A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59233 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbZI2Ok2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 10:40:28 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio Alberto [saaguirre@ti.com]
Sent: Tuesday, September 29, 2009 9:34 AM
> From: Tomi Valkeinen [tomi.valkeinen@nokia.com]
> Sent: Tuesday, September 29, 2009 9:22 AM
> > On Tue, 2009-09-29 at 16:14 +0200, ext Aguirre Rodriguez, Sergio Alberto
> > wrote:
> > > From: Sergio Aguirre <saaguirre@ti.com>
> > >
> > > Acquiring mutex before framebuffer registration doesn't make sense,
> > > As there's no danger of external access to the memory related fields.
> >
> > What problem does this patch solve? It makes the code more complex.
> >
> 
> Tomi,
> 
> Thanks for your time.
> 
> The problem was that, during platform driver registration,
> this sequence was executed:
> 
> -> omapfb_probe
>    -> omapfb_do_probe
>       -> planes_init
>          -> fbinfo_init
>             -> set_fb_fix

Forgot to mark that the attempt to use the mutex its done here in set_fb_fix function

>       ...
>       -> register_framebuffer
> 
> And then, inside that function, an attempt of acquiring a
> mutex failed, because it wasn't initialized before trying it:
> 
> mutex_lock(&fbi->mm_lock);
> 
> It is actually initialized later in omapfb_do_probe in register_framebuffer call.
> 
> So, how is the best to solve this then?
> 
> BTW, this problem is found on current Linus tree, and in
> current l-o tree aswell, and i saw it on my 3430SDP VG5.0.1.

BTW #2. This makes framebuffer work on my board. I can see Tux during bootup,
and also i was able to run some basic framebuffer tests on my board without
apparent issues.
> 
> Regards,
> Sergio
> 
> >  Tomi
> >
