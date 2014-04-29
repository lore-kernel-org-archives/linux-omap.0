From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Tue, 29 Apr 2014 10:50:39 +0300
Message-ID: <535F59CF.6050002@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com> <1398693687-13967-4-git-send-email-rogerq@ti.com> <20140428160347.GG30292@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140428160347.GG30292-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Nishant

Hi,

On 04/28/2014 07:03 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
>> As clocks might be named differently on multiple platforms, use a generic
>> name in the driver and allow device tree node to specify the platform
>> specific clock name.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/phy/phy-omap-usb2.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
>> index a2205a8..fb5e515 100644
>> --- a/drivers/phy/phy-omap-usb2.c
>> +++ b/drivers/phy/phy-omap-usb2.c
>> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>  	if (IS_ERR(phy_provider))
>>  		return PTR_ERR(phy_provider);
>>  
>> -	phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
>> +	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
> 
> doesn't this patch cause a regression ? I mean, you're changing the
> clock name before fixing DTS. Also, that DTS has been in a major version
> of the kernel, so we need to maintain compatibility with it. How about:

I'm changing the DTS in Patch 4, but I prefer to do it in this patch to prevent synchronization
issues in -next.

About backward compatibility, I agree with you but at the same time I don't think anyone using TI
SoCs burns the DTB to ROM and needs backward compatibility. We supply our BSPs/SDKs with the updated DTBs.
Do you feel strict backward compatibility is worth the effort for TI specific blocks?

> 
> 	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
> 	if (IS_ERR(phy->wkupclk)) {
> 		dev_err(&pdev->dev, "unable to get wkupclk, trying old name\n");
> 		phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
> 		if (IS_ERR(phy->wkupclk)) {
> 			dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
> 			return PTR_ERR(phy->wkupclk);
> 		} else {
> 			dev_warn(&pdev->dev, "found usb_phy_cm_clk32k, please fix your DTS\n");
> 		}
> 	}
> 
> a bit ugly, but at least we don't cause any regressions. Likewise for
> other clocks.
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
