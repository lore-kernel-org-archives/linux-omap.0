From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: DRA7: clockdomain: Implement timer workaround
 for errata i874
Date: Sun, 10 Apr 2016 17:44:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604101744350.11457@utopia.booyaka.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com> <1459892652-47845-5-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459892652-47845-5-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 5 Apr 2016, Suman Anna wrote:

> From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> 
> Errata Title:
> i874: TIMER5/6/7/8 interrupts not propagated
> 
> Description:
> When TIMER5, TIMER6, TIMER7, or TIMER8 clocks are enabled
> (CM_IPU_TIMER5/6/7/8_CLKCTRL[0:1]MODULEMODE=0x2:ENABLE) and the CD-IPU
> is in HW_AUTO mode (CM_IPU_CLKSTCTRL[0:1]CLKTRCTRL=0x3:HW_AUTO) the
> corresponding TIMER will continue counting, but enabled interrupts
> will not be propagated to the destinations (MPU, DSP, etc) in the
> SoC until the TIMER registers are accessed from the CPUs (MPU, DSP
> etc.). This can result in missed timer interrupts.
> 
> Workaround:
> In order for TIMER5/6/7/8 interrupts to be propagated and serviced
> correctly the CD_IPU domain should be set to SW_WKUP mode
> (CM_IPU_CLKSTCTRL[0:1]CLKTRCTRL=0x2:SW_WKUP).
> 
> The above workaround is achieved by switching the IPU clockdomain
> flags from HWSUP_SWSUP to SWSUP only.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Thanks, queued for v4.6-rc fixes.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
