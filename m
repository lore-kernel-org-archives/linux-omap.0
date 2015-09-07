From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Mon, 7 Sep 2015 12:39:05 +0300
Message-ID: <55ED5B39.8070407@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
 <20150906020240.GB4914@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150906020240.GB4914@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Peter,

On 06/09/15 05:02, Peter Chen wrote:
> On Wed, Sep 02, 2015 at 05:24:16PM +0300, Roger Quadros wrote:
>> Register with the USB OTG core. Since we don't support
>> OTG yet we just work as a dual-role device even
>> if device tree says "otg".
>>
>> +
>> +static int dwc3_drd_init(struct dwc3 *dwc)
>> +{
>> +	int ret, id, vbus;
>> +	struct usb_otg_caps *otgcaps = &dwc->otg_config.otg_caps;
>> +
>> +	otgcaps->otg_rev = 0;
>> +	otgcaps->hnp_support = false;
>> +	otgcaps->srp_support = false;
>> +	otgcaps->adp_support = false;
>> +	dwc->otg_config.fsm_ops = &dwc3_drd_ops;
>> +
>> +	if (!dwc->edev) {
>> +		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
>> +		return -ENODEV;
>> +	}
>> +
> 
> Do All dwc3 platforms id/vbus need to get through extcon? Do the
> SoCs have id/vbus pin?
> 
> 

Extcon access is in fact not needed from dwc3 driver and I will be getting
rid of this patch. We will support dual-role only via the OTG irq as in patch 5.

The way it works is that the OMAP glue layer dwc3-omap.c requests extcon device
and sets some mailbox register and this causes the VBUS/ID events to come over
OTG irq/status. So this patch is redundant.

The extcon device is not needed for all TI platforms. e.g. we need it for
DRA7 but not for AM437x.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
