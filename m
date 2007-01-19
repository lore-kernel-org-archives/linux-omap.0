From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/3] musb_hdrc, remove MGC_{Read,Write}Csr{8,16}
Date: Fri, 19 Jan 2007 15:49:13 -0800
Message-ID: <200701191549.13745.david-b@pacbell.net>
References: <200701181535.08332.david-b@pacbell.net>
	<20070119000301.GA7915@atomide.com>
	<200701181931.41325.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200701181931.41325.david-b@pacbell.net>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 18 January 2007 7:31 pm, David Brownell wrote:
> On Thursday 18 January 2007 4:03 pm, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [070118 15:39]:
> 
> > >  - Hmm, host side was not enumerating ... new failure
> > 
> > I've noticed that too, ...
> > 
> > Are you getting same results on h4?
> 
> Modulo me using a different debug level, yes.

I looked a bit at this, it looks like a usbcore change broke
things.  The musb_hdrc driver tells usbcore to probe that root
hub, but usbcore does nothing ... seemingly it now expects to be
told to wake up the root hub first, which makes no sense for
this particular hardware.

- Dave
