From: Joerg Roedel <jroedel@suse.de>
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
Date: Thu, 6 Aug 2015 22:17:24 +0200
Message-ID: <20150806201724.GC10112@suse.de>
References: <E1ZNIul-0007IF-Ev@optimist>
 <20150806180156.GC20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150806180156.GC20873@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Salva =?iso-8859-1?Q?Peir=F3?= <speirofr@gmail.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 06, 2015 at 07:01:56PM +0100, Mark Brown wrote:
> On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an ARM allmodconfig with:
> 
> > ../drivers/iommu/omap-iommu-debug.c:138:2: error: void value not ignored as it ought to be
> 
> caused by a combination of 1ba2f20ac (fs/seq_file: convert int
> seq_vprint/seq_printf/etc... returns to void) which made seq_printf()
> return void and e203db293863fa15 (iommu/omap: Fix debug_read_tlb() to
> use seq_printf()) which has been in -next for a little while now.

Whoops. Thanks for the report, I'll fix it tomorrow.


	Joerg
