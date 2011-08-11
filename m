From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Thu, 11 Aug 2011 14:28:39 -0500
Message-ID: <CADysL2bp08WP798_MvUJthGi9ACySDE=Dc_BM9Vd0A=YcKpm+Q@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
	<20110428134055.GA19709@n2100.arm.linux.org.uk>
	<BANLkTikKnE-9WncNCADKfZVqkP1LFPYeXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTikKnE-9WncNCADKfZVqkP1LFPYeXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Hi Russel,


On Thu, Apr 28, 2011 at 11:48 AM, Gupta, Ramesh <grgupta@ti.com> wrote:
> Hi Russel,
>
> On Thu, Apr 28, 2011 at 8:40 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Apr 15, 2011 at 06:26:40AM -0500, Gupta, Ramesh wrote:
>>> Russell,
>>>
>>> On Thu, Apr 14, 2011 at 5:30 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wr=
ote:
>>> >> From: Ramesh Gupta <grgupta@ti.com>
>>> >>
>>> >> This patch is to flush the iommu page table entries from L1 and =
L2
>>> >> caches using dma_map_single. This also simplifies the implementa=
tion
>>> >> by removing the functions =A0flush_iopgd_range/flush_iopte_range=
=2E
>>> >
>>> > No. =A0This usage is just wrong. =A0If you're going to use the DM=
A API then
>>> > unmap it, otherwise the DMA API debugging will go awol.
>>> >
>>>
>>> Thank you for the comments, this particular memory is always a writ=
e
>>> from the A9 for MMU programming and
>>> only read from the slave processor, that is the reason for not call=
ing
>>> the unmap. I can re-look into the changes to call
>>> unmap in a proper way as this impacts the DMA API.
>>> Are there any other ways to perform only flush the memory from L1/L=
2 caches?
>>
>> We _could_ invent a new API to deal with this, which is probably goi=
ng
>> to be far better in the longer term for page table based iommus. =A0=
That's
>> going to need some thought - eg, do we need to pass a struct device
>> argument for the iommu cache flushing so we know whether we need to =
flush
>> or not (eg, if we have cache coherent iommus)...

my apologies for a late mail on this topic.

do you think of any other requirements for this new API?

Could we use the existing dmac_flush_range(), outer_flush_range()
for this purpose instead of a new API?

I see a comment in the arch/arm/include/asm/cacheflush.h
for  _not_ to use these APIs directly, but I am not really understand
the reason for that.

I would appreciate any inputs on this.

thank you and regards
Ramesh Gupta G
