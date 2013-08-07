From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: OMAP: rx51: change musb mode to OTG
Date: Wed, 07 Aug 2013 09:43:19 +0200
Message-ID: <5201FA97.2060702@gmail.com>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi> <1375808776-14975-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375808776-14975-3-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On 06.08.2013 19:06, Aaro Koskinen wrote:
> Peripheral-only mode got broken in v3.11-rc1 because of unknown reasons.

Given that you have a board that is affected, could you investigate a
little maybe? I would have done it a long time ago, but I don't have
access to such hardware unfortunately.

Not saying that your patch shouldn't go in, but at some point, we need a
sane explanation why this has happened.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
