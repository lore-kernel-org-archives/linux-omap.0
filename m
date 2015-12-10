From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm
 twd and global timers
Date: Wed, 9 Dec 2015 16:47:02 -0800
Message-ID: <20151210004702.GD23396@atomide.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
 <87wpsolsvo.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wpsolsvo.fsf-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, t-kristo-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [151208 10:05]:
> 
> Hi,
> 
> Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:
> > ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
> > But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
> > Timekeeping core misbehaves. For example, execution of command
> > "sleep 5" will take 10 sec instead of 5.
> >
> > Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
> > it for clocking ARM TWD and Global timer (same way as on OMAP4).
> >
> > Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> > Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SCU nodes")
> > Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> 
> this seems to be the best fix for this problem, yeah.
> 
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

OK applying into omap-for-v4.4/fixes thanks.

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
