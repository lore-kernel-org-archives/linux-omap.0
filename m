From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving
 omap_devices to mach-omap2)
Date: Mon, 12 Nov 2012 09:54:02 -0700
Message-ID: <50A129AA.70406@wwwdotorg.org>
References: <1352666833.20434.5@driftwood>
 <ABAD0875-A618-405D-954F-CD76F09DDF04@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <ABAD0875-A618-405D-954F-CD76F09DDF04-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
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
To: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Deepak Saxena <dsaxena-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2012 05:50 AM, Pantelis Antoniou wrote:
> Hi Rob.
> 
> On Nov 11, 2012, at 10:47 PM, Rob Landley wrote:
> 
>>              On 11/09/2012 10:28:59 AM, Grant Likely wrote:
>>> On Tue, Nov 6, 2012 at 10:37 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>>> On 11/05/2012 01:40 PM, Grant Likely wrote:
>>> I'm not actually opposed to it, but it needs to be done in an elegant
>>> way. The DT data model already imposes more of a conceptual learning
>>> curve than I wish it did and I don't want to make that worse with a
>>> versioning model that is difficult to get ones head around.
>>
>> Speaking of which...
>>
>> I want to poke at board emulation in qemu, from scratch. Specifically, I want to start with an unpopulated board (just the processor), add a block of physical memory and a serial device, and boot an initramfs in there with stdin/stdout. Then I want to incrementally add an RTC, network card, and three block devices.
>>
>> I'd like to define this board by giving qemu and the kernel the same device tree they can parse, and I'd like to _build_ this device tree so I understand what's in it. I'd like to repeat this exercize for arm, mips, ppc, x86, x86-64, sparc, sh4, and maybe other boards.
>>
>> And I'd like to write up an article on doing it as a learning exercise.
>>
>> Last time I checked, doing this wasn't possible. (qemu couldn't define a board by parsing a device tree, the kernel used the device tree as a guideline but it only really read data the drivers you linked in were expecting, the only documentation about what any of the nodes were was was read the other device trees as examples or read the source code of the drivers looking for data in the tree...)
>>
>> Is it a more realistic project now? If so, where would I start? (Once upon a time I read the booting-without-of document, back when it lived in the ppc directory. It didn't really say what should go in any of the nodes.)
>>
>> Rob
> 
> It should be possible when the stuff we're talking about is ready.
> 
> I don't know what you'll find is broken during the exercise, but I guess
> your article is going to be entertaining at least :)

To be honest, I think Rob's proposal should be possible irrespective of
this conversation; if he wants to simply define the HW structure once
before running qemu, then none of this overlay discussion is relevant.

Perhaps the missing piece is the Documentation/devicetree/bindings/
directory?
