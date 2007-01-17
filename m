From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.20-rc5-omap] musb_hdrc runtime code shrinkage
Date: Wed, 17 Jan 2007 14:14:10 -0800
Message-ID: <20070117221409.GB4802@atomide.com>
References: <200701171241.59902.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200701171241.59902.david-b@pacbell.net>
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
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070117 13:42]:
> Move musb_hdrc driver init into the init section, by switching over to use
> platform_driver_probe().  Shrinks this driver's run-time footprint by about
> 5KB ... pretty good for linker level tweaks to just one (big) driver, and
> there's a bit more shrinkage yet to be had (for DMA init).

Pushed.

Tony
