From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.20-rc5-omap] musb_hdrc misc cleanups
Date: Wed, 17 Jan 2007 14:14:26 -0800
Message-ID: <20070117221426.GC4802@atomide.com>
References: <200701171243.37404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200701171243.37404.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [070117 13:44]:
> Remove debug/prototype sysfs attribute 'musb_otg', so there's only
> the one (compound) state machine to follow.  (If we need an option
> it'd more likely be to match the N800:  Mini-B connector forced
> into host mode, with gender-bender assistance.)
> 
> Minor DaVinci tweak:  on driver shutdown, don't wait for VBUS to fall
> unless we're the host which was supplying that voltage.
> 
> Remove some more UglyCamelCasing.
> 
> Clear HR in some peripheral side code; the silicon doesn't clear it
> in various cases you'd expect such stuff to be automatic. 

Pushed.

Tony
