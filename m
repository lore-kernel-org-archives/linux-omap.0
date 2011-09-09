From: "R, Sricharan" <r.sricharan-l0cyMroinI0@public.gmane.org>
Subject: Regression seen when HIGHMEM enabled with NFS on 3.1rc4 kernel
Date: Fri, 9 Sep 2011 18:40:32 +0530
Message-ID: <CAJ7qFSeB8bAGdYfZs-LFHuYqGWNA2RidY0EBEFw_1CndvG7q5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "trond.myklebust" <trond.myklebust-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sorry resending again. My mailer settings thrashed my earlier email.

Hi,
  A kernel crash is observed on 3.1rc4 kernel when HIGHMEM is enabled and
  kernel is booted with a NFS on omap4430sdp. The issue happens in the below
  scenario.

       In file net/sunrpc/xprtsock.c,
         static int xs_send_pagedata( xxx, struct xdr_buf *xdr, ..)
         {
                Struct page **ppage;
                ....
                .....
                ppage = xdr->pages + (base >> PAGE_SHIFT);
                ....
            err = sock->ops->sendpage(sock, *ppage, base, len, flags);

            ...
         }

         1) In the above piece of code, the *ppage value from ops->sendpage
            function is finally passed on to Kmap by the lower level code to
            get the virtual address of the page.
         2) In some corner cases the value of *ppage pointer is NULL.
         3) When highmem is enabled and a NULL pointer is passed to
            Kmap, then kmap finally crashes. But in the case when highmem
            is disabled, then kmap returns a junk value for NULL pointer.

            Highmem Enabled , kmap( NULL )-----> kernel crashes.

           Highmem disabled, kmap( NULL )-----> junk value is returned.
               Subsequently this message is observed on
                                                the console.

                                "RPC call returned error 14"

         4) Now the question is why is the value of *ppage = NULL is passed
            from the above piece of code to lower layers.
           Should that not have handled *ppage = NULL? and kmap should not
            have received a NULL pointer?

Thanks,
  Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
