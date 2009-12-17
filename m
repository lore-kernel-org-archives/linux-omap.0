From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Thu, 17 Dec 2009 15:10:17 +0200
Message-ID: <20091217131016.GB4210@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <20091215133432.GN3689@nokia.com>
 <20091215134857.GO3689@nokia.com>
 <19F8576C6E063C45BE387C64729E7394043698118E@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940449F4399B@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F4399B-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Dec 17, 2009 at 02:01:27PM +0100, ext Gupta, Ajay Kumar wrote:
>Any update on this ? Shall I send the series again with __deprecated ? or
>If you can just add it on your own?

I guess we have to do that and start sending patches to arch maintainers 
removing the dyn_fifo stuff from board-files.

we should have all fixed by the end of .33-final, then we send a patch 
finally removing dyn_fifo from musb's platform_data.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
