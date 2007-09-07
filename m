From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [MTD] [OneNAND] Use mtd_oob_ops at oob functions
Date: Fri, 7 Sep 2007 08:15:32 -0700
Message-ID: <20070907151531.GD7030@atomide.com>
References: <003301c7e079$f7c3fdf0$e1ac580a@swcenter.sec.samsung.co.kr>
	<20070831205902.GV12350@atomide.com>
	<005101c7f0f2$79854f00$e1ac580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <005101c7f0f2$79854f00$e1ac580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kmpark@infradead.org> [070906 18:57]:
> > > Subject: [PATCH] [MTD] [OneNAND] Use mtd_oob_ops at oob functions
> > >
> > > To enable the main read/write at oob ops
> > 
> > Pushing today.
> > 
> 
> Sorry for bothering you.
> It's wrong post. It's already merged at MTD tree.
> You don't need to commit this one to OMAP tree.

OK, will use the upstream version when it trickles down.

> FYI, now we can use the yaffs2 on OneNAND with recent patch.

OK

Tony
