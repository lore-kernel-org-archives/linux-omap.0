From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/30] ARM: OMAP2+: hwmod module clock type support
Date: Mon, 11 Apr 2016 10:40:59 -0700
Message-ID: <20160411173518.GA5995@atomide.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Nice to see this moving along :)

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [160411 01:20]:
>
> The ordering on this set is kind of tricky to avoid any boot issues,
> and it still currently causes a boot breakage between the DTS data
> introduction and removal of hwmod data; this generates duplicate
> entries for clocks which is prone to cause issues (both DT and hwmod
> have the same entries in place under the hwmod data is removed.) I
> didn't quite figure out a good way to avoid this, and could use some
> guidance here. Shall we squash the DT + hwmod data patches together?
> This avoids the boot breakage but creates pretty large patches. Also,
> AMx3xx data needs to be grouped together as part of their data is
> re-used commonly by both SoCs.

How about use clocks from dts if clocks property is defined? Otherwise
fall back to the old static data. Then drop the static data later on
with follow up patches.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
