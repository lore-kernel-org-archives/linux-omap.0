From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MUSB HDRC: RMMOD fixing
Date: Thu, 18 Jan 2007 11:39:23 -0800
Message-ID: <20070118193923.GI14425@atomide.com>
References: <1169062794.14795.1.camel@balbi>
	<200701171157.26218.david-b@pacbell.net>
	<1169065683.14795.12.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1169065683.14795.12.camel@balbi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.lima@indt.org.br> [070117 12:28]:
> 
> 	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);
> 	musb_platform_exit(musb);
> 	musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, 0);

Basically musb_platform_exit() powers off the device so
the musb_writeb() most likely fails unless the device
happens to stay on a little while after.

Tony
