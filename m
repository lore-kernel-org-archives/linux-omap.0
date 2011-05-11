From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] omap: usbhs: Fixed the crash during rmmod of ehci and
 ohci
Date: Wed, 11 May 2011 12:08:36 +0300
Message-ID: <20110511090834.GN2505@legolas.emea.dhcp.ti.com>
References: <1304932203-31223-1-git-send-email-keshava_mgowda@ti.com>
 <20110509093645.GG1254@legolas.emea.dhcp.ti.com>
 <BANLkTi=F5g50mxw6VBv7-di7hH_eDEZ=GA@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=F5g50mxw6VBv7-di7hH_eDEZ=GA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-bask2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, May 09, 2011 at 03:58:53PM +0530, Munegowda, Keshava wrote:
> I you see only the patch ; its looks like variable halt is not needed;
> 
> If the code; it will be set only when the clocks are disabled;
> Then after restoring irq, you will free the gpio based on this value.

that code is wrong in so many ways that it's difficult to reply, but in
short:

. get rid of the magic constants, define some macros
. instead of using only one error label, use several each one taking
	care of a different case (that will allow you to remove halt flag)
. timeout is never reset, meaning after the first loop, the time_after()
	will always be true.
. this omap->count is ugly.
. you shouldn't be accessing pdata on the exit path
. that save in spin_lock_irqsave() looks unnecessary. Wouldn't
	spin_lock_irq() be enough ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
