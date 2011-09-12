From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: RE: Regression seen when HIGHMEM enabled with NFS on 3.1rc4 kernel
Date: Mon, 12 Sep 2011 11:54:18 -0400
Message-ID: <1315842858.15975.2.camel@lade.trondhjem.org>
References: <CAJ7qFSeB8bAGdYfZs-LFHuYqGWNA2RidY0EBEFw_1CndvG7q5A@mail.gmail.com>
	 <1315594317.17611.25.camel@lade.trondhjem.org>
	 <dbdc7c3761a82e0b84f2f49c533c07a5@mail.gmail.com>
	 <1315838509.12736.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.netapp.com ([216.240.18.37]:22732 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069Ab1ILPye convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 11:54:34 -0400
In-Reply-To: <1315838509.12736.4.camel@lade.trondhjem.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-nfs@vger.kernel.org

On Mon, 2011-09-12 at 10:41 -0400, Trond Myklebust wrote: 
> On Mon, 2011-09-12 at 11:46 +0530, Sricharan R wrote: 
> > Thanks for the response.
> > I added a printk just before err = sock->ops->sendpage(sock, *ppage, base,
> > len, flags);
> > So here are values when *ppage is NULL.
> > 
> > xdr->page_base= 0xCE9  xdr->page_len=0x400 len=0xE9 remainder=0x0.
> > 
> > Thanks,
> >  Sricharan
> 
> Can you please tell me what the mount options are for this setup?

I'm guessing you've got wsize=1024, in which case, can you please try
the following patch?

Cheers
  Trond
8<-------------------------------------------------------------------------- 
>From 7b4a9c76b55dd254431902552528137a2ea5e55d Mon Sep 17 00:00:00 2001
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Mon, 12 Sep 2011 11:47:53 -0400
Subject: [PATCH] NFS: Fix a typo in nfs_flush_multi

Fix a typo which causes an Oops in the RPC layer, when using wsize < 4k.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 fs/nfs/write.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b39b37f..c9bd2a6 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -958,7 +958,7 @@ static int nfs_flush_multi(struct nfs_pageio_descriptor *desc, struct list_head
 		if (!data)
 			goto out_bad;
 		data->pagevec[0] = page;
-		nfs_write_rpcsetup(req, data, wsize, offset, desc->pg_ioflags);
+		nfs_write_rpcsetup(req, data, len, offset, desc->pg_ioflags);
 		list_add(&data->list, res);
 		requests++;
 		nbytes -= len;
-- 
1.7.6



-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust@netapp.com
www.netapp.com

