From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Fix iommu archdata name for DT-based
	devices
Date: Thu, 4 Sep 2014 16:17:53 -0500
Message-ID: <5408D701.7070609@ti.com>
References: <1409788712-10741-1-git-send-email-s-anna@ti.com>
	<1409788712-10741-3-git-send-email-s-anna@ti.com>
	<2755871.jyTSgisx8z@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2755871.jyTSgisx8z@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,
>
> On Wednesday 03 September 2014 18:58:32 Suman Anna wrote:
>> A device is tied to an iommu through its archdata field. The archdata
>> is allocated on the fly for DT-based devices automatically through the
>> .add_device iommu ops. The current logic incorrectly assigned the name
>> of the IOMMU user device, instead of the name of the IOMMU device as
>> required by the attach logic. Fix this issue so that DT-based devices
>> can attach successfully to an IOMMU domain.
>>
>> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/iommu/omap-iommu.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index f245d51..f47ac03 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_iommu.h>
>>  #include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>>
>>  #include <asm/cacheflush.h>
>>
>> @@ -1244,6 +1245,7 @@ static int omap_iommu_add_device(struct device *dev)
>>  {
>>  	struct omap_iommu_arch_data *arch_data;
>>  	struct device_node *np;
>> +	struct platform_device *pdev;
>>
>>  	/*
>>  	 * Allocate the archdata iommu structure for DT-based devices.
>> @@ -1258,13 +1260,19 @@ static int omap_iommu_add_device(struct device *dev)
>> if (!np)
>>  		return 0;
>>
>> +	pdev = of_find_device_by_node(np);
>> +	if (WARN_ON(!pdev)) {
>> +		of_node_put(np);
>> +		return -EINVAL;
>> +	}
> 
> I might be wrong, but I don't think there's a guarantee at this point that the 
> IOMMU device is already instantiated :-/

The omap_iommu_init which registers the iommu_ops is a subsys_initcall,
so the platform devices are guaranteed to be created by this point. My
test on OMAP4 in fact has the dsp node created before the IOMMU node,
and this is not an issue. I have added the WARN_ON in case some one has
the IOMMU node disabled, but try to use it.

> Will Deacon has posted patches that rework the IOMMU core for better DT 
> integration, have you seen them ?

Can you point out the thread? Are you talking about
http://marc.info/?l=linux-arm-kernel&m=140968072117851&w=2?

regards
Suman

> 
>> +
>>  	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
>>  	if (!arch_data) {
>>  		of_node_put(np);
>>  		return -ENOMEM;
>>  	}
>>
>> -	arch_data->name = kstrdup(dev_name(dev), GFP_KERNEL);
>> +	arch_data->name = kstrdup(dev_name(&pdev->dev), GFP_KERNEL);
>>  	dev->archdata.iommu = arch_data;
>>
>>  	of_node_put(np);
> 
