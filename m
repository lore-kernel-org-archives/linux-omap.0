From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Wed, 30 Apr 2014 10:16:13 +0300
Message-ID: <5360A33D.3040207@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com> <1398693687-13967-4-git-send-email-rogerq@ti.com> <20140428160347.GG30292@saruman.home> <535F59CF.6050002@ti.com> <20140429161420.GH633@saruman.home> <20140429161616.GI633@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140429161616.GI633-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/29/2014 07:16 PM, Felipe Balbi wrote:
> On Tue, Apr 29, 2014 at 11:14:20AM -0500, Felipe Balbi wrote:
>> On Tue, Apr 29, 2014 at 10:50:39AM +0300, Roger Quadros wrote:
>>> +Nishant
>>>
>>> Hi,
>>>
>>> On 04/28/2014 07:03 PM, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
>>>>> As clocks might be named differently on multiple platforms, use a generic
>>>>> name in the driver and allow device tree node to specify the platform
>>>>> specific clock name.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>>> ---
>>>>>  drivers/phy/phy-omap-usb2.c | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
>>>>> index a2205a8..fb5e515 100644
>>>>> --- a/drivers/phy/phy-omap-usb2.c
>>>>> +++ b/drivers/phy/phy-omap-usb2.c
>>>>> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_device *pdev)
>>>>>  	if (IS_ERR(phy_provider))
>>>>>  		return PTR_ERR(phy_provider);
>>>>>  
>>>>> -	phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
>>>>> +	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>>>>
>>>> doesn't this patch cause a regression ? I mean, you're changing the
>>>> clock name before fixing DTS. Also, that DTS has been in a major version
>>>> of the kernel, so we need to maintain compatibility with it. How about:
>>>
>>> I'm changing the DTS in Patch 4, but I prefer to do it in this patch
>>> to prevent synchronization issues in -next.
>>>
>>> About backward compatibility, I agree with you but at the same time I
>>> don't think anyone using TI SoCs burns the DTB to ROM and needs
>>> backward compatibility. We supply our BSPs/SDKs with the updated DTBs.
>>> Do you feel strict backward compatibility is worth the effort for TI
>>> specific blocks?
>>
>> dunno, but it would, at least, avoid "synchronization issues with
>> linux-next" :-)
> 
> and the bisectability issue.
> 
If backward compatibility is not the real worry then we could avoid the
synchronization/bisectability issue by squashing the dts changes with this patch.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
