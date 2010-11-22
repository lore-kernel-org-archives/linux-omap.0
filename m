From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] musb_gadget: fix compilation warning
Date: Mon, 22 Nov 2010 12:41:13 +0200
Message-ID: <20101122104113.GS2446@legolas.emea.dhcp.ti.com>
References: <1290415961-21177-1-git-send-email-ajay.gupta@ti.com>
 <1290415961-21177-2-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290415961-21177-2-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 22, 2010 at 02:22:41PM +0530, Ajay Kumar Gupta wrote:
>Fixes below compilation warning when musb driver is compiled for
>PIO mode.
>drivers/usb/musb/musb_gadget.c: In function 'musb_g_rx':
>drivers/usb/musb/musb_gadget.c:840:
>		warning: label 'exit' defined but not used
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Applied, thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
