From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 6/8] usb: ehci-omap: add helpers for checking port
 mode
Date: Tue, 30 Nov 2010 20:14:36 +0530
Message-ID: <4CF50DD4.5080006@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com> <1291051537-23743-7-git-send-email-gadiyar@ti.com> <4CF4ED4E.1080707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CF4ED4E.1080707-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/30/2010 5:55 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 29-11-2010 20:25, Anand Gadiyar wrote:
> 
>> Introduce helper functions to test port mode. These checks are
>> performed in several places in the driver, and these helpers
>> improve readability.
> 
>> Signed-off-by: Anand Gadiyar<gadiyar-l0cyMroinI0@public.gmane.org>
> [...]
> 
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>> index 7a4682c..dd9d5c1 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
> [...]
>> @@ -387,27 +390,27 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
>>       /* Bypass the TLL module for PHY mode operation */
>>       if (cpu_is_omap3430()&&  (omap_rev()<= OMAP3430_REV_ES2_1)) {
>>           dev_dbg(omap->dev, "OMAP3 ES version<= ES2.1\n");
>> -        if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
>> -            (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
>> -                (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
>> +        if (is_ehci_phy_mode(omap->port_mode[0]) ||
>> +            is_ehci_phy_mode(omap->port_mode[1]) ||
>> +                is_ehci_phy_mode(omap->port_mode[2]))
> 
>    Why there's another indentation level whenre there shouldn't be one?
> 

No particular reason, other than that it was a find-and-replace change.
I can fix it up if you insist.

- Anand

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
