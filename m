From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] OMAP4: otg: phy: remove uggly mdelay(200)
Date: Fri, 3 Aug 2012 12:21:35 +0530
Message-ID: <CAAe_U6K5n5SEBDR1vgaoc1+MQB=_aQ7yc0jBu1BFgX-D5ZPt8w@mail.gmail.com>
References: <1341477739-6801-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341477739-6801-1-git-send-email-ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jul 5, 2012 at 2:12 PM, Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org> wrote:
> The original issue with powering on the PHY (and using
> 200 ms delay after this) is not related to internal
> processes in the PHY but is in the incorrect charger
> detection feature usage.
>
> Now when it is fixed, we can safely remove this uggly

So is this 200ms delay related to incorrect charger detection? How is
it now fixed without the delay?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
