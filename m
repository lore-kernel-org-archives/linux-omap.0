From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 17:54:34 +0300 (EEST)
Message-ID: <20090918.175434.229727484.Hiroshi.DOYU@nokia.com>
References: <20090918.125453.179950926.Hiroshi.DOYU@nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD9914F9@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD9916D7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20325 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZIROyq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Sep 2009 10:54:46 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD9916D7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: premi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Premi,

From: "ext Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3: iovmm: fix compiler warning
Date: Fri, 18 Sep 2009 16:40:29 +0200

[...]

> > > > @@ -390,7 +391,7 @@ static void sgtable_fill_vmalloc(struct 
> > > sg_table *sgt, void *_va)
> > > >  	}
> > > >  
> > > >  	va_end = _va + PAGE_SIZE * i;
> > > > -	flush_cache_vmap(_va, va_end);
> > > > +	flush_cache_vmap((unsigned long) _va, (unsigned long) va_end);
> > > >  }
> > > >  
> > > >  static inline void sgtable_drain_vmalloc(struct sg_table *sgt)
> > > 
> > > If no need for pointer, what about below?
> > 
> > I did not check for the usage of sgtable_drain_vmalloc().
> > Yes. If the void* isn't MUST then, change below is fine.
> > 
> > ~sanjeev
> 
> On second look, the need for void* is driven backwards from:
>      pg = vmalloc_to_page(va);
> In function sgtable_fill_vmalloc().
> 
> Now we need a typecast from u32 to void*.
> 
> Shouldn't we go with the original patch itself?

Right, the original is better, then;)
