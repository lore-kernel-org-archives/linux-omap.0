From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/20] mach-omap2: mux: world-writable debugfs files
Date: Fri, 4 Feb 2011 12:09:47 -0800
Message-ID: <20110204200947.GB3322@atomide.com>
References: <cover.1296818921.git.segoon@openwall.com>
 <1aa2fe44c18b9f24eb52a1be98d017f1f568e6bb.1296818921.git.segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1aa2fe44c18b9f24eb52a1be98d017f1f568e6bb.1296818921.git.segoon@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: linux-kernel@vger.kernel.org, security@kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Vasiliy Kulikov <segoon@openwall.com> [110204 04:21]:
> Do not create mux debugfs files as world-writable.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> ---
>  Cannot compile the driver, so it is not tested at all.

Thanks, will queue this as a fix for the -rc cycle.

Tony
 
>  arch/arm/mach-omap2/mux.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 98148b6..6c84659 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -605,7 +605,7 @@ static void __init omap_mux_dbg_create_entry(
>  	list_for_each_entry(e, &partition->muxmodes, node) {
>  		struct omap_mux *m = &e->mux;
>  
> -		(void)debugfs_create_file(m->muxnames[0], S_IWUGO, mux_dbg_dir,
> +		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
>  					  m, &omap_mux_dbg_signal_fops);
>  	}
>  }
> -- 
> 1.7.0.4
> 
