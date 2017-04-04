From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Mon, 3 Apr 2017 20:27:09 -0700
Message-ID: <20170404032708.GM10760@atomide.com>
References: <20170322234602.5888-1-tony@atomide.com>
 <d47b0f99-1ef8-3bff-0fbe-edb95ed41e23@ti.com>
 <20170327150518.GH10760@atomide.com>
 <3661b0cc-bf79-0347-ae4c-db6bdfdf6293@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3661b0cc-bf79-0347-ae4c-db6bdfdf6293-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> [170330 04:51]:
> On Monday 27 March 2017 08:35 PM, Tony Lindgren wrote:
> > Seems this can be also done when implementing PM runtime handling.
> > If you want some of these changes done for the initial patch,
> > please let me know.
> 
> I think it's better we get extcon stuff in the initial patch so that we don't
> have to maintain some piece of code for legacy dt. Others can be added later.

Sure, I'll take a look at that hopefully this week at some
point.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
