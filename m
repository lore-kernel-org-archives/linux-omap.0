From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2_get_clksel(): fix suspicious assignment
Date: Wed, 2 May 2007 17:33:24 +0000
Message-ID: <20070502173323.GF3520@atomide.com>
References: <Pine.LNX.4.64.0705020845350.19145@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429E55242@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429E55242@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070502 15:57]:
>  > mach-omap2/clock.c contains a suspicious assignment that 
> > almost certainly should be a equality test, in omap2_get_clksel().
> 
> Yes, its obviously wrong.  Nice to fix.
> 
> Strangely, my pre-translated trees are correct for this.  Generally,
> I've tried to keep this aspect in bug fix sync.

Thanks, pushing today.

Tony
