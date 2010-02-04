From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Thu, 04 Feb 2010 11:42:55 +0200
Message-ID: <1265276575.17836.10.camel@tubuntu.research.nokia.com>
References: <20100203152947.f4955d91.sfr@canb.auug.org.au>
	 <6ed0b2681002030429t1f6b33e9r3b6ea667fffb0f6a@mail.gmail.com>
	 <20100203171227.GD22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100203171227.GD22747@atomide.com>
Sender: linux-next-owner@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter Adrian (Nokia-D/Helsinki)" <adrian.hunter@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-02-03 at 18:12 +0100, ext Tony Lindgren wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [100203 04:27]:
> > hi,
> > 
> > On Wed, Feb 3, 2010 at 6:29 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Hi Tomi,
> > >
> > > Today's linux-next merge of the omap_dss2 tree got a conflict in
> > > arch/arm/mach-omap2/board-omap3pandora.c between commit
> > > f8b6f704105164eac7c043a48f79c4234e03e4b2 ("omap: Rename hsmmc symbols to
> > > reflect independence from twl4030") from the omap tree and commit
> > > aacb4387a1e6f3b57977375532c6d8e47fcd5652 ("OMAP: pandora: add DSS2
> > > support and related regulators") from the omap_dss2 tree.
> > 
> > I've rebased my patch against linux-omap/for-next (attached). To fix
> > the conflict, Tomi can rebase his queue on linux-omap/for-next, or
> > Tony can simply take this to his queue - this has no "hard"
> > dependencies on other queued DSS2 changes, has only board file changes
> > and builds fine in linux-omap/for-next. I would prefer the second
> > option, as I plan sending more boardfile changes to linux-omap.
> 
> Thanks Stephen and Grazvydas.
> 
> This sounds good to me, I've added this patch into omap for-next.
> 
> Tomi can you please drop the earlier version from your branch?

Sounds good to me. I dropped the patch from my tree.

 Tomi
