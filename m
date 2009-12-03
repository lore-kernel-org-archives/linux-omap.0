From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] musb: Add context save and restore support
Date: Thu, 3 Dec 2009 13:04:43 +0200
Message-ID: <20091203110443.GP1361@nokia.com>
References: <1259217599-17793-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1259217599-17793-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Nov 26, 2009 at 07:39:59AM +0100, ext Ajay Kumar Gupta wrote:
>Adding support for MUSB register save and restore during system
>suspend and resume.
>
>Changes:
>        - Added musb_save/restore_context() functions
>        - Added platform specific musb_platform_save/restore_context()
>          to handle platform specific jobs.
>        - Maintaining BlackFin compatibility by adding read/write
>          functions for registers which are not available in BlackFin
>
>Tested system suspend and resume on OMAP3EVM board.
>
>Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

will we have another version of this patch ??

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
