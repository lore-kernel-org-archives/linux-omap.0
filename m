From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 09:40:25 +0200
Message-ID: <20091215074025.GB3147@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <20091214162454.GA31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAD03@dbde02.ent.ti.com>
 <20091215072650.GA3147@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAE01@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAE01-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Dec 15, 2009 at 08:37:38AM +0100, ext Gupta, Ajay Kumar wrote:
>As per current logic, user has to set dyn_fifo if mentor core supports it
>and it has to be set to '0' if core doesn't support it. So what's the need
>for musb->config->dyn_fifo at all. We can very well decide based on only
>CONFIGDATA register bits alone.
>
>I think we should just get rid of this unwanted user defined flag. I will
>post a patch on this along with next revision.

aaa ok, now I get what you're saying.

You're suggesting to drop musb->config->dyn_fifo and decide 
ep_config_from_table() or ep_config_from_hw() based on CONFIGDATA.

Ok, makes sense. But first remove that before saving dyn_fifo on musb 
structure.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
