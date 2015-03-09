From: Bin Liu <binmlist@gmail.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 16:35:28 -0500
Message-ID: <CADYTM3ZW5e5dCQbbaE02o7wxOC26+jo5Ddo+2B4Q6UCAT2pTdQ@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com>
	<CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
	<20150309211306.GC22341@saruman.tx.rr.com>
	<CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
	<20150309212014.GE22341@saruman.tx.rr.com>
	<20150309212622.GJ5264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309212622.GJ5264@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 9, 2015 at 4:26 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Balbi <balbi@ti.com> [150309 14:21]:
>> On Mon, Mar 09, 2015 at 04:17:29PM -0500, Bin Liu wrote:
>> > On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi@ti.com> wrote:
>> > > On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
>> > >> Hi,
>> > >>
>> > >> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > >> > Add a minimal driver for dm816x USB. Otherwise we can just use
>> > >> > the existing musb_am335x and musb_dsps on dm816x.
>> > >>
>> > >> dm816x has the almost identical usbss as that in am335x, we should be
>> > >> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
>> > >
>> > > Tony's using the same musb glue layers, this is just a phy driver,
>> > > right ?
>> >
>> > Can the current am335x phy driver be adopted too? I remember it is
>> > under drivers/usb/phy/.
>>
>> Tony will be best to answer, but according to our IRC discussions, it's
>> too different. Tony ?
>
> Well we should check again between dm814x and am335x documentation
> against the $subject driver as the dm816x docs were buggy and I may
> have gotten a wrong idea initially.

Will it make our life a little easier by comparing the usb drivers for
dm81xx and am335x in previous TI kernel releases? I cam dig out the
source code if that helps.

Regards,
-Bin,

>
> Regards,
>
> Tony
