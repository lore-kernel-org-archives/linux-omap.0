From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 1/9] ARM: OMAP2+: use common l2cache initialization code
Date: Mon, 05 Jan 2015 21:25:17 +0100
Message-ID: <2975078.sXsfBJkaoi@wuerfel>
References: <1420460348-20302-1-git-send-email-m.szyprowski@samsung.com> <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1420460348-20302-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, nm@ti.com, linux-samsung-soc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, tony@atomide.com, linus.walleij@linaro.org, Tomasz Figa <tomasz.figa@gmail.com>, drake@endlessm.com, loeliger@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, khilman@linaro.org
List-Id: linux-omap@vger.kernel.org

On Monday 05 January 2015 13:19:00 Marek Szyprowski wrote:
>  DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
> +       .l2c_aux_val    = OMAP_L2C_AUX_CTRL,
> +       .l2c_aux_mask   = 0xcf9fffff,
> +       .l2c_write_sec  = omap4_l2c310_write_sec,
>         .reserve        = omap_reserve,
>         .smp            = smp_ops(omap4_smp_ops),
>         .map_io         = omap4_map_io,
> 

Could we also get those values into the dts files? Clearly we
can't remove them here without breaking compatibility with old
dtbs, but it would be nice to have all new dtbs do the right thing.

	Arnd
