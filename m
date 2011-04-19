From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Tue, 19 Apr 2011 15:11:39 +0200
Message-ID: <201104191511.39370.arnd@arndb.de>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com> <201104191401.34818.arnd@arndb.de> <BANLkTim_30SbVhPLFOaq-KYwz5N6NGCe6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTim_30SbVhPLFOaq-KYwz5N6NGCe6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 April 2011, Kyungmin Park wrote:
> On Tue, Apr 19, 2011 at 9:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 19 April 2011, Kyungmin Park wrote:
> >> On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Monday 18 April 2011, Kyungmin Park wrote:
> >> >> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> >
> >> >> > One missing piece is still a way for a platform to provide both
> >> >> > the iommu and the dma-mapping API in a unified driver. Right now,
> >> >> > you have to export both interface for a generic solution.
> >> >>
> >> >> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
> >> >> implementation into mm, but MM did't accept it.
> >> >
> >> > I'm confused. What do you mean with MM?
> >> linux/mm, Memory Management.
> >
> > I'm still confused. What were you suggesting to merge in there?
> > Do you have a link to a mailing list discussion?
> 
> First, Zach Pfeffer <zpfeffer@codeaurora.org> sent the patch
> https://patchwork.kernel.org/patch/108736/
> 
> Second, Michal tried it.
> http://lkml.org/lkml/2010/9/6/41
> 
> http://lwn.net/Articles/403643/
> https://patchwork.kernel.org/patch/157451/

Ah, I did not realize you were talking about VCMM. I believe the main
reason what that patch was not received well is that it tried to add
yet another abstraction for IOMMUs when we already have too many of them.

It is essentially doing the opposite of what I was referring to above:
If we had added VCMM, each platform that has IOMMUs would now have to 
implement three interfaces: dma-mapping.h (struct dma_map_ops),
iommu.h (struct iommu_ops) and and vcm_driver.h (struct vcm_driver).

What I really meant was to unify the two we already have, so that
a platform only needs to implement e.g. iommu_ops and get the dma_mapping.h
interfaces for free.

	Arnd
