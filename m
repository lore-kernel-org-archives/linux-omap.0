From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 04/13] OMAP2/3 clock: ensure each clock has a unique
	name
Date: Mon, 17 Aug 2009 10:29:04 +0100
Message-ID: <20090817092904.GA2752@n2100.arm.linux.org.uk>
References: <20090815111704.7384.31564.stgit@localhost.localdomain> <20090815111944.7384.13541.stgit@localhost.localdomain> <20090817084704.GN7278@atomide.com> <alpine.DEB.2.00.0908170259250.18309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0908170259250.18309-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 17, 2009 at 03:14:45AM -0600, Paul Walmsley wrote:
> What it does remove is the need for internal core code to fake up a struct 
> device simply to access a clock.  It also allows us to harmonize the 
> clock names, used internally in core code, with the hardware reality, 
> which uses unique names to identify clocks.

That problem is already solved.  clk_get_sys()
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
