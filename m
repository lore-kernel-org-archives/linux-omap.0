From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: am335x-evm: Add blue-and-red-wiring
 -property to lcdc node
Date: Mon, 19 Sep 2016 10:55:12 +0300
Message-ID: <3052854a-de30-0e6d-3084-6788733c7118@ti.com>
References: <cover.1474025756.git.jsarha@ti.com>
 <34893e286d16c281098063d2a4fec985acbf8818.1474025756.git.jsarha@ti.com>
 <a0e00898-80fb-8242-aafb-6e4d3f650345@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a0e00898-80fb-8242-aafb-6e4d3f650345-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/17/16 01:17, Nishanth Menon wrote:
> On 09/16/2016 06:50 AM, Jyri Sarha wrote:
> [..]
>> +    blue-and-red-wiring = "crossed";
> 
> Dumb question: Why is this a Linux generic property - does it make sense
> to have "blue-and-red-wiring" as a Linux generic property? I mean, it
> reminds me little of those movies "cut the blue or red wire to diffuse
> the bomb" ;)

It is a property of "ti,tilcdc" node. I did not think I should add a ti
specific prefix for it. And after all if some other SoC or display chip
has the same bug (eg. blue and red colour components swapped between two
different colour modes), they could use the same property.

Of course in theory, if such bugs were common, a generic property that
would describe how connections between different display data wires are
drawn could make sense, but AFAIK am335x is the only one out there with
such a bug [1].

> 
> "The am335x-evm has blue and red wires crossed to get 24-bit RGB (and
> 16-bit BGR". I mean, there has to be some sort of better description
> specific to lcdc if some product used yellow and green wires for the
> same signals crossed?
> 

The property and why it is there is described in detail in the binding
document referred to in the commit description.

The functional patches, with the binding document can be found here:
http://www.spinics.net/lists/devicetree/msg141246.html

[1] For more details see section 3.1.1 in AM335x Silicon Errata:
http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
