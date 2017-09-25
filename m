From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Mon, 25 Sep 2017 17:08:06 +0900
Message-ID: <20170925080806.GA9837@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd>
 <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com>
 <20170913075516.GA25036@js1304-P5Q-DELUXE>
 <20170913163126.GS5024@atomide.com>
 <20170915065608.GA8567@js1304-P5Q-DELUXE>
 <20170921172811.GB4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921172811.GB4394@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 21, 2017 at 10:28:11AM -0700, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [170914 23:55]:
> > On Wed, Sep 13, 2017 at 09:31:27AM -0700, Tony Lindgren wrote:
> > > Yes I disabled CONFIG_HIGHMEM and n900 boots. To disable it,
> > > you need to remove it from arch/arm/mach-omap2/Kconfig that
> > > selects it if ARCH_OMAP2PLUS_TYPICAL is selected.
> > 
> > Okay. Problem would be related to address traslation. I'd like to
> > check address traslation more. Could you apply following patch and
> > test it? And, please send me the dmesg log and your kernel config.
> > Please test this with CONFIG_DEBUG_VIRTUAL = n and CONFIG_CMA_DEBUG=y and
> > CONFIG_HIGHMEM=y and with kernel bootparam 'ignore_loglevel'.
> > 
> > It would be really appreciate if you send me two logs for before/after
> > commit 9caf25f996e8.
> 
> Sorry for the delays, I finally got around testing this for you.

No problem! I really appreciate your help!

> Compile with your patch failed for modules with __virt_to_phys_debug
> being undefined so I added EXPORT_SYMBOL there. I also enabled DEBUG_LL
> and EARLYPRINTK to get output.
> 
> Below is dmesg output for 9caf25f996e8 + your patch. I'll send you
> the full logs separately.

Hmm...there is only one caller for the CMA memory, that is, atomic_pool_init().
Could you test one more time with 9caf25f996e8 + following patch?  I'd like to
know the actual user for the CMA memory.

Thanks.

-------------------------->8------------------------
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 519c294..c68f34a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -587,6 +587,8 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
                ptr = (void *)val;
        }
 
+       dump_stack();
+
        return ptr;
 }
 
