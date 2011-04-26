From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] mfd: Fix usbhs_enable error handling
Date: Tue, 26 Apr 2011 14:32:04 +0530
Message-ID: <3a59290ed8ab560ac9b85fd1f4d5acd4@mail.gmail.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com> <20110426085846.GI13227@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110426085846.GI13227-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
> Sent: Tuesday, April 26, 2011 2:29 PM
> To: Keshava Munegowda
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; balbi-l0cyMroinI0@public.gmane.org;
gadiyar-l0cyMroinI0@public.gmane.org; p-
> basak2-l0cyMroinI0@public.gmane.org; axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org;
mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
> Subject: Re: [PATCH] mfd: Fix usbhs_enable error handling
>
> Hi,
>
> On Thu, Apr 21, 2011 at 07:52:41PM +0530, Keshava Munegowda wrote:
> > From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > In the case of missing platform_data we do not hold a spin_lock,
> > thus we should not call spin_unlock_irqrestore in the error path.
> >
> > Also simplify the error handling by separating the successful path
> > from error path. I think this change improves readability.
> >
> > Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Can someone give me a Tested-by so I can take these patches.
>
> --
> Balbi

Hi Balbi

I have validated this patch and it works :)

Tested-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
