From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/5] SRAM patcher: patch register addresses in SRAM code
 atruntime
Date: Fri, 16 Nov 2007 12:33:43 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711161223280.13378@utopia.booyaka.com>
References: <20071114083010.938764990@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429027B3E1E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429027B3E1E@dlee13.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

On Wed, 14 Nov 2007, Woodruff, Richard wrote:

> -*- This code as written today likely won't be used on OMAP3 anyway as 
> the DVFS procedure will be different.  The SRAM code usage can be much 
> smaller and should also be different.
> The aim of making it single kernel for OMAP2 to OMAP3 in this case is 
> just using the SRAM function for pushing the correct SRAM routine.

Yeah, agreed.  The main motivation was to share 2420/2430 code here.  I'm 
hoping that there may be some 3430 sharing that can be done also, perhaps 
some of the SDRAM timing change code, but there's probably other code that 
won't be sharable without contortions.

> - Well that does look fine.  It kind of feels like a gratuitous cache 
> range flush should be added.  But as its all data side patches it 
> probably can live with out it.  The initial code copy should probably 
> have this.  Caches are VIPT, which means you almost don't have to flush, 
> but you still do, but it can be in a more optimal way at run time.

Want to do a patch for omap_sram_push()?  I suppose we're getting away 
without it now because nothing is running from SRAM before 
omap_sram_push(), and therefore isn't in I$?  sounds like it should be 
there, though.

Thanks for the review.

- Paul
