From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/9 v3] OMAP: Hwmod api changes
Date: Thu, 23 Sep 2010 09:23:17 +0300
Message-ID: <20100923062317.GD2563@legolas.emea.dhcp.ti.com>
References: <1285201816-26516-1-git-send-email-hemahk@ti.com>
 <4C9A6A62.5000100@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C9A6A62.5000100-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 22, 2010 at 03:43:14PM -0500, Cousson, Benoit wrote:
>Hi Hema,
>
>On 9/23/2010 2:30 AM, Kalliguddi, Hema wrote:
>> OMAP USBOTG modules has a requirement to set the auto idle bit only after
>> setting smart idle bit. Modified the _sys_enable api to set the smart idle
>> first and then the autoidle bit. Setting this will not have any impact on the
>> other modules.
>
>I think you should change the subject, because it does not reflect
>accurately the patch.
>
>Just a little bit of nitpicking...
>For me, an API change is a change in the signature of the API, not a
>change inside an API. Otherwise, since 99% of the code is inside a
>function, we can call most patches like that...
>Moreover I don't think _sysc_enable can be considered as an API since it
>is a pure static helper function not exported to the outside.
>
>Something like that seems more accurate for my point of view:
>
>OMAP: hwmod: Set autoidle after smartidle during _sysc_enable

+1

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
