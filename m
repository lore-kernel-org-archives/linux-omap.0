From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Tue, 19 Oct 2010 13:32:34 +0300
Message-ID: <20101019103234.GI31170@legolas.emea.dhcp.ti.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
 <1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287482608-11320-4-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Oct 19, 2010 at 05:03:28AM -0500, Felipe Contreras wrote:
>+	depends on (NOP_USB_XCEIV || TWL4030_USB)
>+	default y if ARCH_OMAP3
>+	default y if ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN

it could be only me, but I see these kind of dependencies tend to
disaster. They can all grow to infinity. Soon, we will have another twl
family of devices, or we will have another MACH_* which will need
nop_xceiv, etc etc.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
