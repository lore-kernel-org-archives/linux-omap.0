From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 09/21] ARM: davinci: Add set dma_mask to eDMA devices
Date: Thu, 10 Sep 2015 12:13:14 +0300
Message-ID: <55F149AA.3030301@ti.com>
References: <1441874270-2399-1-git-send-email-peter.ujfalusi@ti.com>
 <1441874270-2399-10-git-send-email-peter.ujfalusi@ti.com>
 <1510483.LNzviKQJ8l@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510483.LNzviKQJ8l@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/10/2015 11:45 AM, Arnd Bergmann wrote:
> On Thursday 10 September 2015 11:37:38 Peter Ujfalusi wrote:
>> +static u64 da8xx_edma0_dmamask =3D DMA_BIT_MASK(32);
>> +
>>  static struct platform_device da8xx_edma0_device =3D {
>>         .name           =3D "edma",
>>         .id             =3D 0,
>>         .dev =3D {
>>                 .platform_data =3D &da8xx_edma0_pdata,
>> +               .dma_mask =3D &da8xx_edma0_dmamask,
>> +               .coherent_dma_mask =3D DMA_BIT_MASK(32),
>>         },
>>         .num_resources  =3D ARRAY_SIZE(da8xx_edma0_resources),
>>         .resource       =3D da8xx_edma0_resources,
>>  };
>=20
> While this is technically correct for all I can tell, could you
> convert it to use __initconst platform_device_info and
> platform_device_register_full() instead?

Yes, I can do that for the eDMAs. I was also thought about this, but lo=
oking
around the mach-davinci, I thought to stick with this mode.

> statically declaring platform_devices has been frowned upon for a lon=
g
> time (even though a lot of arm platforms still do it), and statically
> declaring the dma mask seems worse to me (and yes, I realize we also
> do that elsewhere).

Will be part of v2.

--=20
P=E9ter
