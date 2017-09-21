From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/16] gpio: Tight IRQ chip integration and banked infrastructure
Date: Thu, 21 Sep 2017 14:06:35 +0200
Message-ID: <CACRpkdarDaDtWieC0rfGOQH-Hp9xa3kwhT2fPttU-dOGErE8Pw@mail.gmail.com>
References: <20170901185736.28051-1-thierry.reding@gmail.com>
 <CACRpkdaRsG-9YU2ufb+FxGOO38+x=AAfVUqxH5s56NH2iLw7oA@mail.gmail.com>
 <20170914185233.GA6410@aiwendil> <20170915165750.GW5024@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170915165750.GW5024-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 15, 2017 at 6:57 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> On omaps, each bank is a separate driver instance with it's own
> interrupt. Maybe really all we need to do is get rid of the "bank"
> naming, I think that's left over from 15 years ago when we did not
> have separate driver instances. It seems we should s/bank/ddata/
> on the driver to avoid confusion.

OK sorry maybe OMAP is not a target for this, I just thought so
since it was one of the platforms that is patches in the patch
series.

But I'm pretty sure we have chips with banking like this: separate
interrupts but a single device. I would have to read through them
all I guess.

Yours,
Linus Walleij
