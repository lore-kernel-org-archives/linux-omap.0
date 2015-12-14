From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*
Date: Mon, 14 Dec 2015 09:19:30 +0100
Message-ID: <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pratyush Anand <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Richard.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, rfi-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, Ley Foon Tan <lftan@al>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
<paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org> wrote:
> This series of commits is a slice of a larger project to ensure
> people don't have dead code for module removal in non-modular
> drivers.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, etc. and we continue to work on other areas.
>
> There are several reasons to not use module_init for code that can
> never be built as a module, but the big ones are:
>
>  (1) it is easy to accidentally code up unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>       modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else.
>
> Here we convert some module_init() calls into device_initcall() and delete
> any module_exit and remove code that gets orphaned in the process, for
> an overall net code reduction, which is always welcome.
>
> The use of device_initcall ensures that the init function ordering
> remains unchanged, but one could argue that PCI host code might be more
> appropriate to be handled under subsys_initcall.  Fortunately we can
> revisit making this extra change at a later date if desired; it does
> not need to happen now, and we reduce the risk of introducing
> regressions at this point in time by separating the two changes.
>
> Over half of the drivers changed here already explicitly disallowed any
> unbind operations.  For the rest we make them the same, since there is
> not really any sensible use case to unbind any built-in bus support that
> I can think of.

Personally, I think all of these should become tristate, so distro kernels
don't have to build in PCI(e) support for all SoCs. multi_v7_defconfig kernels
are becoming too big.

That does not preclude making these modules un-unloadable, though.

> Paul Gortmaker (10):
>   drivers/pci: make host/pci-imx6.c driver explicitly non-modular
>   drivers/pci: make host/pcie-spear13xx.c driver explicitly non-modular
>   drivers/pci: make host/pci-mvebu.c explicitly non-modular
>   drivers/pci: make host/pci-dra7xx.c explicitly non-modular
>   drivers/pci: make host/pci-rcar-gen2.c explicitly non-modular
>   drivers/pci: make host/pci-tegra.c explicitly non-modular
>   drivers/pci: make host/pcie-rcar.c explicitly non-modular
>   drivers/pci: make host/pcie-xilinx.c explicitly non-modular
>   drivers/pci: make host/pci-keystone.c explicitly non-modular
>   drivers/pci: make host/pcie-altera.c explicitly non-modular

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
