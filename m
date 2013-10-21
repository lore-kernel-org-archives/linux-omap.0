From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: omap5: Add dr_mode for dwc3
Date: Mon, 21 Oct 2013 15:33:06 +0530
Message-ID: <5264FBDA.8040704@ti.com>
References: <52580F34.8030809@ti.com> <1381816199-7966-1-git-send-email-kishon@ti.com> <525E91D4.30509@ti.com> <526043BA.5040100@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526043BA.5040100-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 18 October 2013 01:38 AM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 16/10/2013 15:17, Kishon Vijay Abraham I wrote:
>> Benoit,
>>
>> On Tuesday 15 October 2013 11:19 AM, Kishon Vijay Abraham I wrote:
>>> From: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>>>
>>> Added dr_mode property in dwc3 and set its default mode to device.
>>> Currently dwc3 driver doesn't have support for OTG mode. So explicitly
>>> setting to peripheral even dwc3 is a OTG controller since OMAP5 has
>>> already got an EHCI host.
>>>
>>> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>
>> Can you take this patch for 3.13?
> 
> I've just applied it.

Thanks :-)

-Kishon

> 
> Thanks,
> Benoit
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
