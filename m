From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 0/7] ARM/ASoC: OMAP3: Fix McBSP2/3 sidetone support
Date: Thu, 12 May 2016 09:42:01 -0700
Message-ID: <20160512164201.GQ5995@atomide.com>
References: <1461927202-17677-1-git-send-email-peter.ujfalusi@ti.com>
 <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <69ff65ee-e5d1-09fb-fd91-8d7b4d8fdda4-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160511 01:46]:
> Tony, Paul,
> 
> On 04/29/16 13:53, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Based on the ongoing discussion on v2 (ARM: OMAP3: Fix McBSP2/3 hwmod setup for
> > sidetone) I have dropped the removal of the sidetone hwmod and only corrected
> > it. The series now includes all related changes needed to have correct sidetone
> > support whenever we boot in legacy or in DT mode.
> > 
> > This time the ASoC part have dependency on earlier patches so they can not be
> > applied separately.
> 
> How should we proceed from here? I don't want to start designing the ST
> separation infrastructure which would be based on this series, but if there
> are outstanding issues found on this, I would need to go back to the drawing
> board.
> The separation will be mostly new code and code shuffle in ASoC, but for
> legacy I will need to build up something in arch as well, so I would need at
> least one release cycle to start with things.

Well looks like we have all the acks, so I can apply these. We have
not heard from Paul on this for a while, so let's wait few days for
that.

Meanwhile, Mark wanted to fix the subject for one of the patches, care
to repost that at least? Or the whole series with acks, could be a
pull request too against v4.6-rc1 :)

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
