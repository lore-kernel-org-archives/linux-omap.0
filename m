From: Tony Lindgren <tony@atomide.com>
Subject: Re: patchs commits
Date: Sat, 11 Nov 2006 02:13:56 +0200
Message-ID: <20061111001355.GR26185@atomide.com>
References: <20061109205157.GF16172@atomide.com>
	<002701c7044b$fbf4a100$818310ac@mis.cypress.com>
	<20061109234030.GP16172@atomide.com>
	<20061110011731.A67731DA327@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061110011731.A67731DA327@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061110 03:18]:
> > > Do you know if the USB OHCI and Gadget are functional for the OMAP2420 H4?
> >
> > I think after Kyungmin's and Dave's patches it may be close to working
> > in linux-omap tree :)
> 
> Well, here's the missing "add H4 USB support" patch ... with one
> glitch, "doesn't work yet".
> 
> - Dave
> 
> [PATCH] USB peripheral support on H4
> 
> H4 has two peripheral ports, one for "download" and one for OTG.
> The one to use is selected through Kconfig.
> 
> Also removes some bad whitespace from isp1301_omap.c
> 
> NOTE:  not yet working; I suspect there's a clock still turned off
> or something like that, since neither port responds.

Pushing. (And assuming you'll push the USB changes upstream eventually
via your USB channels)

Tony
