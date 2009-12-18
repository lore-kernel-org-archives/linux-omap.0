From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4 v4] musb: Add context save and restore support
Date: Fri, 18 Dec 2009 13:35:04 +0200
Message-ID: <20091218113503.GF32520@nokia.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
 <1260883909-26836-3-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260883909-26836-3-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 15, 2009 at 02:31:48PM +0100, ext Ajay Kumar Gupta wrote:
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

applied, thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
