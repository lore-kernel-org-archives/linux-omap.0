From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] USB: ehci-omap: Reset dma_mask pointer on probe
Date: Thu, 23 May 2013 17:46:44 +0300
Message-ID: <519E2BD4.9020906@ti.com>
References: <Pine.LNX.4.44L0.1305231009230.1459-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1305231009230.1459-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
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
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/23/2013 05:11 PM, Alan Stern wrote:
> On Thu, 23 May 2013, Roger Quadros wrote:
> 
>> Device tree probed devices don't get dma_mask set. Previously
>> we were setting the dma_mask pointer only if it was NULL.
>> However, the address of 'omap_ehci_dma_mask' would change
>> each time the module is unloaded and loaded back thus causing
>> the devices dma_mask pointer to be invalid on the next load.
>>
>> This will cause page faults if any driver tries to access the
>> old dma_mask pointer.
>>
>> Unconditionally re-setting the dma_mask pointer fixes this problem.
> 
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>> index 3d1491b..b33e306 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -146,8 +146,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>>  	 * Since shared usb code relies on it, set it here for now.
>>  	 * Once we have dma capability bindings this can go away.
>>  	 */
>> -	if (!pdev->dev.dma_mask)
>> -		pdev->dev.dma_mask = &omap_ehci_dma_mask;
>> +	pdev->dev.dma_mask = &omap_ehci_dma_mask;
> 
> Is this the solution that people have agreed on?  There has been a lot 
> of discussion on this topic.  In particular, there has been talk about 
> fixing it in the DT core.

Fixing it in DT core would be best.
> 
> This particular approach doesn't seem very robust.  What if 
> pdev->dev.dma_mask is already set to a different value for some good 
> reason?
> 

Then it breaks. But for OMAP, that situation seems unlikely.

cheers,
-roger
