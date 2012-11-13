From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Tue, 13 Nov 2012 17:54:26 +1100
Message-ID: <20121113065426.GD25915@truffula.fritz.box>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <20121109022624.GI23553@truffula.fritz.box>
 <CACxGe6vQ50aS0Fe7QvTHKfV=EDpsZoLC7SOxXLGc0pkMvyk5DQ@mail.gmail.com>
 <20121113010505.GR4696@truffula.fritz.box>
 <50A1D8FF.7060104@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50A1D8FF.7060104-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 12, 2012 at 10:22:07PM -0700, Stephen Warren wrote:
> On 11/12/2012 06:05 PM, David Gibson wrote:
> > On Fri, Nov 09, 2012 at 09:42:37PM +0000, Grant Likely wrote:
> ...
> > 2) graft bundle
> > 
> > The base tree has something like this:
> > 
> > 	...
> > 	i2c@XXX {
> > 		...
> > 		cape-socket {
> > 			compatible = "vendor,cape-socket";
> > 			id = "Socket-A";
> > 			piece-id = "i2c";
> > 			ranges = < ... >;
> > 		};
> > 	};
> > 	...
> > 	spi@YYY {
> > 		...
> > 		cape-socket {
> > 			compatible = "vendor,cape-socket";
> > 			id = "Socket-A";
> > 			piece-id = "spi";
> > 			ranges = < ... >;
> > 		};
> > 	};
> > 	...
> > 	cape-socket {
> > 		compatible = "vendor,cape-socket";
> > 		id = "Socket-A";
> > 		piece-id = "misc";
> > 		interrupt-map = < ... >;
> > 		interrupt-map-mask = < ... >;
> > 		gpio-map = < ... >;
> > 		gpio-map-mask = < ... >;
> > 	};
> > 
> > Then instead of grafting a single subtree for the socket, we install a
> > "bundle" of subtrees, one each for each of the pieces within the
> > socket.  That bundle could either be an actual set of multiple fdts,
> > or they could be placed into one fdt with a dummy root node, something like:
> >
> > 	/ {
> > 		plugin-bundle;
> > 		compatible = "vendor,cape-plugin";
> > 		version = ...;
> > 		i2c-piece = {
> > 			piece-id = "i2c";
> > 			...
> > 		};
> > 		misc-piece = {
> > 			piece-id = "misc";
> > 			...
> > 		};
> > 	};
> 
> I do like this approach; it's the kind of thing I proposed at:
> 
> > http://www.mail-archive.com/devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org/msg20414.html

Roughly, yes, though a little streamlined from the syntax suggested
there.

> One question though: Perhaps the base board has two instances of the
> same type of connector vendor,cape-socket, allowing 2 independent capes
> to be plugged in. When overlaying/grafting the child board's .dts, we'd
> need some way to specify the socket ID that was being plugged into. Is
> that the intent of the "id" property in your base board example above?

Yes, that's exactly what I had in mind for the "id" property.
Property names and other details entirely negotiable at this stage,
of course.

By the by, I think having multiple interchangable sockets could break
the convention based approach for avoiding collisions between phandles
I suggested, but another mail with some better thoughts on that
shortly to be posted.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
