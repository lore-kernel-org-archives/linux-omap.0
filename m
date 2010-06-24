From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/8] usb: musb: Enable the maximum supported burst mode
 for DMA
Date: Thu, 24 Jun 2010 09:11:04 +0300
Message-ID: <20100624061104.GI8078@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1276771242-5201-7-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 17, 2010 at 12:40:39PM +0200, ext Ajay Kumar Gupta wrote:
>From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>
>Setting MUSB Burst Mode 3 automatically enables support for
>lower burst modes (BURST4, BURST8, BURST16 or bursts of unspecified
>length). There is no need to set these burst modes based on the
>packet size. Also enable the burst mode for both mode1 and mode0.
>
>This is a fix for buggy hardware - having the lower burst modes
>enabled can potentially cause lockups of the DMA engine used in
>OMAP2/3/4 chips.
>
>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

-- 
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
