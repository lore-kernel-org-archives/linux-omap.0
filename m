From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/10 v1] arm: omap: usb: create common enums and
 structures for ehci and ohci
Date: Tue, 1 Mar 2011 12:49:40 +0200
Message-ID: <20110301104940.GS2942@legolas.emea.dhcp.ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-4-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-5-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298910712-2051-5-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 28, 2011 at 10:01:46PM +0530, Keshava Munegowda wrote:
> Create the ehci and ohci specific platform data structures.
> The port enum values are made common for both ehci and ohci.
> 
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

Applying: arm: omap: usb: create common enums and structures for ehci and ohci
error: patch failed: drivers/usb/host/ehci-omap.c:409
error: drivers/usb/host/ehci-omap.c: patch does not apply
Patch failed at 0005 arm: omap: usb: create common enums and structures for ehci and ohci
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Which tree did you use as base for these patches ? I'm trying to apply
on top of v.2.6.38-rc6

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
