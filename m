From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Fri, 26 Aug 2011 17:41:29 +0200
Message-ID: <201108261741.29850.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110826130644.GN2308@yookeroo.fritz.box>
	<201108261735.55412.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201108261735.55412.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 26 August 2011, Arnd Bergmann wrote:
> On Friday 26 August 2011, David Gibson wrote:
> > If you open code it this way then yes, it's silly.  But what about
> > something like this:
> > 
> > static struct of_device_id foodevice_of_match[] __devinitdata = {
> >         { .compatible = "foocorp,foodevice1234",
> >           .resource_names = {"base_regs", "extra_regs", }, },
> >         { .compatible = "foocorp,foodevice1239",
> >           .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
> >         { },
> > };
> 
> Hmm, I hadn't thought of that. This looks quite nice indeed. No objections
> to this from my side.
> 

Ah well, one objection on second thought:

This assumes that there is just one type of resource, but named resources
may be used for iomem, ioport and irq resources. If you have multiple
IRQs and multiple IOMEM resources, I don't see how the index in the 
resource_names array can be used for both of them.

	Arnd
