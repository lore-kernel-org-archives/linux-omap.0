From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 5/6] ARM: DRA7: hwmod: Add VPE nodes
Date: Fri, 13 Oct 2017 10:05:13 -0700
Message-ID: <20171013170513.GM4394@atomide.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-6-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171012192719.15193-6-bparrot@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [171012 12:28]:
> +static struct omap_hwmod_class_sysconfig dra7xx_vpe_sysc = {
> +	.sysc_offs	= 0x0010,
> +	.sysc_flags	= (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> +			   MSTANDBY_FORCE | MSTANDBY_NO |
> +			   MSTANDBY_SMART),
> +	.sysc_fields	= &omap_hwmod_sysc_type2,
> +};

I think checkpatch.pl --strict would complain about unnecessary
parentheses, might as well check the whole series while at it.

Regards,

Tony
