From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: Re: [PATCH] mfd: omap-usb-host: AM3715 OHCI needs 120m functional
 clock
Date: Tue, 13 Oct 2015 09:23:27 +0100
Message-ID: <561CBF7F.7020705@codethink.co.uk>
References: <1444671232-10253-1-git-send-email-ben.dooks@codethink.co.uk> <20151012174505.GJ23801@atomide.com> <561BF97B.2010501@codethink.co.uk> <20151012191948.GM23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151012191948.GM23801-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 12/10/15 20:19, Tony Lindgren wrote:
> * Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org> [151012 11:22]:
>> On 12/10/15 18:45, Tony Lindgren wrote:
>>> * Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org> [151012 10:38]:
>>>> The AM3715 OHCI controller will not function without the EHCI
>>>> unit's 120m fclk being enabled. If all the ports in the system
>>>> are set to OHCI then the 120m_fclk will not get enabled and no
>>>> devices are detected.
>>>>
>>>> Add a new (optional) property to signal the system must enable
>>>> the 120m_fck for OHCI so that if no EHCI ports are signalled
>>>> then the 120m_fclk should be enabled.
>>>>
>>>> We have found no information about why this is necessary, but
>>>> it is suspected the EHCI controller does not complete the initial
>>>> reset sequence and therefore does not hand control of the USB
>>>> port back.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/usb/omap-usb.txt | 3 +++
>>>>  drivers/mfd/omap-usb-host.c                        | 4 ++++
>>>>  2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> index 38d9bb8..fb5fea5 100644
>>>> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
>>>> @@ -23,6 +23,9 @@ OMAP MUSB GLUE
>>>>  Optional properties:
>>>>   - ctrl-module : phandle of the control module this glue uses to write to
>>>>     mailbox
>>>> + - ti,ohci-needs-120m-fck : bool, enable the 120m ehci clock even if just
>>>> +   using ohci. Needed for AM3517 in OHCI only mode.
>>>> +
>>>>  
>>>>  SOC specific device node entry
>>>>  usb_otg_hs: usb_otg_hs@4a0ab000 {
>>>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>>>> index 1d924d1..13880cf 100644
>>>> --- a/drivers/mfd/omap-usb-host.c
>>>> +++ b/drivers/mfd/omap-usb-host.c
>>>> @@ -680,6 +680,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>>>  				need_logic_fck |= true;
>>>>  		}
>>>>  
>>>> +		/* The AM3517 requries the 120m-fck active to allow the OHCI to work */
>>>> +		if (of_property_read_bool(dev->of_node, "ti,ohci-needs-120m-fck"))
>>>> +			need_logic_fck |= true;
>>>> +
>>>>  		if (need_logic_fck) {
>>>>  			omap->ehci_logic_fck = devm_clk_get(dev,
>>>>  							    "usbhost_120m_fck");
>>>
>>> Hmm why not just use the standard device tree clocks property and then do
>>> clk_get_rate() on the clock?
>>
>> I don't see that helps enabling the clock. The code decideds if
>> no EHCI ports in use that it doesn't need to enable the EHCI fclk.
> 
> Right, you need to do clk_prepare_enable() in it first? :)

No, if that was the case the driver would never work for the EHCI case.

The issue is:

1) All ports on the system are set to OHCI
2) The omap-usb-host.c does not touch usbhost_120m_fck if no EHCI ports
3) The OHCI fails to detect any devices due to point 2.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
