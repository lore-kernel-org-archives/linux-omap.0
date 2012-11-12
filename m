From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices
 to mach-omap2)
Date: Mon, 12 Nov 2012 09:45:45 -0700
Message-ID: <50A127B9.1000601@wwwdotorg.org>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <50999145.2070306@wwwdotorg.org> <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6v=+8UKerzp9z5cZo6TbXJQ4Nb=fpKgfkuvib_B-BoVdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Rob Herring <robherring2@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

On 11/09/2012 09:28 AM, Grant Likely wrote:
> On Tue, Nov 6, 2012 at 10:37 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/05/2012 01:40 PM, Grant Likely wrote:
>>> Hey folks,
>>>
>>> As promised, here is my early draft to try and capture what device
>>> tree overlays need to do and how to get there. Comments and
>>> suggestions greatly appreciated.
>>
>> Interesting. This just came up internally at NVIDIA within the last
>> couple weeks, and was discussed on the U-Boot mailing list very recently
>> too:
>>
>> http://lists.denx.de/pipermail/u-boot/2012-October/thread.html#138227
>> (it spills into the November archive too)
>>
>>> For these cases it is proposed to implement an overlay feature for the
>>> so that the initial device tree data can be modified by userspace at
>>
>> I don't know if you're maintaining this as a document and taking patches
>> to it, but if so:
> 
> Sure, why not...
> 
> http://git.secretlab.ca/?p=devicetree-overlays.git;a=summary
> 
>>
>> "for the so" split across those two lines.
> 
> fixed
> 
>>>   - SHOULD reliably handle changes between different underlying overlays
>>>     (ie. what happens to existing .dtb overly files if the structure of
>>>     the dtb it is layered over changes. If not possible, then SHALL
>>>     detect when the base tree doesn't match and refuse to apply the
>>>     overlay.
>>
>> Perhaps use (versioned) DT bindings to represent the interface between
>> the two .dts files? See the links to the U-Boot mailing list discussions
>> below?
> 
> Implementing versioning is conceptually a lot more complex than plain
> overlays since it means either the kernel or u-boot needs to start
> filtering the data that it's given. This can get really complex in a
> hurry. Mitch makes a valid point later in this thread that when it
> comes to manipulating the data depending on the board then the data
> overlay model alone doesn't handle it well.

What I was thinking of sounds a lot simpler than what I think you're
responding to.

All I was thinking about was that we define some kind of explicit
interface between .dts files, e.g. some kind of direct representation of
the connector between the boards.

The versioning aspect is then:

Then, when the connector design changes, we change the naming of that
interface representation. This would happen in just the same way that
we'd name/represent the connector design of a BeagleBone differently
from that of an Arduino.

So, perhaps we start out with:

ti,beaglebone-cape-connector
arduino,shield-connector

and later end up with:

ti,beaglebone-cape-connector-v2

as far as any code that handled/references the v1/v2 interface
definitions, they'd probably be completely unrelated types in the
general case, just named very similarly.
