From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2
	cache
Date: Thu, 28 Apr 2011 14:40:55 +0100
Message-ID: <20110428134055.GA19709@n2100.arm.linux.org.uk>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com> <20110414223036.GA7335@n2100.arm.linux.org.uk> <BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37238 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537Ab1D1NlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 09:41:06 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin8gugnVoai6VHC7qMgK4eKRXRtHg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Hari Kanigeri <h-kanigeri2@ti.com>

On Fri, Apr 15, 2011 at 06:26:40AM -0500, Gupta, Ramesh wrote:
> Russell,
>=20
> On Thu, Apr 14, 2011 at 5:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrot=
e:
> >> From: Ramesh Gupta <grgupta@ti.com>
> >>
> >> This patch is to flush the iommu page table entries from L1 and L2
> >> caches using dma_map_single. This also simplifies the implementati=
on
> >> by removing the functions =A0flush_iopgd_range/flush_iopte_range.
> >
> > No. =A0This usage is just wrong. =A0If you're going to use the DMA =
API then
> > unmap it, otherwise the DMA API debugging will go awol.
> >
>=20
> Thank you for the comments, this particular memory is always a write
> from the A9 for MMU programming and
> only read from the slave processor, that is the reason for not callin=
g
> the unmap. I can re-look into the changes to call
> unmap in a proper way as this impacts the DMA API.
> Are there any other ways to perform only flush the memory from L1/L2 =
caches?

We _could_ invent a new API to deal with this, which is probably going
to be far better in the longer term for page table based iommus.  That'=
s
going to need some thought - eg, do we need to pass a struct device
argument for the iommu cache flushing so we know whether we need to flu=
sh
or not (eg, if we have cache coherent iommus)...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
