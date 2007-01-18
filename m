From: tony@atomide.com
Subject: Re: [patch 2.6.20-rc5-omap] partial omap2430 fixes for musb_hdrc
Date: Thu, 18 Jan 2007 14:20:59 -0800
Message-ID: <20070118222058.GA7362@atomide.com>
References: <20070118120109.E76D820F0DC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070118120109.E76D820F0DC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070118 04:01]:
> Partial build fixes for musb_hdrc on OMAP 2430; plus typedef and CaMeLcAsE
> removal in the support for Mentor's DMA engine.
> 
> Also re-order the mach-omap2 Kconfig to restore the option hierachy that
> was destroyed when the 2430SDP patch was merged into the wrong place.
> 
> Someone still needs to provide <asm/arch/hdrc_cnf.h> corresponding to
> how the Mentor core is configured on that platform; add some register
> and pin mux declarations; and create and register the platform_device.

Pushed.

Tony
