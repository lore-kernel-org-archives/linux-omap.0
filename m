From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Tue, 13 Nov 2012 11:05:15 +1100
Message-ID: <20121113000515.GP4696@truffula.fritz.box>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <20121109022624.GI23553@truffula.fritz.box>
 <CACxGe6v7q2=Dxn6BE_V-w9CEKxAsZ6zQd5Uqm4TeYGYCCu76cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACxGe6v7q2=Dxn6BE_V-w9CEKxAsZ6zQd5Uqm4TeYGYCCu76cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 09, 2012 at 09:08:14PM +0000, Grant Likely wrote:
> On Fri, Nov 9, 2012 at 2:26 AM, David Gibson
> <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> wrote:
> >> Summary points:
> >> - Create an FDT overlay data format and usage model
> >>   - SHALL reliable resolve or validate of phandles between base and
> >>     overlay trees
> >
> > So, I'm not at all clear on what this proposed phandle validation
> > would involve.  I'm also not convinced it's as necessary as you
> > think, more on that below.
> 
> Simply this: I'm taking this example from the omap3-beagle-xm.dts. It
> has the following stanza which is currently rolled into the resulting
> .dtb when compiled.
> 
> &i2c1 {
>         clock-frequency = <2600000>;
> 
>         twl: twl@48 {
>                 reg = <0x48>;
>                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>                 interrupt-parent = <&intc>;
> 
>                 vsim: regulator-vsim {
>                         compatible = "ti,twl4030-vsim";
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <3000000>;
>                 };
> 
>                 twl_audio: audio {
>                         compatible = "ti,twl4030-audio";
>                         codec {
>                         };
>                 };
>         };
> };
> 
> However, if it were compiled into a separate dtb overlay it might look
> like this:
> 
> / {
>     .readonly;
>     ocp {
>         .readonly;
>         interrupt-controller@48200000 {
>             phandle = <0x1234>; /* EXPECTED PHANDLE */
>             .readonly;
>         };
>         i2c@48070000 {
>             .must-exist;
>             clock-frequency = <2600000>;
> 
>             twl@48 {
>                 reg = <0x48>;
>                 interrupts = <7>;
>                 interrupt-parent = <0x1234>;   /* RESOLVED PHANDLE */
> 
>                 vsim: regulator-vsim {
>                         compatible = "ti,twl4030-vsim";
>                         regulator-min-microvolt = <1800000>;
>                         regulator-max-microvolt = <3000000>;
>                 };
> 
>                 twl_audio: audio {
>                         compatible = "ti,twl4030-audio";
>                         codec {
>                         };
>                 };
>             };
>         };
>     };
> };
> 
> Notice I've included the intc node and it's phandle. By phandle
> validation I merely mean that when applying an overly the firmware or
> kernel must verify that the phandles in the overlay match the phandle
> in the base tree. If they don't match, then refuse to apply the
> overhead. This approach avoids the need to find and fixup phandles in
> the overlay. And if the phandle is generated from a hash of the
> full_name, then the resulting phandle will only change if the node
> moves.
> 
> Similarly, at application time it should be verified that the nodes
> with a .readonly or .must-exist property could be verified to actually
> exist before attempting to apply the overlay. I used two different
> properties with the idea that only certain nodes would need to be
> modified... exactly what the policies should be is yet to be
> determined.

Ok, I see.  I really don't like it much, but I understand.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
