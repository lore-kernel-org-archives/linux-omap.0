From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/5 v5] usb: musb: Using runtime pm APIs for musb.
Date: Fri, 10 Dec 2010 16:38:11 +0200
Message-ID: <20101210143811.GS6027@legolas.emea.dhcp.ti.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com>
 <1291991739-21705-6-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291991739-21705-6-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

hi,

On Fri, Dec 10, 2010 at 08:05:39PM +0530, Hema HK wrote:
>Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
>for enabling/disabling the clocks, sysconfig settings.
>
>enable clock, configure no-idle/standby when active and configure force idle/standby
>and disable clock when idled. This is taken care by the runtime framework when
>driver calls the pm_runtime_get_sync and pm_runtime_put_sync APIs.
>Need to configure MUSB into force standby and force idle mode when usb not used
>
>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>---
>
> drivers/usb/musb/musb_core.h |    2 -
> drivers/usb/musb/omap2430.c  |   80 +++++++++++--------------------------------
> 2 files changed, 23 insertions(+), 59 deletions(-)

Now I see you removed the runtime_resume and runtime_suspend calls from
musb_core. Won't we loose context in that case ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
