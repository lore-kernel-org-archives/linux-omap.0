From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Tue, 29 May 2012 21:23:24 +0530
Message-ID: <CADysL2baNXFSTzJLWS0a8UUMkF+8u4LnO9WONYCAZ9RRhrPjSQ@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
	<20110428134055.GA19709@n2100.arm.linux.org.uk>
	<BANLkTikKnE-9WncNCADKfZVqkP1LFPYeXA@mail.gmail.com>
	<CADysL2bp08WP798_MvUJthGi9ACySDE=Dc_BM9Vd0A=YcKpm+Q@mail.gmail.com>
	<20110811222940.GA26209@n2100.arm.linux.org.uk>
	<CADysL2Z9XfQNgY3spOaC9yK-gb1dL+87j14R85izF0dY29ah0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADysL2Z9XfQNgY3spOaC9yK-gb1dL+87j14R85izF0dY29ah0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Russell,


On Fri, Aug 12, 2011 at 9:35 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> On Thu, Aug 11, 2011 at 5:29 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Aug 11, 2011 at 02:28:39PM -0500, Gupta, Ramesh wrote:
>>> Hi Russel,
>>
>> grr.
>
> Sorry, typo.
>
>>
>>> On Thu, Apr 28, 2011 at 11:48 AM, Gupta, Ramesh <grgupta@ti.com> wr=
ote:
>>> > Hi Russel,
>>> >
>>> > On Thu, Apr 28, 2011 at 8:40 AM, Russell King - ARM Linux
>>> > <linux@arm.linux.org.uk> wrote:
>>> >> We _could_ invent a new API to deal with this, which is probably=
 going
>>> >> to be far better in the longer term for page table based iommus.=
 =A0That's
>>> >> going to need some thought - eg, do we need to pass a struct dev=
ice
>>> >> argument for the iommu cache flushing so we know whether we need=
 to flush
>>> >> or not (eg, if we have cache coherent iommus)...
>>>
>>> my apologies for a late mail on this topic.
>>>
>>> do you think of any other requirements for this new API?
>>>
>>> Could we use the existing dmac_flush_range(), outer_flush_range()
>>> for this purpose instead of a new API?
>>>
>>> I see a comment in the arch/arm/include/asm/cacheflush.h
>>> for =A0_not_ to use these APIs directly, but I am not really unders=
tand
>>> the reason for that.
>>
>> When I create APIs, I create them to solve a _purpose_ to code which=
 wants
>> to do something. =A0They're not created to provide some facility whi=
ch can
>> be re-used for unrelated stuff.
>>
>> This has been proven many times to be the correct approach. =A0Over =
time,
>> things change.
>>
>
> I agree.
>
>> Let's say for arguments sake that you decide to use the DMA API stuf=
f
>> to achieve your goals. =A0Then, lets say that ARM DMA becomes fully
>> cache coherent, but your IOMMU tables still need to be flushed from
>> the L1 caches.
>>
>> Suddenly, dmac_flush_range() starts doing absolutely nothing. =A0You=
r
>> driver breaks. =A0I get whinged at because a previously working driv=
er
>> stops working. =A0In effect, that usage _prevents_ me making the cha=
nges
>> necessary to keep the core architecture support moving forward as
>> things develop. =A0Or, alternatively I just ignore your driver, make=
 the
>> changes anyway and leave it to rot.
>>
>> So, APIs get created to provide a purpose. =A0Like - handling the DM=
A
>> issues when mapping a buffer to DMA. =A0Like handling the DMA issues
>> when unmapping a buffer from DMA. =A0If you start using those _becau=
se_
>> they happen to clean or invalidate the cache for you, you're really
>> asking for your driver to be broken at some point in the future.
>>
>> What is far better to do is to ensure that we have the right APIs in
>> place for the purposes for which they are to be used. =A0So, if we n=
eed
>> an API to flush out the IOMMU page table entries, then that's what
>> we need, not some bodged lets-reuse-the-dma-flushing-functions thing=
=2E
>> Inside the processors implementation, yes, it may well be the same
>> thing, but that's a decision for the _processor_ support code to mak=
e,
>> not the IOMMU writer.
>
> I completely agree, thank you for explaining the need to use the corr=
ect API.
>
>
>> As to what shape a new API should be - as I said above, maybe it sho=
uld
>> take a struct device argument, virtual base address and size. =A0Or =
maybe
>> if we don't have any coherent IOMMUs then just ignore the device
>> argument for the time being, and just pass the virtual base address =
and
>> size.
>>
>> The next issue is whether it should require the virtual base address=
 to
>> be in the kernel direct mapped region. =A0If you're touching L2, the=
n
>> that's a yes, because we need to use virt_to_phys on it to get at th=
e
>> phys address for the L2 operations.
>>
>> So, I think: extend the cpu cache operations structure to have a met=
hod
>> for dealing with IOMMUs. =A0Add an inline function to deal with call=
ing
>> that, and the L2 ops if that's what's required.

my apologies for a late response. I have posted a patch for a new L1
cache maintenance api for handling iommu as you suggested. I will send
iommu patches to use this api.

Thank you and regards
Ramesh Gupta G
