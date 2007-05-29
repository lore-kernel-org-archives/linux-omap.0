From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/11] Compiling dsp-common if DSP is enabled.
Date: Tue, 29 May 2007 10:08:56 -0700
Message-ID: <20070529170856.GF26322@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E34@dlee13.ent.ti.com>
	<20070529165528.GC26322@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429011588FB@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429011588FB@dlee13.ent.ti.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070529 10:02]:
> > We should compile DSP for omap1 (and aybe 24xx?) to keep
> > audio McBSP clock functioning. And eventually we should have common
> > dsp init that works for all of them.
> > 
> > What if you just add an early return to dsp init code for now with
> > a revisit comment?
> 
> The McBSP clocks in OMAP2 have no coupling to the DSP as they did in OMAP1.  In 1510's systems there was some ownership which required you to mess in the DSP address space.  This is not there in OMAP2/3.
> 
> Depending on the overall system architecture you might very well have the DSP driving a McBSP directly but that is another issue.
> 
> ... How does DSP gateway share or allocate resources, like a McBSP away from the ARM?  Is this static?  Does it even make sense to declare it as some sort of platform resource?

The basic DSP resources should be shared across dspgateway and
TI's bridge. Then the rest can go to drivers/dsp/omap/dspgateway and
drivers/dsp/omap/dspbridge or someting.

Regards,

Tony
