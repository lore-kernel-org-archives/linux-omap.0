From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 00/20] ARM: dts: add omap clkctrl support
Date: Mon, 11 Dec 2017 10:29:22 -0800
Message-ID: <20171211182922.GB14441@atomide.com>
References: <1512746251-20123-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512746251-20123-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [171208 07:20]:
> Hi,
> 
> Just reposting v2 of the relevant patches. The only change in this
> version is the conversion of clkctrl clock handles to use the
> dt-binding macros instead of hardcoded magic values. The contents
> of the compiled .dtb files are completely unchanged in this.
> 
> e.g. clocks = <&l4per_clkctrl 0 0> => <&l4per_clkctrl OMAP4_UART3_CLKCTRL 0>

Thanks applying all 20 picked from the two series into omap-for-v4.16/dt-clk.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
