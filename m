From: Tony Lindgren <tony@atomide.com>
Subject: Re: patchs commits
Date: Sat, 11 Nov 2006 19:02:59 +0200
Message-ID: <20061111170258.GA13235@atomide.com>
References: <20061109205157.GF16172@atomide.com>
	<20061110011731.A67731DA327@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20061111001355.GR26185@atomide.com>
	<200611101905.19713.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200611101905.19713.david-b@pacbell.net>
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
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061111 05:05]:
> On Friday 10 November 2006 4:13 pm, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [061110 03:18]:
> > > > > Do you know if the USB OHCI and Gadget are functional for the OMAP2420 H4?
> > > >
> > > > I think after Kyungmin's and Dave's patches it may be close to working
> > > > in linux-omap tree :)
> > > 
> > > Well, here's the missing "add H4 USB support" patch ... with one
> > > glitch, "doesn't work yet".
> > > 
> > > ...
> > 
> > Pushing. (And assuming you'll push the USB changes upstream eventually
> > via your USB channels)
> 
> Stuff in drivers/usb (and the isp1301 driver) will eventually go
> upstream that way ... stuff in arch/arm should IMO be stuff you hand
> off through Russell.

OK, I'll split that patch accordingly for Russell.

Tony
