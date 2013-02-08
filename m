From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 2/2] dmaengine: OMAP: Register SDMA controller with
 Device Tree DMA driver
Date: Fri, 8 Feb 2013 09:05:28 -0600
Message-ID: <51151438.2000108@ti.com>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
 <1360285506-22354-3-git-send-email-jon-hunter@ti.com>
 <20130208075552.GD21879@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130208075552.GD21879-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 02/08/2013 01:55 AM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 07, 2013 at 07:05:06PM -0600, Jon Hunter wrote:
>> If the device-tree blob is present during boot, then register the SDMA
>> controller with the device-tree DMA driver so that we can use device-tree
>> to look-up DMA client information.
>>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> 
> single comment below, other than that:
> 
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
>> ---
>>  arch/arm/mach-omap2/dma.c |    4 ++++
>>  drivers/dma/omap-dma.c    |   37 +++++++++++++++++++++++++++++++++++--
>>  2 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
>> index 5cd8d76..71dadff 100644
>> --- a/arch/arm/mach-omap2/dma.c
>> +++ b/arch/arm/mach-omap2/dma.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/init.h>
>>  #include <linux/device.h>
>>  #include <linux/dma-mapping.h>
>> +#include <linux/of.h>
>>  #include <linux/omap-dma.h>
>>  
>>  #include "soc.h"
>> @@ -304,6 +305,9 @@ static int __init omap2_system_dma_init(void)
>>  	if (res)
>>  		return res;
>>  
>> +	if (of_have_populated_dt())
>> +		return res;
>> +
>>  	pdev = platform_device_register_full(&omap_dma_dev_info);
>>  	if (IS_ERR(pdev))
>>  		return PTR_ERR(pdev);
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> index c4b4fd2..0067bd0 100644
>> --- a/drivers/dma/omap-dma.c
>> +++ b/drivers/dma/omap-dma.c
>> @@ -16,6 +16,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/of_device.h>
>>  
>>  #include "virt-dma.h"
>>  
>> @@ -67,6 +69,8 @@ static const unsigned es_bytes[] = {
>>  	[OMAP_DMA_DATA_TYPE_S32] = 4,
>>  };
>>  
>> +static struct of_dma_filter_info info;
> 
> Arnd also mentioned that since all fields belonging to this are
> constant, you could statically initialize them here. He also mentioned
> you should call this by a more descriptive name:

Oops sorry missed that comment. Will fix up and re-send.

Cheers
Jon
