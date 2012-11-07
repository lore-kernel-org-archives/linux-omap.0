From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Wed, 7 Nov 2012 23:10:34 +0100
Message-ID: <37BFD75A-5A27-4E3F-A494-A0707E48B236@antoniou-consulting.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com>
 <02FF5400-9F97-4B8A-AEF0-267B01C8099F@antoniou-consulting.com>
 <CACxGe6vDzmPWsOZ53HTwkYmDEivg9TpnRrvudY2FK95V06O24w@mail.gmail.com>
 <A5170602-2AE7-4EC4-BE0F-0DF015A287D7@antoniou-consulting.com>
 <CACxGe6sJXubOSGGg5AmDK6DQMjv60H44nax9wUnnCGsqXGbfxw@mail.gmail.com>
 <5ED17D42-07B8-4D4F-B54F-82B4CC60584C@antoniou-consulting.com>
 <509A3595.7050600@ti.com> <509A9984.3000709@wwwdotorg.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <509A9984.3000709-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Nov 7, 2012, at 6:25 PM, Stephen Warren wrote:

> On 11/07/2012 03:19 AM, Benoit Cousson wrote:
>> Hi Panto,
>> 
>> On 11/07/2012 09:13 AM, Pantelis Antoniou wrote:
>>> Hi Grant
>>> 
>>> On Nov 6, 2012, at 9:45 PM, Grant Likely wrote:
>>> 
>>>> On Tue, Nov 6, 2012 at 7:34 PM, Pantelis Antoniou
>>>> <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org> wrote:
>>> 
>>> [ snip ]
>>>> 
>>>> g.
>>> 
>>> Since we've started talking about longer term goals, and the versioning
>>> provision seems to stand, I hope we address how much the fragment versioning
>>> thing is similar to the way board revisions progress.
>>> 
>>> If a versioning syntax is available then one could create a single DT 
>>> file for a bunch of 'almost' similar board and board revisions.
>> 
>> I even think that the version issue is probably much more important for the short term than the overlay aspect. Well at least as important. We start having as well a bunch a panda board version with different HW setup.
>> 
>> Having a single board-XXX.dts that will support all these versions is probably the best approach to avoid choosing that from the bootloader.
>> 
>> We need to figure out a format + mechanism compatible with the current non-versioned format to allow filtering the nodes at runtime to keep only the relevant one.
>> 
>> Something that can find the driver that will provide the proper board version or subsystem version or whatever like that:
>> 
>> 	compatible-version = "ti,panda-version", "panda";
>> 
>> Then at runtime we should create only the node with the correct match between the driver version and the string version.
>> 
>> 
>> /* regular panda audio routing */
>> sound: sound {
>> 	compatible = "ti,abe-twl6040";
>> 	ti,model = "PandaBoard";
>> 	compatible-version = "ti,panda-version", "panda";
>> 
>> 	/* Audio routing */
>> 	ti,audio-routing =
>> 		"Headset Stereophone", "HSOL",
>> 		"Headset Stereophone", "HSOR",
>> 		"Ext Spk", "HFL",
>> 		"Ext Spk", "HFR",
>> 		"Line Out", "AUXL",
>> 		"Line Out", "AUXR",
>> 		"HSMIC", "Headset Mic",
>> 		"Headset Mic", "Headset Mic Bias",
>> 		"AFML", "Line In",
>> 		"AFMR", "Line In";
>> };
>> 
>> 
>> /* Audio routing is different between PandaBoard4430 and PandaBoardES */
>> &sound {
>> 	ti,model = "PandaBoardES";
>> 	compatible-version = "ti,panda-version", "panda-es";
>> 
>> 	/* Audio routing */
>> 	ti,audio-routing =
>> 		"Headset Stereophone", "HSOL",
>> 		"Headset Stereophone", "HSOR",
>> 		"Ext Spk", "HFL",
>> 		"Ext Spk", "HFR",
>> 		"Line Out", "AUXL",
>> 		"Line Out", "AUXR",
>> 		"AFML", "Line In",
>> 		"AFMR", "Line In";
>> };
>> 
>> 
>> Maybe some extra version match table can just be passed during the board machine_init 
>> 
>> 	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL, panda_version_match_table);
> 
> Is the only difference here the content of the ti,audio-routing
> property? If so, then I don't think there's any need for infra-structure
> for this; the driver code already reads that property and adjusts its
> behaviour based upon it.
> 
> I do see that "Headset Mic" exists only in one of the tables above.
> Perhaps the driver could scan the routing table, and only create the
> ASoC object for the headset if it's mentioned in the routing table?
> 
> If there are additional differences, then you can always use the .data
> field in of_device_id to automatically associate some configuration data
> with different compatible values.
> 
> Even better might be to extend the binding so that all HW differences
> are represented explicitly as properties; that way you wouldn't even
> need different compatible values.

I think that perhaps the choice of the SoC specific driver was unfortunate.

There are cases where a standard driver should be configured differently
depending on the board revision/model. In that case per-revision 
driver changes are out of the question.

Regards

-- Pantelis
