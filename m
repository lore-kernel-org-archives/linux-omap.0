From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap clock.h question
Date: Tue, 7 Feb 2006 14:29:38 -0800
Message-ID: <20060207222938.GG27148@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A504365B3D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A504365B3D@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [060207 14:07]:
> > I believe he meant just to hide the clock number for mmc 1 or 2. But I
> > guess we still need to have different naming for omap1 and omap2.
> 
> Like I was saying you could hide both the slot and the names.
> 
>  for(i=data.slot[slot].num_clks; i>0; i--)
>  {
> 	ck = clk_get(data.slot.clk_name[i-1])
> 	if(ck != NULL)
> 	clk_enabl(ck);
>  }
> 
> That way we don't care the name or how many.  It gets rid of some if
> statements anyway.

But one of the clocks can be off more often than the other from PM point
of view.

Tony
