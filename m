From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: Unbuildable kernel with musb
Date: Mon, 28 Mar 2011 11:34:51 +0300
Message-ID: <20110328083450.GD2251@legolas.emea.dhcp.ti.com>
References: <87vcz5sd2x.fsf@gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87vcz5sd2x.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gamari <bgamari-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, Mar 26, 2011 at 06:59:18PM -0400, Ben Gamari wrote:
> Today I've been trying to work through the mess that is musb bring-up on
> recent kernels (v2.6.38). While I still haven't succeeded in getting a

patches are welcome.

> working gadget stack (modprobe g_ether fails with ENODEV), I've come
> across configuration where musb causes a link failure in 2.6.38 if built
> as a module:
> 
>     MODPOST 249 modules
>   ERROR: "musb_read_fifo" [drivers/usb/musb/musb_hdrc.ko] undefined!
> 
> Configuration attached.

musb can't be built as module, I sent a patch making it bool recently
until we re-work those parts of the code.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
