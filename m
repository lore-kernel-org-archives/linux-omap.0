From: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 01/10] OMAP2+: l3-noc: Add support for device-tree
Date: Thu, 8 Sep 2011 23:59:18 +0200
Message-ID: <4E693AB6.7050200@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-2-git-send-email-b-cousson@ti.com>
	<20110908180148.GA2967@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20110908180148.GA2967-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: "Hilman, Kevin" <khilman-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "G,
	Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Shilimkar,
	Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 9/8/2011 8:01 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:07PM +0200, Benoit Cousson wrote:
>> Add device-tree support for the l3-noc driver.
>>
>> Use platform_driver_register to defer the probing at device init
>> time.
>>
>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Santosh Shilimkar<santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/mach-omap2/omap_l3_noc.c |   16 ++++++++++++++--
>>   1 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
>> index 7b9f190..4630703 100644
>> --- a/arch/arm/mach-omap2/omap_l3_noc.c
>> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
>> @@ -228,16 +228,28 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id l3_noc_match[] = {
>> +	{.compatible = "arteris,noc", },
>
> Missing documentation for this compatible property.

As you already figured out... it will come later.

> Also, it appears
> to be rather on the generic side.

It is indeed a generic IP that will be there on OMAP5 too.

>> +	{},
>> +}
>> +MODULE_DEVICE_TABLE(of, l3_noc_match);
>> +#else
>> +#define l3_noc_match NULL
>> +#endif
>> +
>>   static struct platform_driver omap4_l3_driver = {
>> +	.probe		= omap4_l3_probe,
>
> .probe needs to be put into the __devinit section.
>
>>   	.remove		= __exit_p(omap4_l3_remove),
>
> Similarly, at the same time the remove hook should be changed to
> __devexit and __devexit_p() at the same time.
>
>>   	.driver		= {
>> -	.name		= "omap_l3_noc",
>> +		.name		= "omap_l3_noc",
>> +		.of_match_table = l3_noc_match,
>
> Looks like ".owner = THIS_MODULE," is missing too.

Well, yeah, that driver was supposed to be started really early to catch 
any potential bus violation. So it was clearly not targeted to be a 
loadable module.
Anyway, it will not hurt, so I'll fix that.

Thanks for the review,
Benoit
