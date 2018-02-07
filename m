From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability
 to MMC1/MMC2 dt node
Date: Wed, 7 Feb 2018 14:57:50 +0530
Message-ID: <f57e9275-ee32-7f4b-3dee-7312d27e4e1f@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
 <20180206125806.19350-16-kishon@ti.com>
 <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
 <b411cf11-61e9-e688-6f04-e624fe52ac66@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b411cf11-61e9-e688-6f04-e624fe52ac66-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 07 February 2018 02:51 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 07 February 2018 02:41 PM, Sekhar Nori wrote:
>> Kishon,
>>
>> On Tuesday 06 February 2018 06:28 PM, Kishon Vijay Abraham I wrote:
>>> Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>
>> Along with this, dont we need to have
>>
>> 	/delete-property/ mmc-hs200-1_8v;
>>
>> for eMMC on Beagle x15 which does not support HS200?
>>
>> Or are you planning to depend on lack of pinctrl entries for HS200 to
>> take care of that?
> 
> right now it relies on lack of pinctrl entries but I think adding delete
> property is appropriate. Actually I missed porting the patch that adds
> /delete-property/.

Alright, thanks!

Regards,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
