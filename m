From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [PATCH] [MTD] [OneNAND] Use mtd_oob_ops at oob functions
Date: Fri, 7 Sep 2007 10:57:31 +0900
Message-ID: <005101c7f0f2$79854f00$e1ac580a@swcenter.sec.samsung.co.kr>
References: <003301c7e079$f7c3fdf0$e1ac580a@swcenter.sec.samsung.co.kr>
	<20070831205902.GV12350@atomide.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070831205902.GV12350@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > Subject: [PATCH] [MTD] [OneNAND] Use mtd_oob_ops at oob functions
> >
> > To enable the main read/write at oob ops
> 
> Pushing today.
> 

Sorry for bothering you.
It's wrong post. It's already merged at MTD tree.
You don't need to commit this one to OMAP tree.

FYI, now we can use the yaffs2 on OneNAND with recent patch.

Thank you,
Kyungmin Park
