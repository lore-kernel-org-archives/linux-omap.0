From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Wed, 31 Oct 2007 06:26:24 -0700
Message-ID: <20071031132624.GK32547@atomide.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804AF985E@dbde01.ent.ti.com>
	<20071031131059.GG32547@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429025C0830@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429025C0830@dlee13.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [071031 06:19]:
> > Let's remove the #ifdefs here, we want to be able to compile support
> for
> > 24xx and 34xx into the same kernel eventually. It's OK to have the
> same
> > DMA request channel defined in different way for 24xx and 34xx.
> 
> One question here is will that happen practically?  Maybe it will, not
> sure.  The same sentiments were made about OMAP1 vs. OMAP2.  The
> structure which results from the sharing intent perhaps is net positive
> but I don't see them converging.
> 
> People would likely compiled 3430 for ARMv7 and ARMv6 for 24xx.  Some
> new instructions and the like are around.  I don't that its fully
> pluggable at the architecture level even.

Recent gcc allows mixing in assembly for later cores, so it's not a
problem. Sure you can optimize it for one core by not selecting anything
else.

> EABI if really used might allow some fancy solutions in theory but I
> wonder if those will develop.  Not to say this the only way.

It may take a while, but let's not add any new barriers to compile in
multiple cores.

Regards,

Tony
