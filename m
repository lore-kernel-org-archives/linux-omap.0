From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 14:16:13 +0300
Message-ID: <20101019111613.GJ31170@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
 <20101019103234.GI31170@legolas.emea.dhcp.ti.com>
 <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 19, 2010 at 05:59:58AM -0500, Felipe Contreras wrote:
>The USB_MUSB_HDRC dependency on NOP_USB_XCEIV || TWL4030_USB is
>already there, I'm just making it explicit. The rest are not
>dependencies, just sensible defaults, and they are already in
>drivers/usb/musb/Kconfig, I'm just moving them.

might be true, but what will happen is that other developers will just
"follow what's in the tree" so they'll keep on adding more and more
"sesible defaults" to this line.

Linus had some really good comments about Kconfig usage some time ago
and I'm sure he wouldn't like us adding "sensible defaults" all over the
place.

>If you have a better approach to avoid manually selecting TWL4030_USB
>on defconfigs, and making sure USB_MUSB_HDRC works, please share it.

that's the thing. Currently, I don't think it should be automatic as we
can only have one transceiver structure. Look into
drivers/usb/otg/otg.c, it's just a static global pointer on that file,
which prevents us from having a working solution if you enable more than
one transceiver.

Ideally there would be a class or something similar to allow us to
register N transceiver and use the correct one in runtime, that would
make distro-makers' life easier. It'll probably help Linaro also at some
point, but as of today, enabling more than one transceiver will never
work.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
