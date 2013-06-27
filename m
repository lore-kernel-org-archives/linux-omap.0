From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] Documentation: dt: bindings: TI WiLink modules
Date: Thu, 27 Jun 2013 08:39:40 -0500
Message-ID: <CAGo_u6pWZX9gbHgBae=gcWk8i6-TnhxH1TdM9QdEDLTow6Pn5A@mail.gmail.com>
References: <1372149330-24335-1-git-send-email-coelho@ti.com>
	<51CBC1C8.1040301@gmail.com>
	<1372322851.18889.53.camel@cumari.coelho.fi>
	<20130627125131.GA27285@kahuna>
	<1372337887.8383.12.camel@cumari.coelho.fi>
	<CAGo_u6qbt9dANgKq49xR=1qsCpUBhmVaPL4EK04XvTw+=4Z23g@mail.gmail.com>
	<1372339148.8383.17.camel@cumari.coelho.fi>
	<51CC3CEE.3050004@ti.com>
	<1372339810.8383.20.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372339810.8383.20.camel@cumari.coelho.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Luciano Coelho <coelho@ti.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 27, 2013 at 8:30 AM, Luciano Coelho <coelho@ti.com> wrote:
> On Thu, 2013-06-27 at 08:23 -0500, Nishanth Menon wrote:
>> On 06/27/2013 08:19 AM, Luciano Coelho wrote:
>> > On Thu, 2013-06-27 at 08:15 -0500, Nishanth Menon wrote:
>> >> On Thu, Jun 27, 2013 at 7:58 AM, Luciano Coelho <coelho@ti.com> wrote:
>> >>> For the actual DTS files, I could add a wilink.dtsi with enumerations
>> >>> for these values so they could be used in the node definitions.  But I'm
>> >>> not sure it's going to be that valuable in the end.
>> >> The  way GPIO HIGH was defined might help to provide guidance I think :)
>> >
>> > Where? As far as I can see, the GPIO flags are defined in a bitmap.
>>
>> include/dt-bindings/gpio/gpio.h
>
> Thanks! I don't see these macros used anywhere, though.
umm... I'd think you have'nt looked deep enough / lists :)

>
>> And corresponding kernel header:
>> include/linux/of_gpio.h
>
> This seems to be a completely different thing.  This is the header that
> contains the helper functions to get GPIO-related device tree nodes,
> isn't it?
That is true, but it also contains the flag for level which needs to
be in sync with the gpio.h dts header.
>> just a hint. not saying frequencies were defined in header. for systems
>> that define frequencies - example cpufreq OPPs, clock node usage, we do
>> not use indexing to frequency, instead, that is the responsibility of
>> driver to convert frequency back to required index.
>> git grep frequency Documentation/devicetree/bindings gives you how the
>> precedence looks like.
>>
>> Personally, if given a choice, I'd go with actual frequencies rather
>> than indexes.
>
> If I do that, I need to add also a separate flag to define whether the
> XTAL clock is used or not.  For instance, we have 26MHz and 26MHz
> crystal; and 38.4MHz and 38.4MHz crystal...
Yes, you would have to. at the same time, it is easy for module maker
to provide dtsi corresponding to exact h/w representation on his
module using wilink chip without being worried about weird index value
whose meaning is hidden in binding
On the flip side, It also allows driver to reject frequencies /
configurations that are not supported by the corresponding chip.

As I said, just my 2 cents. Personally, I'd like dts files to be as
readable as c files without having to dig through bindings document.

Regards,
Nishanth Menon
