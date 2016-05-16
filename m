From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Mon, 16 May 2016 09:15:12 -0500
Message-ID: <20160516141512.GA8256@uda0271908>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
 <99ff5bff-e2f4-3137-2854-81d7b4b14bce@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <99ff5bff-e2f4-3137-2854-81d7b4b14bce-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sat, May 14, 2016 at 04:30:32PM +0300, Sergei Shtylyov wrote:
> On 5/14/2016 12:03 AM, Bin Liu wrote:
> 
> >>At least 2430 glue layer pulls d+ high on start up even if there are
> >>no gadgets configured. This is bad at least for anything using a separate
> >>battery charger chip as it can confuse the charger detection.
> >>
> >>Let's fix the issue by getting rid of omap2430_musb_set_mode() and only
> >
> >By doing so, you lost the feature of switching mode from sysfs, I am not
> >sure if there is anyone using it though, still, it is a regression.
> 
>    BTW, set_mode() implemented in the OMAP glue always seemed bogus to me.
> Instead of forcing host/gadget/OTG modes, it sets the Session bit...

Setting the session bit here seems to be okay. Other glues rely
otg_timer() instead.

Regards,
-Bin.

> 
> MBR, Sergei
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
