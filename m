From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] dmaengine: edma: Add support for DMA filter mapping
 to slave devices
Date: Tue, 8 Dec 2015 15:15:31 +0200
Message-ID: <5666D7F3.4000708@ti.com>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
 <1449153192-9082-5-git-send-email-peter.ujfalusi@ti.com>
 <2675730.x1sS4Fa4y8@wuerfel> <566063CA.20500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566063CA.20500@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 12/03/2015 05:46 PM, Peter Ujfalusi wrote:
> On 12/03/2015 05:38 PM, Arnd Bergmann wrote:
>> On Thursday 03 December 2015 16:33:12 Peter Ujfalusi wrote:
>>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>>> index 0675e268d577..46b305ea0d21 100644
>>> --- a/drivers/dma/edma.c
>>> +++ b/drivers/dma/edma.c
>>> @@ -2297,6 +2297,12 @@ static int edma_probe(struct platform_device=
 *pdev)
>>>                 edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slo=
t);
>>>         }
>>> =20
>>> +       if (info->slave_map) {
>>> +               ecc->dma_slave.filter_map.map =3D info->slave_map;
>>> +               ecc->dma_slave.filter_map.mapcnt =3D info->slavecnt=
;
>>> +               ecc->dma_slave.filter_map.filter_fn =3D edma_filter=
_fn;
>>> +       }
>>> +
>>>
>>
>> Just a minor comment here: I think all three assignments can be done
>> unconditionally.
>=20
> True.
>=20
>> As I mentioned before, I'd also remove 'struct dma_filter'
>> and put the three members in struct dma_device directly. In fact, th=
e
>> filter function can go with the other function pointers for consiste=
ncy.
>=20
> I just like to keep things in one place ;)
> I don't have strong stand on keeping the intermediate 'struct dma_fil=
ter'
> Let's hear from Vinod regarding to this


One remaining design issue is on how and where to place the filter rela=
ted
variables/pointers:

Keep it separated as it was in the RFC and v01 series:

struct dma_slave_map {
        const char *devname;
        const char *slave;
        void *param;
};

struct dma_filter {
        dma_filter_fn fn;
        int mapcnt;
        const struct dma_slave_map *map;
};


struct dma_device {
	...
	struct dma_filter filter;
	...
};

Or to have them under the dma_device directly:

struct dma_device {
	...
	int filter_mapcnt;
	const struct dma_slave_map *filter_map;
	...
	dma_filter_fn filter_fn;
	...
};

Vinod: what is your preference for this?

Thanks,
P=E9ter
