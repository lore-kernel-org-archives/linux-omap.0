From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap: am3517: fix build break
Date: Thu, 21 Oct 2010 13:25:36 +0300
Message-ID: <20101021102536.GH3958@legolas.emea.dhcp.ti.com>
References: <1287652806-1067-1-git-send-email-gadiyar@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287652806-1067-1-git-send-email-gadiyar-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 21, 2010 at 04:20:06AM -0500, Gadiyar, Anand wrote:
>Patch usb-am35x-add-musb-support.patch in greg's USB queue
>adds backan include of <plat/control.h>. This file was renamed
>by another commit in the omap tree and the file was already
>fixed to reflect this.
>
>Remove this include to fix up a build break.
>
>Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>Cc: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
