From: Santosh Shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/2] memory: Introduce ti-emif-sram driver
Date: Fri, 1 Dec 2017 13:58:27 -0800
Message-ID: <3c3066a8-d8cf-3e5f-f7ed-43ebd7578bd1@oracle.com>
References: <1512082568-5012-1-git-send-email-d-gerlach@ti.com>
 <20171201175418.GS28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171201175418.GS28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/1/2017 9:54 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [171130 22:58]:
>> This is a resend of v5 of this series found here [1]. It introduces
>> relocatable PM handlers for the emif that are copied to sram and
>> run from there during low power mode entry.
>>
>> The patches still have the previous ACKs but have a small change to
>> accomodate a change made by Tony in commit cd57dc5a2099 ("ARM: dts:
>> Add missing hwmod related nodes for am33xx"). If there are objections
>> to this let me know ASAP.
> 
> Still looks good to me thanks.
> 
>> Now that a hwmod is present for the am335x EMIF, on probe fail the call to
>> pm_runtime_put_sync causes the board to hang. In fact, this emif driver should
>> never alter the PM state of the hardware at all through normal kernel calls, it
>> is the job of the suspend handlers that are added, that is the whole point of
>> this driver. Because of this, I have dropped all runtime pm calls, as any
>> change to the PM state while the kernel is running is dangerous as we may shut
>> of the memory controller. It makes the most sense just to drop runtime PM from
>> the driver entirely. Besides that patch is unchanged.
> 
> OK makes sense to me.
> 
Thanks Tony. Will queue this version once rc1 is tagged.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
