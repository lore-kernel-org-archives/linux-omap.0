From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] ARM: dts: dra7: Fix clock data for
 gmac_gmii_ref_clk_div
Date: Wed, 31 Aug 2016 20:34:48 +0300
Message-ID: <232e8fb7-320f-3d64-b1f2-599d53d65291@ti.com>
References: <20160830145801.10364-1-grygorii.strashko@ti.com>
 <20160830184158.xydy3ixy7c5b73le@atomide.com>
 <fd7850dd-b7a2-e6ef-508f-8406c3f2cea9@ti.com>
 <20160831143928.vxuaznyws2pipohu@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831143928.vxuaznyws2pipohu-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "J.D. Schroeder" <jay.schroeder-UF6BFNFdnjXQT0dZR+AlfA@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 31/08/16 17:39, Tony Lindgren wrote:
> * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [160830 23:09]:
>> On 30/08/16 21:41, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [160830 07:58]:
>>>>
>>>> Originally this patch was posted (and acked) here
>>>> https://lkml.org/lkml/2016/4/27/272,
>>>> but it, unfortunatelly, has never been merged.
>>>> So re-send + minor subj change.
>>>
>>> OK yeah sorry about that. And thanks for the resend. If some patches
>>> have pending discussion as I tend to tag threads that have pending
>>> discussion as read and then forget them. And I miss patches in other
>>> ways too..
>>>
>>> Tero, care to take a look and ack?
>>
>> For both patches:
>>
>> Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>
> Thanks applying both into omap-for-v4.9/dt as the Ethernet works
> currently.
>
> Regards,
>
> Tony
>

Yea I think the ethernet clock rate happens to be the same in the 
existing setup, just the hierarchy is wrong. That is at least what I saw 
with quick testing.

-Tero
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
