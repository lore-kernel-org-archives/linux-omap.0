From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5 v13] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Tue, 11 Oct 2011 12:52:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110111136280.1664@utopia.booyaka.com>
References: <20111011081352.GC10155@legolas.emea.dhcp.ti.com> <Pine.LNX.4.44L0.1110111000460.2177-100000@iolanthe.rowland.org> <20111011140839.GF12293@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111011140839.GF12293-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, vishwanath.bs-l0cyMroinI0@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe

On Tue, 11 Oct 2011, Felipe Balbi wrote:

> maybe, but let's go with EXPORT_SYMBOL_GPL(). My only concern is that
> this IP comes from synopsys, and I'm not really keen on adding
> OMAP-specific, integration-related knowledge on a driver which was
> supposed to be reusable ;-)
>
> But at least for the time being, I guess that's what we need to do ;-)

Which IP is coming from Synopsys - the TLL ?  The EXPORT_SYMBOL approach 
shouldn't add anything OMAP-specific to the TLL driver.  So the exported 
symbols should still be usable by drivers on other SoCs.  But perhaps I am 
misunderstanding your point?

- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
