From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Mon, 12 Nov 2012 14:10:16 +0200
Message-ID: <5B124797-6DFD-4C5E-90D7-665AFD4A7873@antoniou-consulting.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <50999145.2070306@wwwdotorg.org>
 <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com>
 <509D9089.7020407@wwwdotorg.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <509D9089.7020407-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Nov 10, 2012, at 1:23 AM, Stephen Warren wrote:

> On 11/09/2012 09:28 AM, Grant Likely wrote:
>> On Tue, Nov 6, 2012 at 10:37 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> ...
>>> I do rather suspect this use-case is quite common. NVIDIA certainly has
>>> a bunch of development boards with pluggable
>>> PMIC/audio/WiFi/display/..., and I believe there's some ability to
>>> re-use the pluggable components with a variety of base-boards.
>>> 
>>> Given people within NVIDIA started talking about this recently, I asked
>>> them to enumerate all the boards we have that support pluggable
>>> components, and how common it is that some boards support being plugged
>>> into different main boards. I don't know when that enumeration will
>>> complete (or even start) but hopefully I can provide some feedback on
>>> how common the use-case is for us once it's done.
>> 
>> From your perspective, is it important to use the exact same .dtb
>> overlays for those add-on boards, or is it okay to have a separate
>> build of the overlay for each base tree?
> 
> I certainly think it'd be extremely beneficial to use the exact same
> child board .dtb with arbitrary base boards.
> 

Oh yes. In fact if one was to use a single kernel image for beagleboard
and beaglebone, for the cape to work for both, it is required for it's
dtb to be compatible. 

We're not there yet, but people would like to have an upgrade path.

beaglebone -> beagleboard -> pandaboard -> future-boards

It is not possible yet, but perhaps newer boards could have that.

> Consider something like the Arduino shield connector format, which I
> /believe/ has been re-used across a wide variety of Arduino boards and
> other compatible or imitation boards. Now consider a vendor of an
> Arduino shield. The shield vendor probably wants to publish a single
> .dtb file that works for users irrespective of which board they're using
> it with.
> 
> (Well, I'm not sure that Arduino can run Linux; perhaps that's why you
> picked BeagleBone capes for your document!)
> 

Arduino can't possible do it. Using arduino shields with an adapter could
be possible though.

> I suppose it would be acceptable for the shield vendor to ship the .dts
> file rather than the .dtb, and hence need to build the shield .dtb for a
> specific base board.
> 
> However, I think the process for an end-user needs to be as simple as
> "drop this .dts/.dtb file into some standard directory", and I imagine
> it'll be much easier for distros/... to make that process work if
> they're dealing with a .dtb that they can just blast into the kernel's
> firmware loader interface, rather than having to also locate the
> base-board .dts/.dtb file, and run dtc and/or other tools on both .dts
> files together.

Yes. A single supported dtb is the way to go ideally.

Regards

-- Pantelis
