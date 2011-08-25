From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: How to handle named resources with DT?
Date: Thu, 25 Aug 2011 17:05:42 +0200
Message-ID: <201108251705.43168.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
	<20110825102824.GB10405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110825102824.GB10405-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 25 August 2011, Russell King - ARM Linux wrote:
> 
> On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
> > on top of all that, for IPs which are used on many SoCs (such as MUSB)
> > it's quite silly to force all users to provide resources in a certain
> > order. It sounds to me that this will be prone to error in many ways
> > until everything is synced up and on the correct order.
> > 
> > Ditching _byname is a very bad idea.
> 
> I continue to disagree.  The current _byname is an abonimation and hack
> to try to "fix" this problem.
> 
> _byname should have been implemented differently - rather than overriding
> the resources name field (which is normally specified to be the device
> or driver name), a new field should have been introduced in struct resource
> to carry the resource sub-name (which is really what it is.)
> 
> That would have avoided making /proc/iomem completely illegible with
> multiple devices using this feature.

I agree 100%.

I'm also sure that the danger of breaking something by removing the
_byname resource resolution for each driver that we convert to DT
based probing is very small: We already need to change all static
platform_device definitions along with changing the driver, and
identifying them by index is no more ambiguous than accessing an
individual MMIO register by its index. You can even use an enum
or macro to name the indexes like:

enum {
	FOO_RESOURCE_SETUP,
	FOO_RESOURCE_POWER,
	FOO_RESOURCE_BUFFER,
};

static struct resource foo_res[] = {
	[FOO_RESOURCE_SETUP] = {
		.start = FOO_SETUP_BASE,
		.end   = FOO_SETUP_BASE + FOO_SETUP_LEN -1,
		.flags = IORESOURCE_MEM,
	},
	[FOO_RESOURCE_POWER] = {
		.start = FOO_POWER_BASE,
		.end   = FOO_POWER_BASE + FOO_POWER_LEN -1,
		.flags = IORESOURCE_MEM,
	},
	[FOO_RESOURCE_BUFFER] = {
		.start = FOO_BUFFER_BASE,
		.end   = FOO_BUFFER_BASE + FOO_BUFFER_LEN -1,
		.flags = IORESOURCE_MEM,
	},
};

	Arnd
