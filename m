From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv5 07/15] hwspinlock/omap: enable build for AM33xx, AM43xx
 & DRA7xx
Date: Tue, 1 Jul 2014 15:53:19 +0300
Message-ID: <CAK=WgbaVzfWLXiX0y9K=-FAG98ywbWojtyyoEket-q5e5pdufA@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-8-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398904476-26200-8-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> HwSpinlocks are supported on AM33xx, AM43xx and DRA7xx SoC
> device families as well. The IPs are identical to that of
> OMAP4/OMAP5, except for the number of locks.
>
> Add a depends on to the above family of SoCs to enable the
> build support for OMAP hwspinlock driver for any of the above
> SoC configs.
>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

This looks too like an independent change. If you want it merged
without waiting for the entire series please submit it separately.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
