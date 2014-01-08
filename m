From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Tue, 7 Jan 2014 17:21:11 -0800
Message-ID: <20140108012110.GL5074@atomide.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26879 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbaAHBVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jan 2014 20:21:17 -0500
Content-Disposition: inline
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140102 07:11]:
> The following patch series moves code to setup the DMA hardware and
> service interrupts from the hardware to the DMA engine driver.  This
> reduces the dependency on the legacy DMA implementation.
>=20
> This series does not remove the channel allocation/freeing hooks whic=
h
> are used to manage the allocation of physical channels - this is the
> next step in the evolution.
>=20
> The patches which move the interrupt handling are currently less than
> perfect since they're writing to ENABLE_L0 under a different spinlock=
,
> and hence RFC only at the moment.

Nice to see this happening. These seem to work for me based on a quick
try on omap2+, but on omap1 the build fails:

arch/arm/mach-omap1/dma.c: In function =E2=80=98dma_write=E2=80=99:
arch/arm/mach-omap1/dma.c:186: error: =E2=80=98const struct omap_dma_re=
g=E2=80=99 has no member named =E2=80=98size=E2=80=99

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
