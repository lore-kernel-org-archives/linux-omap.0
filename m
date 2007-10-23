From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: About to tag 2.6.23-omap1
Date: Wed, 24 Oct 2007 08:11:12 +0900
Message-ID: <002801c815ca$07762720$e1ac580a@swcenter.sec.samsung.co.kr>
References: <20071023011920.GL17318@atomide.com>
	<9c9fda240710221845y341a5cb0i50b7e07e6d959853@mail.gmail.com>
	<471E1377.401@googlemail.com> <20071023174000.GH5193@atomide.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20071023174000.GH5193@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>, 'Dirk Behme' <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> * Dirk Behme <dirk.behme@googlemail.com> [071023 08:30]:
> > Kyungmin Park wrote:
> >> There is a pending patch related with OMAP2 USB device DMA support.
> >> I think now there's one user to use this feature, Apollon.
> >> As David's comment, it has board specific code.
> >> but the DMA patch don't update the board specific code. it only adds
> >> the DMA codes.
> >> So if you don't mind I hope to merge this one too.
> >
> > Looking into my pending patches list, I think you mean
> >
> > http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011579.html
> >
> > ?

Yes, it is.
For more detail, it only happens at windows connection.
Without the small packet handling, it's working well at linux host.

> 
> Let's plan on pushing that over after updating to current mainline
> kernel. That way if it breaks stuff for non-DMA configurations :)

No problem, the goal is that it goes to mainline.

Thank you,
Kyungmin Park
