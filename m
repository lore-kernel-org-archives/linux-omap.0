From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and
 CPSW
Date: Tue, 22 Jul 2014 15:41:43 +0530
Message-ID: <53CE38DF.1060305@ti.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com> <20140717074948.GF18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140717074948.GF18374-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 17 July 2014 01:19 PM, Tony Lindgren wrote:
> We seem to have this layout WR_SOFT_RESET and WR_CONTROL in the TRM:
>
> WR_SOFT_RESET
> [0]     SOFT_RESET
>
> WR_CONTROL
> [3:2]   MMR_STDBYMODE   0 = force-idle, 1 = no-standby
> [1:0]   MMR_IDLEMODE    0 = force-idle, 1 = no-idle
>
> And so it seems to match what am33xx also has for am33xx_cpgmac_sysc
> and am33xx TRM for 14.5.9 CONTROL register. So as far as I'm concerned:
>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Paul,

Can you pull this patch as Tony acked the patch.

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
