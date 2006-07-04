From: tony@atomide.com
Subject: Re: Undefined usb_disconnect
Date: Tue, 4 Jul 2006 01:20:38 -0700
Message-ID: <20060704082029.GB4962@atomide.com>
References: <4452384E.7080409@gmail.com>
	<20060505110852.66e6f39d.Hiroshi.DOYU@nokia.com>
	<4477F3E1.4000301@gmail.com>
	<200605270843.54940.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605270843.54940.david-b@pacbell.net>
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
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060527 08:44]:
> On Friday 26 May 2006 11:38 pm, Dirk Behme wrote:
> > Hi,
> > 
> > with recent git I still get
> > 
> > WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko] 
> > undefined!
> 
> Try the attached patch instead ... it fixes some other glitches
> in the OMAP bus glue, as well as those.
> 
> - Dave
> 
> 
> 
> 

> Various fixes for the OHCI OMAP glue:
> 
>  - Properly use the usbcore HCD lifecycle entry points
> 
>  - Remove calls to non-exported usbcore routines.
> 
>  - Stop inappropriate export of some bus glue calls
> 
> Plus remove some extra whitespace.

<snip>

I'll push this today slightly updated. Sorry, I should have pushed
this earlier.

Dave, I assume you will eventually send this upstream through your
USB channels so I did not tag this as a ARM: OMAP: patch.

Regards,

Tony
