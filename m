From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Tue, 13 Nov 2012 08:10:11 -1000
Message-ID: <50A28D03.7050002@firmworks.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <50999145.2070306@wwwdotorg.org>
 <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com>
 <509D9089.7020407@wwwdotorg.org>
 <5B124797-6DFD-4C5E-90D7-665AFD4A7873@antoniou-consulting.com>
 <50A12950.6090808@wwwdotorg.org> <20121113072517.GE25915@truffula.fritz.box>
 <50A27BF1.4030502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50A27BF1.4030502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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

It seems to me that this capebus discussion is missing an important
point.  The name capebus suggests that it is a bus, so there should be a
parent node to represent that bus.  It should have a driver whose API
implements all of the system-interface functions a cape needs.

If you look at the way that interrupt specifiers work, the default case
is that a child device implicitly delegates the mapping to its parent.
The use of phandles to break out of the tree structure was intended for
use within the "hardwired motherboard domain", not for plug-in devices.

The "new" phandle-based GPIO and clock mechanisms don't have that
parent-delegation feature, but they should, because hierarchical
hardware is a good thing when it exists.  One fix would be to designate
a reserved phandle value - for example 0 or -1 - to mean "my parent". t
The parent node would contain some translator to resolve the actual
target node, similarly to interrupts and addresses.

If done correctly, capebus "overlays" would then just be proper child
nodes of the capebus bus node and there would no need to refer to
"global" information like non-parent phandles.

If something about the design of capebus makes that impossible, I
respectfully suggest that its design should be reviewed, taking into
account the many years of industry experience about modularity.

Mitch
