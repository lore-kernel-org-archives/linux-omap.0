From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] musb: am35x: fix compile error due to control apis
Date: Sat, 4 Dec 2010 00:20:33 +0530
Message-ID: <73b778ec731792828bed71d9e801da79@mail.gmail.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291399965-19623-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Ajay Kumar Gupta wrote:
> As the control.h have been moved to new location and it's
> uses are not allowed to drivers directly so moving the phy
> control, interrupt clear and reset functionality to board
> files.
>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
> Patch created against today's linus tree.

I hope this is a short-term fix only; otherwise you will need
to duplicate this code in all boards that use an AM3517.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
