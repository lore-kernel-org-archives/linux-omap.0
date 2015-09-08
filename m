From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Add support for memcpy
Date: Tue, 8 Sep 2015 15:25:33 +0300
Message-ID: <55EED3BD.1080605@ti.com>
References: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
 <3187470.tKXzQaPa1m@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3187470.tKXzQaPa1m@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, tony@atomide.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

Laurent,

On 09/08/2015 02:24 PM, Laurent Pinchart wrote:
> Hi Peter,
>=20
> Thank you for the patch.
>=20
> While trying to port the omap_vout driver to the DMA engine API I not=
iced that=20
> the driver makes use of double-indexed transfers, which are not suppo=
rted by=20
> the omap-dma driver. I haven't checked in details what would be requi=
red, but=20
> the interleaved API might be a good candidate for this. Do you have a=
ny plan=20
> to add support for double-indexed transfers to the omap-dma driver ?

If double-indexed transfer support is needed by drivers still using the
legacy/direct sDMA API, then I don't think we have other options..
So far I have not looked at that part and where it would fit.
I'll try to find time to look at this. I hope not in the distant future=
 ;)

> On Wednesday 22 April 2015 10:34:29 Peter Ujfalusi wrote:
>> The sDMA controller is capable of performing memory copy operation. =
It need
>> to be configured to software triggered mode and without HW synchroni=
zation.
>> The sDMA can copy data which is aligned to 8, 16 or 32 bits.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 51 +++++++++++++++++++++++++++++++++++++++=
++++++--
>>  1 file changed, 49 insertions(+), 2 deletions(-)
>=20

--=20
P=E9ter
