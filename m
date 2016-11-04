From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and pinctrl_parse_index_with_args
Date: Fri, 4 Nov 2016 22:36:32 +0100
Message-ID: <CACRpkdaSy7YeTmdGXd0b6iDvXEFYHjf0Om2prRJ0BZZkb4=qEw@mail.gmail.com>
References: <20161025164538.453-1-tony@atomide.com> <20161025164538.453-2-tony@atomide.com>
 <CACRpkdYWB4aa2XvW-yT39cKqy3XChSwCiFRy1mVWhbhse63=3A@mail.gmail.com>
 <20161027141120.jqvul6q7iz5fjsmb@atomide.com> <20161028165338.y5fyavbw5xfxweg3@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161028165338.y5fyavbw5xfxweg3-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 28, 2016 at 6:53 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Tue, 25 Oct 2016 08:33:34 -0700
> Subject: [PATCH] pinctrl: Introduce generic #pinctrl-cells and
>  pinctrl_parse_index_with_args
>
> Introduce #pinctrl-cells helper binding and generic helper functions
> pinctrl_count_index_with_args() and pinctrl_parse_index_with_args().
>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

This updated version applied with Rob's ACK.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
