From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/4]usb : musb:USB driver using omap_device_build for
 device registration.
Date: Tue, 29 Jun 2010 15:05:28 +0400
Message-ID: <4C29D378.90408@ru.mvista.com>
References: <1277727427-6144-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1277727427-6144-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

Hema HK wrote:

> From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>

    I think the patch description has clarity issues...

> Changed the musb driver to use omap_build_device api instead of 

    I don't see where are you changing the MUSB driver.

> platform_device_registration.

    Why underscores here?

> The device specific resources defined in 
> centralized database will be used. So removed the resource definitions from
> the driver file.

    Do you mean usb-musb.c here? This is certainly not a driver.

> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
