From: Michael Welling <mwelling@emacinc.com>
Subject: Re: TSC2004 driver
Date: Wed, 6 Aug 2014 17:13:19 -0500
Message-ID: <CAO5Z=i1YMBP8mbyh=ESbsJLkHZqZik+tw-aF1FWR1etaBrBN1g@mail.gmail.com>
References: <20140805170640.GA8830@sysresccd>
	<20140806193727.GB24718@core.coreip.homeip.net>
	<CAGhQ9Vy7AhWkAR3ZMxoWnbZ_zpOPvqcL93fqQ=YkpuULO3MVzQ@mail.gmail.com>
	<20140806211626.GC22889@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20140806211626.GC22889@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joachim Eastwood <manabian@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 6, 2014 at 4:16 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Aug 06, 2014 at 10:33:18PM +0200, Joachim Eastwood wrote:
>> On 6 August 2014 21:37, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> > Hi Michael,
>> >
>> > On Tue, Aug 05, 2014 at 12:06:40PM -0500, Michael Welling wrote:
>> >> The TSC2004 driver has yet to appear in the mainline kernel. We have
>> >> been using the driver referenced here as provided by TI:
>> >>
>> >> https://www.mail-archive.com/linux-omap@vger.kernel.org/msg22018.html
>> >>
>> >> Are there any plans of supporting this device in the mainline kernel?
>> >
>> > I still believe that support for TSC2004 should be added 5to tsc2007, they are
>> > too much alike to be separate drivers.
>>
>> I tried to add tsc2004 support to the tsc2007 driver but I didn't
>> really get it to work properly because the tsc2007 interrupt handling
>> differs from what tsc2004 needs.
>
> OK.
>
>>
>> I think it would be better to add tsc2004 support to the tsc2005
>> driver. They only difference between those two chips is the interface
>> (i2c vs spi). If regmap was added to tsc2005 I think it should be easy
>> to support tsc2004.
>
> That would also be acceptable.

The tsc2005 still needs devicetree conversion, so it is at least 2 patches away
from where I can use it.

I have missed the window for my companies OE release so I doubt I will
have time to code
in all or any of this.

I am in the process of routing a AM335x SoM which obsoletes this AM3517 one
so my resources will be elsewhere.

>
> Thanks.
>
> --
> Dmitry
