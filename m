From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 13:02:42 -0800
Message-ID: <20140113210242.GA7993@atomide.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <20140108012110.GL5074@atomide.com>
 <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
 <20140113185503.GE27282@n2100.arm.linux.org.uk>
 <20140113192630.GB7746@atomide.com>
 <20140113203404.GF27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57764 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751236AbaAMVCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jan 2014 16:02:48 -0500
Content-Disposition: inline
In-Reply-To: <20140113203404.GF27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 12:36]:
> On Mon, Jan 13, 2014 at 11:26:31AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 10:57]:
> > > On Mon, Jan 13, 2014 at 09:37:45AM -0800, Tony Lindgren wrote:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 08:=
48]:
> > > > > Any news on this?
> > > >=20
> > > > Sorry for the delay, now getting this:
> > > >=20
> > > > arch/arm/mach-omap1/dma.c: In function =E2=80=98omap1_system_dm=
a_init=E2=80=99:
> > > > arch/arm/mach-omap1/dma.c:368: error: =E2=80=98struct omap_dma_=
dev_attr=E2=80=99 has no member named =E2=80=98chan=E2=80=99
> > >=20
> > > Gah.  Next incremental patch:
> >=20
> > Thanks, now getting this on omap1:
> >=20
> > # dmesg | grep -i dma
> > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > OMAP DMA hardware version 1
> > DMA capabilities: 0000000c:00000000:01ff:003f:007f
> > omap-dma-engine omap-dma-engine: invalid resource
> > omap-dma-engine: probe of omap-dma-engine failed with error -22
> > mmci-omap mmci-omap.1: unable to obtain TX DMA engine channel 54
> > mmci-omap mmci-omap.1: unable to obtain RX DMA engine channel 55
>=20
> Sigh... let's give it the iomem resource then:

OK, looks like adding that makes MMC card detection to fail with:

DMA timeout with device 55

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
