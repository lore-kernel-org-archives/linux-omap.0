From: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Thu, 21 Oct 2010 17:07:59 +0300
Message-ID: <4CC0493F.1000701@nokia.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>	<4CBD9FD5.506@nokia.com>	<AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>	<4CBE9E69.6060803@nokia.com>	<AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>	<4CBEB312.7060400@nokia.com>	<AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>	<4CBEE186.8090701@nokia.com> <AANLkTinULxyUg_vHjk9RsQm4Row7vRC9ApzYXt7ZMQJD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinULxyUg_vHjk9RsQm4Row7vRC9ApzYXt7ZMQJD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/20/2010 05:38 PM, ext Felipe Contreras wrote:
> On Wed, Oct 20, 2010 at 3:33 PM, Roger Quadros<roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>  wrote:
>> On 10/20/2010 12:23 PM, ext Felipe Contreras wrote:
>>> On Wed, Oct 20, 2010 at 12:14 PM, Roger Quadros<roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>   wrote:
>>>> USB_G_NOKIA just needs a USB gadget controller to work. The gadget
>>>> controller used for the board should come from the board's Kconfig which
>>>> will ideally be supplied by the board's vendor.
>>>
>>> Ok, but USB_OMAP is not supposed to work on the N900? (I tried and it
>>> didn't)
>>
>> No it won't work. USB_OMAP was for older OMAP's. MUSB is on OMAP3 and later.
>> But MUSB is not limited to OMAP SoC.
>
> config USB_GADGET_OMAP
>    depends ARCH_OMAP
>
> So how about s/ARCH_OMAP/ARCH_OMAP1/
>
> Then USB_GADGET_MUSB_HDRC would be selected by default on OMAP2+.
>

But I'm not sure that omap_udc is used only for OMAP1 architecture.
Dave/Tony should confirm this.


-- 
regards,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
