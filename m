From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3 v5] musb: add musb support for AM35x
Date: Fri, 1 Oct 2010 09:23:18 +0300
Message-ID: <20101001062318.GG2925@legolas.emea.dhcp.ti.com>
References: <1285823949-27694-1-git-send-email-ajay.gupta@ti.com>
 <1285823949-27694-2-git-send-email-ajay.gupta@ti.com>
 <20101001060203.GD2925@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404A9D8AFF0@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404A9D8AFF0-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 01, 2010 at 01:21:33AM -0500, Gupta, Ajay Kumar wrote:
>Hi,
>> On Thu, Sep 30, 2010 at 12:19:08AM -0500, Gupta, Ajay Kumar wrote:
>> >AM35x has musb interface and uses CPPI4.1 DMA engine.
>> >Current patch supports only PIO mode. DMA support can be
>> >added later once basic CPPI4.1 DMA patch is accepted.
>> >
>> >Also added USB_MUSB_AM35X which is required to differentiate musb ips
>> >between OMAP3x and AM35x. This config would be used to for below
>> >purposes,
>> >        - Select am35x.c instead of omap2430.c for compilation
>> >          at drivers/usb/musb directory. Please note there are
>> >          significant differneces in these two files as musb ip
>> >          in quite different on AM35x.
>> >        - Select workaround codes applicable for AM35x musb issues.
>> >          one such workaround is for bytewise read issue on AM35x.
>> >
>> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>>
>> this one doesn't apply of top of my musb-2.6.37 branch.
>[...]
>> could you refresh and resend this one ??
>
>I couldn't fetch your gitorious tree so I just applied 14 patch set
>Manually on my branch.
>
>Anyways I will look into it and send the refreshed patch shortly.

gitorious must be trying to make me look bad :-p

Works like a charm here. Will try on a different laptop

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
