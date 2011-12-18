From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v5 1/5] ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
Date: Sat, 17 Dec 2011 20:23:56 -0800
Message-ID: <CAOesGMibYSA-hJUzpeqFAR0NwewvqHYgujU7SW6-Ua7vxC=-3w@mail.gmail.com>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
	<1323964434-6764-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323964434-6764-2-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 15, 2011 at 7:53 AM, Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> w=
rote:
> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines. =A0To enable this,
> a new MIGHT_HAVE_CACHE_L2X0 config option is introduced to allow
> machines to indicate that they may have such a cache controller
> independently of each other.
>
> Boards/SoCs which cannot reliably operate without the L2 cache
> controller support will need to select CACHE_L2X0 directly from
> their own Kconfigs instead. =A0This applies to some TrustZone-enabled
> boards where Linux runs in the Normal World, for example.
>
> Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> =A0 =A0 =A0 =A0(for cns3xxx)
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> =A0 =A0 =A0 =A0(for omap)

Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> (for tegra)


-Olof
