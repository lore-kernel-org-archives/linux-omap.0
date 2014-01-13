From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 21:11:30 +0000
Message-ID: <20140113211130.GG27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <20140108012110.GL5074@atomide.com> <20140109152437.GB27282@n2100.arm.linux.org.uk> <20140113141811.GD27282@n2100.arm.linux.org.uk> <20140113173744.GA7746@atomide.com> <20140113185503.GE27282@n2100.arm.linux.org.uk> <20140113192630.GB7746@atomide.com> <20140113203404.GF27282@n2100.arm.linux.org.uk> <20140113210242.GA7993@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35965 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752380AbaAMVLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 16:11:38 -0500
Content-Disposition: inline
In-Reply-To: <20140113210242.GA7993@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 13, 2014 at 01:02:42PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 12:36]:
> > On Mon, Jan 13, 2014 at 11:26:31AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 10:57=
]:
> > > > On Mon, Jan 13, 2014 at 09:37:45AM -0800, Tony Lindgren wrote:
> > > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 0=
8:48]:
> > > > > > Any news on this?
> > > > >=20
> > > > > Sorry for the delay, now getting this:
> > > > >=20
> > > > > arch/arm/mach-omap1/dma.c: In function =E2=80=98omap1_system_=
dma_init=E2=80=99:
> > > > > arch/arm/mach-omap1/dma.c:368: error: =E2=80=98struct omap_dm=
a_dev_attr=E2=80=99 has no member named =E2=80=98chan=E2=80=99
> > > >=20
> > > > Gah.  Next incremental patch:
> > >=20
> > > Thanks, now getting this on omap1:
> > >=20
> > > # dmesg | grep -i dma
> > > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > > OMAP DMA hardware version 1
> > > DMA capabilities: 0000000c:00000000:01ff:003f:007f
> > > omap-dma-engine omap-dma-engine: invalid resource
> > > omap-dma-engine: probe of omap-dma-engine failed with error -22
> > > mmci-omap mmci-omap.1: unable to obtain TX DMA engine channel 54
> > > mmci-omap mmci-omap.1: unable to obtain RX DMA engine channel 55
> >=20
> > Sigh... let's give it the iomem resource then:
>=20
> OK, looks like adding that makes MMC card detection to fail with:
>=20
> DMA timeout with device 55

You should also see a message:

oma-dma-engine omap-dma-engine: failed to get L1 IRQ: ..

which indicates that it's falling back to the old driver for IRQ
servicing.  Can you confirm that please?

--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
