From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 0/3] musb_hdrc, remove MGC_{Read,Write}Csr{8,16}
Date: Mon, 22 Jan 2007 14:45:13 -0800
Message-ID: <20070122224513.GG7382@atomide.com>
References: <200701181535.08332.david-b@pacbell.net>
	<200701191549.13745.david-b@pacbell.net>
	<20070122211953.GF7382@atomide.com>
	<200701221359.52370.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200701221359.52370.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [070122 14:00]:
> On Monday 22 January 2007 1:19 pm, Tony Lindgren wrote:
> 
> > OK, BTW looks like I'm not getting any VBUS on N800.
> > If I ground ID pin and feed back VBUS from hub to N800, then it
> > enumerates. (This is with maemo.org 2.6.18 tree)
> 
> Hmm, maybe they didn't populate the caps for the chargepump?
> If you ground it, VBUS should come automagically.

Well it seems to work if I force VBUS on once before connecting
the host cable.

Otherwise VBUS does not seem to reach 5V but is somewhere
below 5V, and then "vbus too slow" kills it off.

Plugging the cable in 2 - 3 times fast makes it work too, then
VBUS seems to reach 5V.
 
> Here's a patch that addresses one issue I know about.  But
> another couple issues joined recently ... not quit sure what's
> up with those yet.

Pushed it.

Tony
