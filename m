From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Fri, 29 Nov 2013 01:35:32 +0200
Message-ID: <CANOLnONAKg9Efha6Qc7-mgdUCHb=tQ__WVKPDbFDN3ZL3EZUEw@mail.gmail.com>
References: <1385625105-7348-1-git-send-email-anaumann@ultratronik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385625105-7348-1-git-send-email-anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 28, 2013 at 9:51 AM,  <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org> wrote:
> From: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
>
> This is a hard to reproduce problem which leads to non-functional
> USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
> e25bec160158abe86c276d7d206264afc3646281, which introduces save/resto=
re
> of OTG_INTERFSEL over suspend.
> Since the resume function is also called early in driver init, it use=
s a
> non-initialized value (which is 0 and a non-supported setting in DM37=
xx
> for INTERFSEL). Shortly after the correct value is set. Apparently th=
is
> works most time, but not always.
>
> The fix is to initialize the value, BEFORE being written in the resum=
e
> function.

Nice find, I think I'm also affected by this. However this crashes on
OMAP3530 pandora because you now access INTERFSEL before interface
clock is enabled.. This is not a problem on DM37xx because it uses
different interconnects. You should probably use "context_valid"
variable in omap2430_glue or similar to decide to write to register or
not.

Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
