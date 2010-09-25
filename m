From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 2/2] OMAP2+: GPIO: move late PM out of
 interrupts-disabled idle path
Date: Sat, 25 Sep 2010 09:00:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930233C35B07@dbde02.ent.ti.com>
References: <1284418958-5887-1-git-send-email-khilman@deeprootsystems.com>
	<1284418958-5887-3-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6DF51AF@dbde02.ent.ti.com>
	<87d3sgs1nw.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE85CD@dbde02.ent.ti.com>
	<87mxr84gip.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F6FE8768@dbde02.ent.ti.com>
	<87y6asqc9u.fsf@deeprootsystems.com> <87wrqcnhk1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52979 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab0IYDad convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 23:30:33 -0400
In-Reply-To: <87wrqcnhk1.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, Tero Kristo <tero.kristo@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, September 24, 2010 5:23 AM
> To: Basak, Partha
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; Tero 
> Kristo; Cousson, Benoit
> Subject: Re: [PATCH 2/2] OMAP2+: GPIO: move late PM out of 
> interrupts-disabled idle path
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> [...]
> 
> >>
> >> We cannot do a get_sync() from ISR context, right?
> >
> > Right, but we *should* be able to.  ;)
> >
> > I'm still trying to craft a good description of this 
> problem so I can
> > argue better for it on linux-pm.
> >
> > Until then...
> >
> > A bit of a hack, but you could do a _get_noresume() (which 
> is safe from
> > interrupt context) and directly call the drivers ->runtime_resume()
> > method, which would be the equivalent of a _get_sync().  Followed of
> > course by a _put() (async version, also interrupt safe) at 
> the end of
> > the ISR to keep the usecount correct.
> 
> You probably figured this out already, but I just realized that this
> won't currently work either as omap_hwmod is using mutexes, and is 
> safe in ISR context either. :(
> 
> What about for now just directly enabling (and re-disabling) the hwmod
> clocks in the ISR using omap_hwmod_[enable|disable]_clocks()
> 
> Since this is a core driver in arch/arm/*omap*, you can directly call
> the omap_hwmod API.
> 

omap_hwmod_[enable/disable]_clocks() use mutex inside & therefore cannot
be used in the ISR context

We cannot readily use the _enable_clocks/_disble_clocks directly as they are
static APIs.

But we can use the non-mutex versions, of omap_hwmod_enable/idle.
(_omap_hwmod_enable/_omap_hwmod_disable)

Do you agree?


> Kevin
> 
> 