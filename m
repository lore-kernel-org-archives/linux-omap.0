From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Wed, 6 Sep 2017 06:30:57 -0700
Message-ID: <20170906133057.GH5024@atomide.com>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170905233241.GA19231@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

* Joonsoo Kim <iamjoonsoo.kim@lge.com> [170905 16:32]:
> I think that I made a mistake for configuration CONFIG_HIGHMEM=y and
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y. In this case, the MOVABLE_ZONE can
> be *!highmem*. Could you check that your configuration have above
> options?

CONFIG_HIGHMEM is set yeah.

> And, could you check that following patch works for you?

Does not seem to help, tried against next with just 9caf25f996e8
revert and also with 9caf25f996e8.

Regards,

Tony


> ------------>8-----------------
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 38f0fde..4c39c92 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -518,7 +518,7 @@ void __init dma_contiguous_remap(void)
>                  * considered as highmem even if it's physical address belong
>                  * to lowmem. Therefore, re-mapping isn't required.
>                  */
> -               if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               if (!is_highmem_idx(ZONE_MOVABLE))
>                         iotable_init(&map, 1);
>         }
>  }
> 
