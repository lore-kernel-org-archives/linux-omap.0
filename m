From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 21/22] ARM: OMAP2+: clock data: get rid of unused USB
 host clock aliases
Date: Thu, 29 Nov 2012 11:24:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1211291122290.20529@utopia.booyaka.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com> <1354114150-11941-22-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354114150-11941-22-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 28 Nov 2012, Roger Quadros wrote:

> We don't need multiple aliases for the OMAP USB host clocks so remove them.
> Also use NULL dev_id for 'usb_tll_hs_usb_ch0_clk' and 'usb_tll_hs_usb_ch1_clk'
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> CC: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |   11 -----------
>  1 files changed, 0 insertions(+), 11 deletions(-)

Looks okay to me, but this will need to be updated to apply after the 
common clock framework conversion patches are merged.  Maybe respin this 
against what's in arm-soc/for-next ?


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
