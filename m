From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 5/6] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
Date: Tue, 24 Feb 2015 19:01:41 +0200
Message-ID: <54ECAE75.3070501@ti.com>
References: <1424787683-19151-1-git-send-email-peter.ujfalusi@ti.com> <1424787683-19151-6-git-send-email-peter.ujfalusi@ti.com> <20150224142833.GI8670@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224142833.GI8670@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, Tony Lindgren <tony@atomide.com>, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 02/24/2015 04:28 PM, Russell King - ARM Linux wrote:
> On Tue, Feb 24, 2015 at 04:21:22PM +0200, Peter Ujfalusi wrote:
>> Do not direct map the virtual channels to sDMA request number. When =
the
>> sDMA is behind of a crossbar this direct mapping can cause situation=
s when
>> certain channel can not be requested since the crossbar request numb=
er
>> will no longer match with the sDMA request line.
>> The direct mapping for virtual channels with HW request lines will m=
ake it
>> harder to implement MEM_TO_MEM mode for the driver.
>=20
> I assume when you talk about MEM_TO_MEM, you're referring to a DMA_ME=
MCPY
> driver.
>=20
> mem2mem should not be handled by the slave driver.  This should be a
> separate DMA engine driver structure which does not have DMA_SLAVE se=
t.
>=20
> See how amba-pl08x handles this.

Thanks for the pointer. I'm just planning to add the DMA_MEMCPY support=
 for
omap-dma. With that in place we can convert the remaining legacy API us=
ers to
use dmaengine (as I recall all of them are using DMA for memcopy)

--=20
P=E9ter
