From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] input: ads7846: can't disable filtering [was OMAP5912
	touchscreen irq not working]
Date: Mon, 5 Jun 2006 08:17:13 -0700
Message-ID: <200606050817.13575.david-b@pacbell.net>
References: <4477F2BA.3080907@gmail.com> <44842780.3010507@gmail.com>
	<1149517743.11849.39.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1149517743.11849.39.camel@mammoth.research.nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 05 June 2006 7:29 am, Imre Deak wrote:
> 
> The solution would be to use the IRQ line state - as we already do to
> determine the pen down - for the pen up event as well.
> ...
> > Sorry, but at least on OSK with Mistral this new stuff isn't 
> > usable. Old driver worked quite well.
> 
> Yes, I checked the old driver and it uses the pen IRQ for pen down / up
> events, so that might be the difference.

Well, there have been recent regressions, but the new code _has_ worked
quite well in the past ... 

Using the pen IRQ for driver state transitions is problematic, since the
driver has to work with a variety of triggering modes ... both edges,
falling only (or, with hw inverter, rising only), low level (or, with
inverter, high).

It's true that having that "poll penirq state" method is a big win.

- Dave
