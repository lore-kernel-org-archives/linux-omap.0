From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/9 v3] usb: musb: HWMOD database structures addition
 for OMAP2430
Date: Thu, 23 Sep 2010 12:18:06 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D97A@dbde02.ent.ti.com>
References: <1285201795-26478-1-git-send-email-hemahk@ti.com>
 <20100923062154.GC2563@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100923062154.GC2563-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Thursday, September 23, 2010 11:52 AM
>To: Kalliguddi, Hema
>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Balbi, Felipe; Tony Lindgren; Kevin Hilman; Cousson, Benoit; 
>Paul Walmsley
>Subject: Re: [PATCH 6/9 v3] usb: musb: HWMOD database 
>structures addition for OMAP2430
>
>On Wed, Sep 22, 2010 at 07:29:55PM -0500, Kalliguddi, Hema wrote:
>>OMAP2430 hwmod data stuctures are populated with base 
>address, L3 and L4
>>interface clocks, IRQs,and sysconfig register details.
>>
>>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>
>looks like this should come before patch 5.

Yes. Otherwise the OMAP2430 hwmod_lookup wil fail.
I will change the order.
~ Hema
>
>-- 
>balbi
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
