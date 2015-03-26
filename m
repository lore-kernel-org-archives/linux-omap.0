From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/7] dmaengine: omap-dma: Use defines for dma channels
 and request count
Date: Thu, 26 Mar 2015 14:32:58 +0200
Message-ID: <5513FC7A.7090708@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com> <1426080210-841-5-git-send-email-peter.ujfalusi@ti.com> <20150326105712.GL32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60200 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbCZMdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2015 08:33:35 -0400
In-Reply-To: <20150326105712.GL32683@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

On 03/26/2015 12:57 PM, Vinod Koul wrote:
> On Wed, Mar 11, 2015 at 03:23:27PM +0200, Peter Ujfalusi wrote:
>> Instead of magic numbers in the code, use define for number of logic=
al DMA
>> channels and DMA requests.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/omap-dma.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index 7dd6dd121681..56c33e93dd24 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -22,6 +22,9 @@
>> =20
>>  #include "virt-dma.h"
>> =20
>> +#define OMAP_SDMA_REQUESTS	127
>> +#define OMAP_SDMA_CHANNELS	32
> Again why dont we put these things in DT ?

They are in DT, the next patch will take the needed information from th=
ere and
uses these values as fallback values in case they are missing for some =
reason.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
