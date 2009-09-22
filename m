From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Tue, 22 Sep 2009 14:36:17 -0700
Message-ID: <20090922213617.GD4919@atomide.com>
References: <20090918.125453.179950926.Hiroshi.DOYU@nokia.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD9914F9@dbde02.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD9916D7@dbde02.ent.ti.com> <20090918.175434.229727484.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62176 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbZIVVgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 17:36:16 -0400
Content-Disposition: inline
In-Reply-To: <20090918.175434.229727484.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: premi@ti.com, linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090918 07:54]:
> Hi Premi,
> 
> From: "ext Premi, Sanjeev" <premi@ti.com>
> Subject: RE: [PATCH] OMAP3: iovmm: fix compiler warning
> Date: Fri, 18 Sep 2009 16:40:29 +0200
> 
> [...]
> 
> > > > > @@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct 
> > > > sg_table *sgt, void *_va)
> > > > >  	}
> > > > >  
> > > > >  	va_end = _va + PAGE_SIZE * i;
> > > > > -	flush_cache_vmap(_va, va_end);
> > > > > +	flush_cache_vmap((unsigned long) _va, (unsigned long) va_end);
> > > > >  }
> > > > >  
> > > > >  static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
> > > > 
> > > > If no need for pointer, what about below?
> > > 
> > > I did not check for the usage of sgtable_drain_vmalloc().
> > > Yes. If the void* isn't MUST then, change below is fine.
> > > 
> > > ~sanjeev
> > 
> > On second look, the need for void* is driven backwards from:
> >      pg = vmalloc_to_page(va);
> > In function sgtable_fill_vmalloc().
> > 
> > Now we need a typecast from u32 to void*.
> > 
> > Shouldn't we go with the original patch itself?
> 
> Right, the original is better, then;)

Can you please specify which one (if any) should be queued?

Do you mean http://patchwork.kernel.org/patch/48467/

Tony
