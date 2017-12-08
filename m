From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 00/20] ARM: dts: add omap clkctrl support
Date: Fri, 8 Dec 2017 08:58:49 +0200
Message-ID: <9fa461b8-32a5-0841-778f-ebe400cbc7ae@ti.com>
References: <1512636413-25243-1-git-send-email-t-kristo@ti.com>
 <20171207211620.GD28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171207211620.GD28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/12/17 23:16, Tony Lindgren wrote:
> * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [171207 00:49]:
>> Hi,
>>
>> This series adds the clkctrl support for omap2 family SoCs for am33xx,
>> am43xx, omap4, omap5, dra7 and dm81xx. This series depends on the
>> previously posted drivers/clk [1] + mach-omap2 [2] series for the same.
> 
> Looks good to me except the comments I made on patch 14/20 that applies
> to many of these patches.

Ok, let me update my script to use the human readable values for these, 
I'll repost once done.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
