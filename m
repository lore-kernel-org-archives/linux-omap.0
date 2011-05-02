From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap:usb: add regulator support for EHCI
Date: Mon, 2 May 2011 12:38:32 +0300
Message-ID: <20110502093830.GR2529@legolas.emea.dhcp.ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
 <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
 <1303395763-8702-3-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1303395763-8702-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 21, 2011 at 07:52:43PM +0530, Keshava Munegowda wrote:
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> 
> in case of ehci phy mode; regulator of phy
> should be enabled before initializing the
> usbhs core driver.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

applied, thanks

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
