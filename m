From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 23/23] mfd: omap-usb-host: Don't spam console on
 clk_set_parent failure
Date: Thu, 13 Dec 2012 16:34:01 +0530
Message-ID: <CAJe_ZhdoS77jy1RtgeShh9gDnjY8su4ULcurKkaAkprrGFg=qQ@mail.gmail.com>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com>
	<1354631514-24815-8-git-send-email-rogerq@ti.com>
	<50BF4F30.4030903@mvista.com>
	<50BF569A.1080403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BF569A.1080403-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, bjorn-yOkvZcmFvRU@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 5 December 2012 19:43, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> On 12/05/2012 03:42 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 04-12-2012 18:31, Roger Quadros wrote:
>>
>>> clk_set_parent is expected to fail on OMAP3 platforms. We don't
>>> consider that as fatal so don't spam console.
>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   drivers/mfd/omap-usb-host.c |   18 +++++++++---------
>>>   1 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>> index 0bb54393..e5257dc 100644
>>> --- a/drivers/mfd/omap-usb-host.c
>>> +++ b/drivers/mfd/omap-usb-host.c
>>> @@ -657,32 +657,32 @@ static int __devinit usbhs_omap_probe(struct
>>> platform_device *pdev)
>>>       }
>>>
>>>       if (is_ehci_phy_mode(pdata->port_mode[0])) {
>>> -        /* for OMAP3 , the clk set paretn fails */
>>> +        /* for OMAP3, clk_set_parent fails */
>>>           ret = clk_set_parent(omap->utmi_clk[0],
>>>                       omap->xclk60mhsp1_ck);
>>>           if (ret != 0)
>>> -            dev_err(dev, "xclk60mhsp1_ck set parent"
>>> -                "failed error:%d\n", ret);
>>> +            dev_dbg(dev, "xclk60mhsp1_ck set parent failed : %d\n",
>>> +                    ret);
>>>       } else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>>>           ret = clk_set_parent(omap->utmi_clk[0],
>>>                       omap->init_60m_fclk);
>>>           if (ret != 0)
>>> -            dev_err(dev, "init_60m_fclk set parent"
>>> -                "failed error:%d\n", ret);
>>> +            dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
>>> +                    ret);
>>>       }
>>>
>>>       if (is_ehci_phy_mode(pdata->port_mode[1])) {
>>>           ret = clk_set_parent(omap->utmi_clk[1],
>>>                       omap->xclk60mhsp2_ck);
>>>           if (ret != 0)
>>> -            dev_err(dev, "xclk60mhsp2_ck set parent"
>>> -                    "failed error:%d\n", ret);
>>> +            dev_dbg(dev, "xclk60mhsp2_ck set parent failed : %d\n",
>>> +                    ret);
>>>       } else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>>>           ret = clk_set_parent(omap->utmi_clk[1],
>>>                           omap->init_60m_fclk);
>>>           if (ret != 0)
>>> -            dev_err(dev, "init_60m_fclk set parent"
>>> -                "failed error:%d\n", ret);
>>> +            dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
>>> +                    ret);
>>
>>    Hm, you sometimes put a space before colon in the error message and
>> sometimes not. Inconsistent. :-)
>>
>
> That was because it fit in 80 characters without the space. I'm not sure
> what is more important, fitting in 80 or consistency in the print
> message. Maybe i should have removed the spaces everywhere so that it is
> consistent as well. :)
>
prints are one thing where breaking the 80 column rule is acceptable.
Otherwise it fails grep'ing
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
