From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
Date: Mon, 22 Feb 2016 09:19:18 +0200
Message-ID: <56CAB676.6080309@ti.com>
References: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
 <1454423227-31830-2-git-send-email-peter.ujfalusi@ti.com>
 <20160219214426.GK1640@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160219214426.GK1640@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On 2016-02-19 23:44, Aaro Koskinen wrote:
> On Tue, Feb 02, 2016 at 04:27:06PM +0200, Peter Ujfalusi wrote:
>> OMAP1 can not boot in DT mode and to be able to clean up the driver
>> regarding to the dmaengine API use (switching to the new API) the
>> device/slave -> filter mapping needs to be provided to the omap-dma =
driver.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks Aaro,

I believe the map covers all drivers using DMA, but in case I missed an=
y we -
you ;) will notice it as they will fail to get the DMA channels. This o=
nly
going to be visible after I send the driver changes for 4.7. In such a =
case we
will need to add the given device to the list.

--=20
P=E9ter

>=20
> A.
>=20
>> ---
>>  arch/arm/mach-omap1/dma.c | 45 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
>> index 7b02ed218a42..f6ba589cd312 100644
>> --- a/arch/arm/mach-omap1/dma.c
>> +++ b/arch/arm/mach-omap1/dma.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/device.h>
>>  #include <linux/io.h>
>>  #include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>>  #include <linux/omap-dma.h>
>>  #include <mach/tc.h>
>> =20
>> @@ -265,6 +266,42 @@ static const struct platform_device_info omap_d=
ma_dev_info =3D {
>>  	.num_res =3D 1,
>>  };
>> =20
>> +/* OMAP730, OMAP850 */
>> +static const struct dma_slave_map omap7xx_sdma_map[] =3D {
>> +	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
>> +	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
>> +	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(10) },
>> +	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(11) },
>> +	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
>> +	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
>> +	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
>> +	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
>> +	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
>> +	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
>> +	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
>> +	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
>> +};
>> +
>> +/* OMAP1510, OMAP1610*/
>> +static const struct dma_slave_map omap1xxx_sdma_map[] =3D {
>> +	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
>> +	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
>> +	{ "omap-mcbsp.3", "tx", SDMA_FILTER_PARAM(10) },
>> +	{ "omap-mcbsp.3", "rx", SDMA_FILTER_PARAM(11) },
>> +	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(16) },
>> +	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(17) },
>> +	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
>> +	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
>> +	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
>> +	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
>> +	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
>> +	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
>> +	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
>> +	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
>> +	{ "mmci-omap.1", "tx", SDMA_FILTER_PARAM(54) },
>> +	{ "mmci-omap.1", "rx", SDMA_FILTER_PARAM(55) },
>> +};
>> +
>>  static struct omap_system_dma_plat_info dma_plat_info __initdata =3D=
 {
>>  	.reg_map	=3D reg_map,
>>  	.channel_stride	=3D 0x40,
>> @@ -342,6 +379,14 @@ static int __init omap1_system_dma_init(void)
>>  	p.dma_attr =3D d;
>>  	p.errata =3D configure_dma_errata();
>> =20
>> +	if (cpu_is_omap7xx()) {
>> +		p.slave_map =3D omap7xx_sdma_map;
>> +		p.slavecnt =3D ARRAY_SIZE(omap7xx_sdma_map);
>> +	} else {
>> +		p.slave_map =3D omap1xxx_sdma_map;
>> +		p.slavecnt =3D ARRAY_SIZE(omap1xxx_sdma_map);
>> +	}
>> +
>>  	ret =3D platform_device_add_data(pdev, &p, sizeof(p));
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
>> --=20
>> 2.7.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
