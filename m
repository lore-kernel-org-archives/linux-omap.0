From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Sun, 16 Oct 2011 13:32:05 -0500
Message-ID: <CAPCu-pThH6K10MExTZH0jhZC3VnWsj7c-QN=8iy5xV+OaiThbQ@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<20110414223036.GA7335@n2100.arm.linux.org.uk>
	<BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
	<20110428134055.GA19709@n2100.arm.linux.org.uk>
	<BANLkTikKnE-9WncNCADKfZVqkP1LFPYeXA@mail.gmail.com>
	<CADysL2bp08WP798_MvUJthGi9ACySDE=Dc_BM9Vd0A=YcKpm+Q@mail.gmail.com>
	<20110811222940.GA26209@n2100.arm.linux.org.uk>
	<CADysL2Z9XfQNgY3spOaC9yK-gb1dL+87j14R85izF0dY29ah0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADysL2Z9XfQNgY3spOaC9yK-gb1dL+87j14R85izF0dY29ah0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Ohad Ben-Cohen <ohad@wizery.com>, Subin Gangadharan <subin.kg@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

On Fri, Aug 12, 2011 at 11:05 AM, Gupta, Ramesh <grgupta@ti.com> wrote:
>
> On Thu, Aug 11, 2011 at 5:29 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Aug 11, 2011 at 02:28:39PM -0500, Gupta, Ramesh wrote:
> >> Hi Russel,
> >
> > grr.
>
> Sorry, typo.
>
> >
> >> On Thu, Apr 28, 2011 at 11:48 AM, Gupta, Ramesh <grgupta@ti.com> w=
rote:
> >> > Hi Russel,
> >> >
> >> > On Thu, Apr 28, 2011 at 8:40 AM, Russell King - ARM Linux
> >> > <linux@arm.linux.org.uk> wrote:
> >> >> We _could_ invent a new API to deal with this, which is probabl=
y going
> >> >> to be far better in the longer term for page table based iommus=
=2E =C2=A0That's
> >> >> going to need some thought - eg, do we need to pass a struct de=
vice
> >> >> argument for the iommu cache flushing so we know whether we nee=
d to flush
> >> >> or not (eg, if we have cache coherent iommus)...
> >>
> >> my apologies for a late mail on this topic.
> >>
> >> do you think of any other requirements for this new API?
> >>
> >> Could we use the existing dmac_flush_range(), outer_flush_range()
> >> for this purpose instead of a new API?
> >>
> >> I see a comment in the arch/arm/include/asm/cacheflush.h
> >> for =C2=A0_not_ to use these APIs directly, but I am not really un=
derstand
> >> the reason for that.
> >
> > When I create APIs, I create them to solve a _purpose_ to code whic=
h wants
> > to do something. =C2=A0They're not created to provide some facility=
 which can
> > be re-used for unrelated stuff.
> >
> > This has been proven many times to be the correct approach. =C2=A0O=
ver time,
> > things change.
> >
>
> I agree.
>
> > Let's say for arguments sake that you decide to use the DMA API stu=
ff
> > to achieve your goals. =C2=A0Then, lets say that ARM DMA becomes fu=
lly
> > cache coherent, but your IOMMU tables still need to be flushed from
> > the L1 caches.
> >
> > Suddenly, dmac_flush_range() starts doing absolutely nothing. =C2=A0=
Your
> > driver breaks. =C2=A0I get whinged at because a previously working =
driver
> > stops working. =C2=A0In effect, that usage _prevents_ me making the=
 changes
> > necessary to keep the core architecture support moving forward as
> > things develop. =C2=A0Or, alternatively I just ignore your driver, =
make the
> > changes anyway and leave it to rot.
> >
> > So, APIs get created to provide a purpose. =C2=A0Like - handling th=
e DMA
> > issues when mapping a buffer to DMA. =C2=A0Like handling the DMA is=
sues
> > when unmapping a buffer from DMA. =C2=A0If you start using those _b=
ecause_
> > they happen to clean or invalidate the cache for you, you're really
> > asking for your driver to be broken at some point in the future.
> >
> > What is far better to do is to ensure that we have the right APIs i=
n
> > place for the purposes for which they are to be used. =C2=A0So, if =
we need
> > an API to flush out the IOMMU page table entries, then that's what
> > we need, not some bodged lets-reuse-the-dma-flushing-functions thin=
g.
> > Inside the processors implementation, yes, it may well be the same
> > thing, but that's a decision for the _processor_ support code to ma=
ke,
> > not the IOMMU writer.
>
> I completely agree, thank you for explaining the need to use the corr=
ect API.
>
=46ollowing what you suggested, we looked at the cache flush APIs
available (for v7).
There is a v7_flush_kern_dcache_area that does the same job (from what
I  understand), as
the dma_inv_range. I have a patch that I have validated for OMAP4, to
use this API to flush
iommu pte/pgd entries. I would like to know your opinion before I send
out the patch.

>
> > As to what shape a new API should be - as I said above, maybe it sh=
ould
> > take a struct device argument, virtual base address and size. =C2=A0=
Or maybe
> > if we don't have any coherent IOMMUs then just ignore the device
> > argument for the time being, and just pass the virtual base address=
 and
> > size.
> >
> > The next issue is whether it should require the virtual base addres=
s to
> > be in the kernel direct mapped region. =C2=A0If you're touching L2,=
 then
> > that's a yes, because we need to use virt_to_phys on it to get at t=
he
> > phys address for the L2 operations.
> >
> > So, I think: extend the cpu cache operations structure to have a me=
thod
> > for dealing with IOMMUs. =C2=A0Add an inline function to deal with =
calling
> > that, and the L2 ops if that's what's required.
>
> Once again thanks for the API requirements, I will work on this and s=
end
> the patches for review.
>
> Regards
> Ramesh Gupta G
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--

Thank you and Regards
Subbu
