From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 4/4] mfd: global Suspend and resume support of ehci and
	ohci
Date: Mon, 6 Jun 2011 10:45:25 +0100
Message-ID: <20110606094524.GA23682@sirena.org.uk>
References: <20110605185047.GB18731@legolas.emea.dhcp.ti.com> <Pine.LNX.4.44L0.1106051519560.5916-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1106051519560.5916-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jun 05, 2011 at 03:30:55PM -0400, Alan Stern wrote:
> On Sun, 5 Jun 2011, Felipe Balbi wrote:

> > that would mean changes to all linker scripts, though and a utility call
> > that only does anything ifndef CONFIG_PM to free the .pm.ops section.

> In my opinion this would make programming harder, not easier.  It's
> very easy to understand "#ifdef" followed by "#endif"; people see them
> all the time.  The new tags you propose would force people to go
> searching through tons of source files to see what they mean, and then
> readers would still have to figure out when these tags should be used
> or what advantage they might bring.

The big advantage is that they make it much harder to introduce random
build breakage and they're an awful lot less fiddly to do - it used to
be not so bad when it was just the function pointers that needed to be
defined to NULL but now we need to faff around with both the functions
and the dev_pm_ops.

The annotation approach is already familiar from the init stuff so it
wouldn't be so hard for people to understand.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
