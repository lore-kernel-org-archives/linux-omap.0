From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] ARM: OMAP2+: Fix updating of sysconfig register
Date: Tue, 1 Mar 2016 17:03:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603011703170.14948@utopia.booyaka.com>
References: <1456832887-5312-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456832887-5312-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>, jonathanh@nvidia.com
Cc: tony@atomide.com, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+ Jon Hunter

On Tue, 1 Mar 2016, Lokesh Vutla wrote:

> commit 127500ccb766f ("ARM: OMAP2+: Only write the sysconfig on idle
> when necessary") talks about verification of sysconfig cache value before
> updating it, only during idle path. But the patch is adding the
> verification in the enable path. So, adding the check in a proper place
> as per the commit description.
> 
> Not keeping this check during enable path as there is a chance of losing
> context and it is safe to do on idle as the context of the register will
> never be lost while the device is active.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e9f65fe..71b3747 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1416,9 +1416,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
>  	    (sf & SYSC_HAS_CLOCKACTIVITY))
>  		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
>  
> -	/* If the cached value is the same as the new value, skip the write */
> -	if (oh->_sysc_cache != v)
> -		_write_sysconfig(v, oh);
> +	_write_sysconfig(v, oh);
>  
>  	/*
>  	 * Set the autoidle bit only after setting the smartidle bit
> @@ -1481,7 +1479,9 @@ static void _idle_sysc(struct omap_hwmod *oh)
>  		_set_master_standbymode(oh, idlemode, &v);
>  	}
>  
> -	_write_sysconfig(v, oh);
> +	/* If the cached value is the same as the new value, skip the write */
> +	if (oh->_sysc_cache != v)
> +		_write_sysconfig(v, oh);
>  }
>  
>  /**
> -- 
> 2.1.4
> 


- Paul
