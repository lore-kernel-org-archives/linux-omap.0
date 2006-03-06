From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: timer+irq fix up
Date: Mon, 6 Mar 2006 13:59:59 -0800
Message-ID: <20060306215959.GG4382@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A5049BF62D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5049BF62D@dlee02.ent.ti.com>
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

* Woodruff, Richard <r-woodruff2@ti.com> [060306 08:10]:
> 
> Note:
> 	- Strange that the timer offset function was dropped in porting
> over from TI code.  Compensating for latency and giving higher
> resolution time stamps seems like a good thing.

Yeah the gettimeoffset function should be there. We could also use
the 32KHz sync timer for gettimeoffset as done in timer32k.c, might be
worth doing some testing to see if that accuracy is enough.

Regards,

Tony
