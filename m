From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 2/4] Makefile and Kconfig changes for V7 Cache updates
Date: Tue, 12 Jun 2007 23:06:33 -0700
Message-ID: <20070613060632.GD4030@atomide.com>
References: <20070612181652.GS28834@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47011E594F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E594F@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070612 20:57]:
> >I've only pushed this chunk, the rest should already be there after
> >git-cherry-picking following commits from arm tree:
> >
> <snip>
> 
> >Can you please check that these are enough? Then provide follow-up
> >patches if something else needs changing.
> >
> >If you want more patches from arm git tree, then also provide
> >the commit id.
> >
> 
> I re synched my patches with these pushes, I find 3430 kernel based de-compressing failing. Need to debug further. But u-boot based un-compression works fine. So the patch set should be sufficient. I will fix the other issue later. I tested booting on 2430 its fine too.

OK, great.

> I will wait for your response on debug_card_init comment for 3430. I will repost all the patches again probably tomorrow.

See my previous mail for that.

Tony
