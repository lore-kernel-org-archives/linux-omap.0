From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 2/2] ARM: OMAP2+: Export SoC information to userspace
Date: Mon, 11 Feb 2013 09:56:53 -0800
Message-ID: <20130211175653.GQ4801@atomide.com>
References: <1360191049-24017-1-git-send-email-ruslan.bilovol@ti.com>
 <1360191049-24017-3-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360191049-24017-3-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Ruslan Bilovol <ruslan.bilovol@ti.com> [130206 14:54]:
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -602,6 +602,7 @@ void __init omap4430_init_late(void)
>  	omap2_common_pm_late_init();
>  	omap4_pm_init();
>  	omap2_clk_enable_autoidle_all();
> +	omap_soc_device_init();
>  }
>  #endif

Looks like this should be called for all omaps instead
of just omap4430?

I suggest you create omap_common_init_late() that
calls all the common init_late functions:

static void __init omap_common_init_late(void)
{
	omap_mux_late_init();
	omap2_common_pm_late_init();
	omap_soc_device_init();
}

Needs to be verified that these really are common to
all omap2+ though :)

Regards,

Tony
