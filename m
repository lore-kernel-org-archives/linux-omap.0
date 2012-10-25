From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 6/7] usb: dwc3-omap: Minor fixes to get dt working
Date: Thu, 25 Oct 2012 20:24:09 +0530
Message-ID: <50895291.70106@ti.com>
References: <1350307680-24938-1-git-send-email-kishon@ti.com>
 <1350307680-24938-7-git-send-email-kishon@ti.com> <50894198.40003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50894198.40003-l0cyMroinI0@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Thursday 25 October 2012 07:11 PM, Benoit Cousson wrote:
> Hi Kishon,
>
> On 10/15/2012 03:27 PM, Kishon Vijay Abraham I wrote:
>> Includes few minor fixes in dwc3-omap like populating the compatible
>> string in a correct way, extracting the utmi-mode property properly and
>> changing the index of get_irq since irq of core is removed from hwmod
>> entry.
>> Also updated the documentation with dwc3-omap device tree binding
>> information.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/dwc3-omap.c |   14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index b84ddf3..10aad46 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -318,11 +318,10 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>>   	struct resource		*res;
>>   	struct device		*dev = &pdev->dev;
>>
>> -	int			size;
>>   	int			ret = -ENOMEM;
>>   	int			irq;
>>
>> -	const u32		*utmi_mode;
>> +	u32			utmi_mode;
>>   	u32			reg;
>>
>>   	void __iomem		*base;
>> @@ -336,13 +335,13 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>>
>>   	platform_set_drvdata(pdev, omap);
>>
>> -	irq = platform_get_irq(pdev, 1);
>> +	irq = platform_get_irq(pdev, 0);
>
> Cannot you use the name of the resource to avoid that kind of trick?

*name* is mostly used when we have multiple resource of the same type 
for a single device. Previously we were clubbing wrapper resources and 
core resources in a single hwmod device, so we had to use different 
indexing.
But with dt we have separated those under two different devices and 
hence we can always use index as '0'. But if you think we should have 
*name*, let me know, I can resend this patch :-)

Thanks
Kishon
