From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 09:26:50 +0200
Message-ID: <20091215072650.GA3147@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <20091214162454.GA31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAD03@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAD03-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 15, 2009 at 05:04:30AM +0100, ext Gupta, Ajay Kumar wrote:
>musb->config->dyn_fifo is coming from platform files and is user defined
>but we need to check if the mentor core itself supports dynamic fifo.
>
>See the dynamic fifo code snippet:
>
>--------------------------------------------------------
>        if (reg & MUSB_CONFIGDATA_DYNFIFO) {
>                if (musb->config->dyn_fifo)
>                        status = ep_config_from_table(musb);
>                else {
>                        ERR("reconfigure software for Dynamic FIFOs\n");
>                        status = -ENODEV;
>                }
>        } else {
>--------------------------------------------------------
>
>If CONFIGDATA register bit indicates that dynamic FIFO is supported then
>musb->config->dyn_fifo has to be set to '1' for suceessful initialization.
>
>Thus CONFIGDATA register bit alone is sufficient condition to save/restore
>Tx/Rx FIFOSZ/FIFOADDR registers.

yes, but if the user has to reconfigure the sw for dyn_fifo anyways, so 
we can be sure musb->config->dyn_fifo is correct when you need.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
