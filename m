From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for
 sidetone
Date: Sat, 19 Mar 2016 19:38:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458311007-19168-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 18 Mar 2016, Peter Ujfalusi wrote:

> Hi,
> 
> Chanes since v1:
> - removed the ASoC patch as Mark has applied it already
> - Added my signed-off to the hwmod patch
> - New patch to handle the case when the sidetone hwmod has been removed for
>   legacy boot.
> 
> The series addresses a long standing issue with McBSP2/3 regarding to hwmod
> setup. When booting with DT a warning is printed that mcbsp2/3 is using two
> hwmod.
> The root of the issue is the way how the hwmod data was constructed in the first
> place for OMAP3 McBSP2/3.
> After re-reading the TRM it is clear that the sidetone should not have it's
> own hwmod data as it is not a separate IP, it is part of the McBSP module. It
> can not affect PRCM either since it's SYSCONFIG register's AUTOIDLE bit is only
> sets the autoidle from the internal McBSP_iclk clock to the sidetone block of
> the same McBSP.

NAK, at least without further discussion - see my comments on the v1 0/3 
introduction.

- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
