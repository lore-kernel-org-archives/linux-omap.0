From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Tue, 19 Apr 2011 14:01:34 +0200
Message-ID: <201104191401.34818.arnd@arndb.de>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com> <201104181613.43572.arnd@arndb.de> <BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57662 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab1DSMB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 08:01:56 -0400
In-Reply-To: <BANLkTi=dpqMFjW_B5-YsmoCJf62b8djj5g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Tuesday 19 April 2011, Kyungmin Park wrote:
> On Mon, Apr 18, 2011 at 11:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 18 April 2011, Kyungmin Park wrote:
> >> On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> >
> >> > One missing piece is still a way for a platform to provide both
> >> > the iommu and the dma-mapping API in a unified driver. Right now,
> >> > you have to export both interface for a generic solution.
> >>
> >> Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
> >> implementation into mm, but MM did't accept it.
> >
> > I'm confused. What do you mean with MM?
> linux/mm, Memory Management.

I'm still confused. What were you suggesting to merge in there?
Do you have a link to a mailing list discussion?

	Arnd
