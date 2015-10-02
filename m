From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: Remove __ref on hotplug cpu die path
Date: Fri, 2 Oct 2015 03:04:00 -0700
Message-ID: <CACRpkdbgM30DTB_pZedMUnyzQ9nR9hn=JN8SUA6JWK0zPktuZg@mail.gmail.com>
References: <1442276597-14325-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442276597-14325-1-git-send-email-sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 14, 2015 at 5:23 PM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> Now that __cpuinit has been removed, the __ref markings on these
> functions are useless. Remove them. This also reduces the size of
> the multi_v7_defconfig image:
>
> $ size before after
>    text    data     bss     dec     hex filename
>    12683578        1470996  348904 14503478         dd4e36 before
>    12683274        1470996  348904 14503174         dd4d06 after
>
> presumably because now we don't have to jump to code in the
> .ref.text section and/or the noinline marking is removed.
>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Cc: <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
> Cc: <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
