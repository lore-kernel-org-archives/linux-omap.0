From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: OMAP: AM43xx hwmod: Add data for am43xx emif
 hwmod
Date: Tue, 2 Jun 2015 18:37:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506021837080.14902@utopia.booyaka.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com> <1430933133-33412-2-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430933133-33412-2-git-send-email-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 6 May 2015, Dave Gerlach wrote:

> Without a hwmod for am43xx emif use counting for emif clockdomain does
> not happen correctly so it may be shut off by pm code unintentionally.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>

Thanks, sent upstream for v4.2.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
