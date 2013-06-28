From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Fri, 28 Jun 2013 11:21:45 +0100
Message-ID: <20130628102145.GB2139@e106331-lin.cambridge.arm.com>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
 <20130628093848.GA2139@e106331-lin.cambridge.arm.com>
 <1372413215.21065.41.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372413215.21065.41.camel-eHkr6bJ9aPyyenC2BZ5AVw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mturquette-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 28, 2013 at 10:53:35AM +0100, Luciano Coelho wrote:
> On Fri, 2013-06-28 at 10:38 +0100, Mark Rutland wrote:
> > On Tue, Jun 25, 2013 at 09:35:30AM +0100, Luciano Coelho wrote:
> > > +Optional properties:
> > > +--------------------
> > > +
> > > +- refclock: the internal WLAN reference clock frequency (required for
> > > +  WiLink6 and WiLink7; not used for WiLink8).  Must be one of the
> > > +  following:
> > > +	0 = 19.2 MHz
> > > +	1 = 26.0 MHz
> > > +	2 = 38.4 MHz
> > > +	3 = 52.0 MHz
> > > +	4 = 38.4 MHz, XTAL
> > > +	5 = 26.0 MHz, XTAL
> > > +
> > > +- tcxoclock: the internal WLAN TCXO clock frequency (required for
> > > +  WiLink7 not used for WiLink6 and WiLink8).  Must be one of the
> > > +  following:
> > > +	0 = 19.200 MHz
> > > +	1 = 26.000 MHz
> > > +	2 = 38.400 MHz
> > > +	3 = 52.000 MHz
> > > +	4 = 16.368 MHz
> > > +	5 = 32.736 MHz
> > > +	6 = 16.800 MHz
> > > +	7 = 33.600 MHz
> > 
> > This looks suspiciously like what we have the common clock bindings for:
> > 
> > refclk {
> > 	compatible = "fixed-clock";
> > 	#clock-cells = <0>;
> > 	clock-frequency = <19200000>;
> > }
> > 
> > wilink {
> > 	compatible = "ti,wilink7";
> > 	interrupt-parent = <&some_interrupt_controller>;
> > 	interrupts = <0 1 1>;
> > 	clocks = <&refclk>, <&refclk>;
> > 	clock-names = "refclk", "txoclk";
> > };
> > 
> > Could you not use them?
> 
> Hmmm... this actually does look good.  But these are internal clocks in
> the modules, they cannot be accessed from outside.  Does it make sense
> to register them with the clock framework?

Given we already have a common way of describing clocks, I think it
makes sense to use it -- people already understand the common bindings,
and it's less code to add add to the kernel. I don't think the fact
these clocks are internal should prevent us from describing them as we
would an external clock.

Perhaps Mike Turquette [Cc'd] has an opinion on the matter. 

Thanks,
Mark.
