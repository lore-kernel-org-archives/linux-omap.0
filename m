From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] rtc: omap: Add external clock enabling support
Date: Fri, 14 Aug 2015 12:54:23 +0200
Message-ID: <20150814105423.GA20570@localhost>
References: <1439449668-32301-1-git-send-email-j-keerthy@ti.com>
 <1439449668-32301-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439449668-32301-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 13, 2015 at 12:37:48PM +0530, Keerthy wrote:
> Configure the clock source to either internal clock
> or external clock based on the availability of the clocks.
> External clock is preferred as it can be ticking during suspend.
> 
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

> @@ -627,6 +642,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (reg != new_ctrl)
>  		rtc_write(rtc, OMAP_RTC_CTRL_REG, new_ctrl);
>  
> +	/*
> +	 * If we have the external clock then
> +	 * Switch to external clock so we can keep ticking
> +	 * acorss suspend
> +	 */

You should fix up the comment (e.g. stray capitalisation and typo) as
well.

Perhaps reword as

	/*
	 * If we have an external clock then switch to it so we can keep
	 * ticking across suspend.
	 */

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
