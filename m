From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 2/3 v4] musb: add musb support for AM35x
Date: Wed, 29 Sep 2010 17:55:01 +0200
Message-ID: <4CA36155.1050605@compulab.co.il>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com> <1285764321-13934-2-git-send-email-ajay.gupta@ti.com> <4CA35B3A.4090707@compulab.co.il> <4CA35D5B.8060400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CA35D5B.8060400-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

 Hi,

On 09/29/10 17:38, Sergei Shtylyov wrote:
> Hello.
>
> Igor Grinberg wrote:
>
>>> AM35x has musb interface and uses CPPI4.1 DMA engine.
>>> Current patch supports only PIO mode. DMA support can be
>>> added later once basic CPPI4.1 DMA patch is accepted.
>
>>> Also added USB_MUSB_AM35X which is required to differentiate musb ips
>>> between OMAP3x and AM35x. This config would be used to for below
>>> purposes,
>>>         - Select am35x.c instead of omap2430.c for compilation
>>>           at drivers/usb/musb directory. Please note there are
>>>           significant differneces in these two files as musb ip
>>>           in quite different on AM35x.
>>>         - Select workaround codes applicable for AM35x musb issues.
>>>           one such workaround is for bytewise read issue on AM35x.
>
>>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>
> [...]
>
>>> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
>>> new file mode 100644
>>> index 0000000..ee0c104
>>> --- /dev/null
>>> +++ b/drivers/usb/musb/am35x.c
>>> @@ -0,0 +1,510 @@
> [...]
>>> +int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
>>> +{
>>> +    u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
>>> +
>>> +    devconf2 &= ~CONF2_OTGMODE;
>>> +    switch (musb_mode) {
>>> +#ifdef    CONFIG_USB_MUSB_HDRC_HCD
>>> +    case MUSB_HOST:        /* Force VBUS valid, ID = 0 */
>>> +        devconf2 |= CONF2_FORCE_HOST;
>>> +        break;
>>> +#endif
>>> +#ifdef    CONFIG_USB_GADGET_MUSB_HDRC
>>> +    case MUSB_PERIPHERAL:    /* Force VBUS valid, ID = 1 */
>>> +        devconf2 |= CONF2_FORCE_DEVICE;
>>> +        break;
>>> +#endif
>>> +#ifdef    CONFIG_USB_MUSB_OTG
>>> +    case MUSB_OTG:        /* Don't override the VBUS/ID comparators */
>>> +        devconf2 |= CONF2_NO_OVERRIDE;
>
>> This does nothing, can be removed...
>
>    Well, I think you should let it live -- for completeness...

Well, I actually don't like, how those bits defined in first place,
but I want am35xx musb support badly, so yeah, let it be...

>
>>> +int musb_platform_exit(struct musb *musb)
>>> +{
>>> +    struct clk *otg_fck;
>>> +
>>> +    if (is_host_enabled(musb))
>>> +        del_timer_sync(&otg_workaround);
>>> +
>>> +    phy_off();
>>> +
>>> +    otg_put_transceiver(musb->xceiv);
>>> +    usb_nop_xceiv_unregister();
>>> +
>>> +    if (musb->set_clock)
>>> +        musb->set_clock(musb->clock, 0);
>>> +    else
>>> +        clk_disable(musb->clock);
>>> +
>>> +    otg_fck = clk_get(musb->controller, "fck");
>>> +    if (IS_ERR(otg_fck)) {
>>> +        DBG(2, "clk_get() failed for otg_fck.\n");
>>> +    } else {
>>> +        clk_put(otg_fck);
>>> +        clk_put(otg_fck);
>>> +        clk_disable(otg_fck);
>
>> I think the order should be:
>> clk_disable(...);
>> clk_put(...);
>
>    Right...
>
>> And of course, it should be put only once... ;)
>
>    clk_get() is called twice, here and in musb_platform_init(), and so is clk_put().

Right, it should be stored in a static variable or a structure
(as you state in your reply), so there won't be any need for putting it twice.

>
> WBR, Sergei
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
