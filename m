From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
Date: Wed, 2 Oct 2013 16:41:53 +0300
Message-ID: <524C22A1.30200@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com> <1379508542-22389-10-git-send-email-rogerq@ti.com> <52403E02.4070208@ti.com> <20131002131113.GM1476@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131002131113.GM1476@radagast>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/02/2013 04:11 PM, Felipe Balbi wrote:
> On Mon, Sep 23, 2013 at 04:11:30PM +0300, Roger Quadros wrote:
>> Hi Felipe,
>>
>> On 09/18/2013 03:49 PM, Roger Quadros wrote:
>>> "usb_otg_ss_refclk960m" is an optional functional clock to the
>>> UBS_OTG_SS module. So manage it in the driver.
>>>
>>
>> Just realized that "usb_otg_ss_refclk960m" is in fact functional clock to the 
>> PHY and not USB_OTG_SS module. The name is misleading.
>>
>> So please ignore patch 9 and 10.
> 
> ignored. All others are fine, right ?
> 
Yes. But I might have to rebase this on top of Phy framework stuff.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
