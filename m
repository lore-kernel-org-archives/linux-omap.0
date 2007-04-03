From: tony@atomide.com
Subject: Re: ARCH_OMAP243x vs. ARCH_OMAP2430
Date: Tue, 3 Apr 2007 15:54:26 -0400
Message-ID: <20070403195424.GF24864@atomide.com>
References: <45F73916.2000504@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274298A29FE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274298A29FE@dlee13.ent.ti.com>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070313 20:02]:
> > But in the MUSB code as well as prcm-regs.h there are #ifdefs for
> > OMAP243X.   Are there other 243x platforms in the wild, or should I
> just
> > convert these #ifdefs to 2430.  If converting is the right thing,
> here's
> > a patch.
> 
> Those 243X's are used in MV and TI trees.  I don't think the GIT one
> used it.  They probably snuck in on your end or in previous pushes
> candidates from others.
> 
> They all have to be the same for sure. Looks like a good thing to fix.

This is now pushed too.

Tony
