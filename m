From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Thu, 9 Jan 2014 15:24:37 +0000
Message-ID: <20140109152437.GB27282@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <20140108012110.GL5074@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60593 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751929AbaAIPYt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 10:24:49 -0500
Content-Disposition: inline
In-Reply-To: <20140108012110.GL5074@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

On Tue, Jan 07, 2014 at 05:21:11PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [140102 07:11]:
> > The following patch series moves code to setup the DMA hardware and
> > service interrupts from the hardware to the DMA engine driver.  Thi=
s
> > reduces the dependency on the legacy DMA implementation.
> >=20
> > This series does not remove the channel allocation/freeing hooks wh=
ich
> > are used to manage the allocation of physical channels - this is th=
e
> > next step in the evolution.
> >=20
> > The patches which move the interrupt handling are currently less th=
an
> > perfect since they're writing to ENABLE_L0 under a different spinlo=
ck,
> > and hence RFC only at the moment.
>=20
> Nice to see this happening. These seem to work for me based on a quic=
k
> try on omap2+, but on omap1 the build fails:
>=20
> arch/arm/mach-omap1/dma.c: In function =E2=80=98dma_write=E2=80=99:
> arch/arm/mach-omap1/dma.c:186: error: =E2=80=98const struct omap_dma_=
reg=E2=80=99 has no member named =E2=80=98size=E2=80=99

Right, needs this incremental patch:

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 3afde9628839..404f89e3eeb8 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -183,7 +183,7 @@ static inline void dma_write(u32 val, int reg, int =
lch)
 	addr +=3D reg_map[reg].stride * lch;
=20
 	__raw_writew(val, addr);
-	if (reg_map[reg].size =3D=3D OMAP_DMA_REG_2X16BIT)
+	if (reg_map[reg].type =3D=3D OMAP_DMA_REG_2X16BIT)
 		__raw_writew(val >> 16, addr + 2);
 }
=20
@@ -196,7 +196,7 @@ static inline u32 dma_read(int reg, int lch)
 	addr +=3D reg_map[reg].stride * lch;
=20
 	val =3D __raw_readw(addr);
-	if (reg_map[reg].size =3D=3D OMAP_DMA_REG_2X16BIT)
+	if (reg_map[reg].type =3D=3D OMAP_DMA_REG_2X16BIT)
 		val |=3D __raw_readw(addr + 2) << 16;
=20
 	return val;


--=20
=46TTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
