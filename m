From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Tue, 15 Nov 2016 07:52:50 +0100
Message-ID: <CACRpkdZ=pifhHrH_-466f2x3Ev4GKW0CCnTj1hL5Hfpdj5p-1A@mail.gmail.com>
References: <20161025210221.9150-1-tony@atomide.com> <20161025210221.9150-2-tony@atomide.com>
 <CACRpkdaP3_6x0GMpy_+fSok5r+5CP6RvP6dmDCtz4ayAm-TuSQ@mail.gmail.com>
 <20161111202650.GI7138@atomide.com> <20161114205243.GU7138@atomide.com>
 <20161114220824.GC4082@atomide.com> <20161115004703.GG4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115004703.GG4082-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 15, 2016 at 1:47 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> 8< --------------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Tue, 25 Oct 2016 08:33:35 -0700
> Subject: [PATCH] pinctrl: core: Use delayed work for hogs
>
> Having the pin control framework call pin controller functions
> before it's probe has finished is not nice as the pin controller
> device driver does not yet have struct pinctrl_dev handle.
>
> Let's fix this issue by adding deferred work for late init. This is
> needed to be able to add pinctrl generic helper functions that expect
> to know struct pinctrl_dev handle. Note that we now need to call
> create_pinctrl() directly as we don't want to add the pin controller
> to the list of controllers until the hogs are claimed. We also need
> to pass the pinctrl_dev to the device tree parser functions as they
> otherwise won't find the right controller at this point.
>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

This looks a lot better!

So if I understand correctly, we can guarantee that the delayed
work will not execute until the device driver probe() has finished,
and it *will* execute immediately after that?

So:
- Device driver probes
- Delayed work is called
- Next initcall

I'm not 100% familiar with how delayed work works... :/

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
