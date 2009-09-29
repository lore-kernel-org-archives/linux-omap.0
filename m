From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [RFC][PATCH] omapfb: Condition mutex acquisition
Date: Tue, 29 Sep 2009 17:53:24 +0300
Message-ID: <1254236004.23991.17.camel@tubuntu>
References: <A24693684029E5489D1D202277BE89444B781B6F@dlee02.ent.ti.com>
	 ,<1254234160.23991.1.camel@tubuntu>
	 <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40109 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZI2Oxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 10:53:32 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444B781B70@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2009-09-29 at 16:34 +0200, ext Aguirre Rodriguez, Sergio Alberto
wrote:
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

Oh, I wasn't implying that there's something wrong with the fix, I just
didn't know what it was fixing =).

Looks like a valid fix to me.

 Tomi


