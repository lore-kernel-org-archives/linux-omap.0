From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.19-rc4-omap 1/2] h4 must have blinky leds!!
Date: Fri, 10 Nov 2006 01:08:58 +0200
Message-ID: <20061109230857.GH16172@atomide.com>
References: <200611031135.35487.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611031135.35487.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [061103 22:08]:
> This adds generic support for the "debug board" LEDs used by most of
> TI's OMAP reference boards, and board-specific support for the H4.
> 
> It's derived from the not-as-generic stuff used by OMAP1 H2/H3/P2.
> Those should be able to switch easily to this version, and clean up
> some of the omap1-specific code.
> 
> In addition to H4 support, one key improvement is supporting not just
> the "old" ARM debug LED API (with timer and idle LEDs, plus four that
> can be handy for kernel debugging), but it also supports the "new"
> generic LED API (most useful for usermode stuff IMO).  Either or both
> APIs can be enabled.

Great, pushing today.

Tony
