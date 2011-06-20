From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] mfd: omap: fix the crash during omap ehci or ohci driver
 initialization
Date: Mon, 20 Jun 2011 16:59:41 +0200
Message-ID: <20110620145941.GQ22420@sortiz-mobl>
References: <1307367739-20110-1-git-send-email-keshava_mgowda@ti.com>
 <20110620132626.GJ22420@sortiz-mobl>
 <20110620132851.GJ14262@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110620132851.GJ14262-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Mon, Jun 20, 2011 at 04:28:52PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jun 20, 2011 at 03:26:26PM +0200, Samuel Ortiz wrote:
> > On Mon, Jun 06, 2011 at 07:12:19PM +0530, Keshava Munegowda wrote:
> > > From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
> > > 
> > > Oops are produced during initialization of ehci and ohci
> > > drivers. This is because the run time pm apis are used by
> > > the driver but the corresponding hwmod structures and
> > > initialization is not merged. 
> > You mean they're currently checked in a different tree ? Is that a
> > public one?
> 
> it was supposed to go via linux-omap tree but the patches got lost in
> the limbo :-(
Then shouldn't those patches be the ones to be sent to Linus as a fix for 3.0 ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
