From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ARM: ATAGS: move atags.h to include/asm so it can be
 included by files outside kernel/
Date: Thu, 24 Dec 2015 15:35:36 +0000
Message-ID: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
References: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450965658-2675-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450965658-2675-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, nicolas.pitre@linaro.org, arnd@arndb.de, pali.rohar@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 24, 2015 at 04:00:56PM +0200, Ivaylo Dimitrov wrote:
> This is needed by a follow-up patch that saves atags on RX51 device
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  arch/arm/include/asm/atags.h  | 20 ++++++++++++++++++++
>  arch/arm/kernel/atags.h       | 20 --------------------

Please generate diffs with -M so that it can detect renames and provide
a more sensible diffstat and patch output (so we can see any changes
through the rename.)  However...

>  arch/arm/kernel/atags_parse.c |  3 +--
>  arch/arm/kernel/setup.c       |  3 +--
>  4 files changed, 22 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm/include/asm/atags.h
>  delete mode 100644 arch/arm/kernel/atags.h
> 
> diff --git a/arch/arm/include/asm/atags.h b/arch/arm/include/asm/atags.h
> new file mode 100644
> index 0000000..ec4164d
> --- /dev/null
> +++ b/arch/arm/include/asm/atags.h
> @@ -0,0 +1,20 @@
> +#ifdef CONFIG_ATAGS_PROC
> +extern void save_atags(struct tag *tags);
> +#else
> +static inline void save_atags(struct tag *tags) { }
> +#endif
> +
> +void convert_to_tag_list(struct tag *tags);
> +
> +#ifdef CONFIG_ATAGS
> +const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
> +	unsigned int machine_nr);
> +#else
> +static inline const struct machine_desc *
> +setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
> +{
> +	early_print("no ATAGS support: can't continue\n");
> +	while (true);
> +	unreachable();
> +}
> +#endif
> diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> deleted file mode 100644
> index ec4164d..0000000
> --- a/arch/arm/kernel/atags.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#ifdef CONFIG_ATAGS_PROC
> -extern void save_atags(struct tag *tags);
> -#else
> -static inline void save_atags(struct tag *tags) { }
> -#endif

I'd think I'd prefer moving just the above save_atags declaration to
arch/arm/include/asm/setup.h so we're not allowing the rest of this
to be exposed to anyone who includes asm/atags.h.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
