From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: dwc3: dwc3-omap: set dma_mask for dwc3 inorder
 for host mode to work
Date: Tue, 5 Mar 2013 20:29:34 +0530
Message-ID: <51360856.8030306@ti.com>
References: <1362493320-13913-1-git-send-email-kishon@ti.com>
 <1362493320-13913-2-git-send-email-kishon@ti.com>
 <20130305145458.GF12123@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130305145458.GF12123-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
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
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s-guiriec-l0cyMroinI0@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 05 March 2013 08:24 PM, Felipe Balbi wrote:
> On Tue, Mar 05, 2013 at 07:51:57PM +0530, Kishon Vijay Abraham I wrote:
>> While creating the child devices, *of_platform_populate* sets only
>> coherent_dma_mask but USBHCD sets *uses_dma* (determines whether the
>> controller is DMA'able) based on dma_mask. So If we haven't explicitly set
>> dma_mask, the HCD thinks the controller is not DMA'able and the
>> controller will fail. So explicity set dma_mask for dwc3 after
>> *of_platform_populate*.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/usb/dwc3/dwc3-omap.c |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
>> index 35b9673..19c6e72 100644
>> --- a/drivers/usb/dwc3/dwc3-omap.c
>> +++ b/drivers/usb/dwc3/dwc3-omap.c
>> @@ -277,6 +277,14 @@ static void dwc3_omap_disable_irqs(struct dwc3_omap *omap)
>>   	dwc3_omap_writel(omap->base, USBOTGSS_IRQENABLE_SET_0, 0x00);
>>   }
>>
>> +static u64 dwc3_omap_dma_mask = DMA_BIT_MASK(32);
>> +
>> +static int dwc3_omap_set_dmamask(struct device *dev, void *c)
>> +{
>> +	dev->dma_mask = &dwc3_omap_dma_mask;
>> +	return 0;
>> +}
>> +
>>   static int dwc3_omap_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node	*node = pdev->dev.of_node;
>> @@ -381,6 +389,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>
>> +	device_for_each_child(&pdev->dev, NULL, dwc3_omap_set_dmamask);
>
> I don't think this is correct. Child should be setting its own by
> copying from parent. In summary I think we should add this to dwc3 core:
>
> dma_set_coherent_mask(&pdev->dev, pdev->dev.parent->coherent_dma_mask);
> pdev->dev.dma_mask = pdev->dev.parent->dma_mask;
> pdev->dev.dma_parms = pdev->dev.parent->dma_parms;
>
> And add the same thing to xhci-plat.c btw.

hmm.. ok.

Thanks
Kishon
