From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap mmc build errors
Date: Wed, 3 May 2006 04:01:49 -0700
Message-ID: <20060503110148.GB30376@atomide.com>
References: <443BAD8C.4090005@indt.org.br> <4457CE22.8050702@mvista.com>
	<00ae01c66e33$bf52cd20$7701a8c0@AthlonX2>
	<20060503095308.GA30376@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060503095308.GA30376@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Rick Foos <rick@synchromeshcomputing.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [060503 02:54]:
> * Rick Foos <rick@synchromeshcomputing.com> [060502 15:00]:
> > CONFIG_MMC_OMAP also allowed the git kernel to boot on OMAP 2420 H4, Thanks.
> >   ----- Original Message ----- 
> >   From: Kevin Hilman 
> > 
> >   Haven't had time to dig, but this builds but doesn't boot on 1710/H3.  Simply 
> >   disabling CONFIG_MMC_OMAP makes it boot.
> 
> Hmmm, seems like only 15xx works now. The driver hangs for 16xx in
> the while loop in mmc_omap_set_ios(). Also I noticed that all the
> menelaus code is missing so it won't work on 24xx.

OK, I've pushed a patch that makes MMC work. 24xx is still probably
broken because of missing menelaus code.

Regards,

Tony
