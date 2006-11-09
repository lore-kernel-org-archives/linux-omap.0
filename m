From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc4-omap 2/2] abstract debug card setup (smc,
	leds)
Date: Fri, 10 Nov 2006 01:09:11 +0200
Message-ID: <20061109230910.GI16172@atomide.com>
References: <200611031147.08596.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611031147.08596.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061103 21:59]:
> Additional cleanup for debug boards on H2/P2/H3/H4:  move the init
> code that's not board-specific into a new file where it can be easily
> shared between all the different boards (avoiding code duplication,
> and making it easier to support more devices).  Make H4 use that.
> 
> This should be easy to drop in to the OMAP1 boards using these debug
> cards; the only difference seems to be that the p2 does an extra reset
> of the smc using the fpga (probably all boards could do that, if it's
> necessary) and doesn't use the gpio mux or request APIs.

Pushing today.

Tony
