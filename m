From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/4] arm: omap4: usb: add platform init code for EHCI
Date: Mon, 6 Dec 2010 11:10:58 -0800
Message-ID: <20101206191058.GK8345@atomide.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
 <1291051572-24084-3-git-send-email-gadiyar@ti.com>
 <20101130214045.GA17222@atomide.com>
 <4CF57566.2060800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CF57566.2060800-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> [101130 13:56]:
> On 12/1/2010 3:10 AM, Tony Lindgren wrote:
> > * Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org> [101129 09:16]:
> >> - Add platform init code for EHCI on OMAP4
> >> - Add pad configuration for PHY and TLL modes
> >>
> >> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> > 
> > Looks OK to me. You might want to check if all these signals
> > are unique though and do not have alternate paths.
> > 
> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> I've checked these manually - for EHCI, all signals are unique
> and come out on exactly one pad. With OHCI though, there are
> alternates for 3 signals of one port.

OK
 
> Also, with the mux framework, it tells us if there are
> duplicates and the framework cannot identify the pad from
> the signal name alone.

Yes I posted a series of patches showing how we can pass
the board specific pin configuration to the platform init
code, so that can be done for the OHCI pins later on.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
