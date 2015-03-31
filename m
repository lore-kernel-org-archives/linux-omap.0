From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 6/7] dmaengine: omap-dma: Remove mapping between virtual
 channels and requests
Date: Tue, 31 Mar 2015 18:44:30 +0300
Message-ID: <551AC0DE.40807@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com> <1427459213-14611-7-git-send-email-peter.ujfalusi@ti.com> <20150327202230.GA4027@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150327202230.GA4027@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, tony@atomide.com, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 03/27/2015 10:22 PM, Russell King - ARM Linux wrote:
> On Fri, Mar 27, 2015 at 02:26:52PM +0200, Peter Ujfalusi wrote:
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
> There's no point having 127 virtual DMA channels then... is there?
> We might as well reduce the number down to a more reasonable set
> rather than wasting memory.

I was also come to the same conclusion. My plan was to change the virtu=
al DMA
channels to the same as the sDMA's logical channels.

>> @@ -1049,7 +1050,6 @@ static int omap_dma_chan_init(struct omap_dmad=
ev *od, int dma_sig)
>>  		return -ENOMEM;
>> =20
>>  	c->reg_map =3D od->reg_map;
>> -	c->dma_sig =3D dma_sig;
>=20
> That's the only user of dma_sig in this function.  Why not remove it =
from
> the function prototype and its caller?
>=20


--=20
P=E9ter
