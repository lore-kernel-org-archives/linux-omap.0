From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
	aspresent on OMAP2430
Date: Fri, 10 Aug 2007 02:43:45 -0700
Message-ID: <20070810094345.GP8658@atomide.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF8C3@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708040951470.2982@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FFAB9@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429018FFAB9@dlee13.ent.ti.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070804 15:02]:
> > > The current TRM for both 243x and 242x is version Q as of July 07.
> > 
> > That would explain it.  I will pick up the more recent revisions.  In
> the
> > meantime, I will fix the patch to preserve sys_clkout2 for 2430, and
> also
> > to fix the register bits to indicate that they are not 2420-only.
> 
> You might just hold off.  I didn't see it in rev Q either.  It was added
> into the basic functional spec. The F-spec's are the original document
> from designers, started a couple years before TRMs and are built up
> along with the chips.  Later, TRMs are spun off.

Nice job with the clocks Paul :) Pushing the whole series today.

Regards,

Tony
