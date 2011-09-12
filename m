From: Trond Myklebust <Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: RE: Regression seen when HIGHMEM enabled with NFS on 3.1rc4 kernel
Date: Mon, 12 Sep 2011 10:41:49 -0400
Message-ID: <1315838509.12736.4.camel@lade.trondhjem.org>
References: <CAJ7qFSeB8bAGdYfZs-LFHuYqGWNA2RidY0EBEFw_1CndvG7q5A@mail.gmail.com>
	 <1315594317.17611.25.camel@lade.trondhjem.org>
	 <dbdc7c3761a82e0b84f2f49c533c07a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dbdc7c3761a82e0b84f2f49c533c07a5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-09-12 at 11:46 +0530, Sricharan R wrote: 
> Hi Trond,
> [....]
> 
> >>          1) In the above piece of code, the *ppage value from ops-
> >>sendpage
> >>             function is finally passed on to Kmap by the lower level
> code
> >to
> >>             get the virtual address of the page.
> >>          2) In some corner cases the value of *ppage pointer is NULL.
> >>          3) When highmem is enabled and a NULL pointer is passed to
> >>             Kmap, then kmap finally crashes. But in the case when
> highmem
> >>             is disabled, then kmap returns a junk value for NULL
> pointer.
> >>
> >>             Highmem Enabled , kmap( NULL )-----> kernel crashes.
> >>
> >>            Highmem disabled, kmap( NULL )-----> junk value is returned.
> >>                Subsequently this message is observed on
> >>                                                 the console.
> >>
> >>                                 "RPC call returned error 14"
> >>
> >>          4) Now the question is why is the value of *ppage = NULL is
> >passed
> >>             from the above piece of code to lower layers.
> >>            Should that not have handled *ppage = NULL? and kmap should
> >not
> >>             have received a NULL pointer?
> >
> >I wouldn't expect *ppage to be NULL under any circumstances, so I'm
> >really curious as to what is happening here.
> >
> >Could you perhaps add a printk() to that section of code to print out
> >the values of 'xdr->page_base', 'xdr->page_len', 'len' and 'remainder'
> >in the case where *ppage == NULL?
> >
> 
> 
> Thanks for the response.
> I added a printk just before err = sock->ops->sendpage(sock, *ppage, base,
> len, flags);
> So here are values when *ppage is NULL.
> 
> xdr->page_base= 0xCE9  xdr->page_len=0x400 len=0xE9 remainder=0x0.
> 
> Thanks,
>  Sricharan

Can you please tell me what the mount options are for this setup?

Are you running any applications that might be using O_DIRECT writes?

Cheers
  Trond

-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org
www.netapp.com

--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
