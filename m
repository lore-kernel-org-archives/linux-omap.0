From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH 07/11] ARM: OMAP2+: Remove unused legacy code for DMA
Date: Thu, 8 Jun 2017 06:56:04 -0500
Message-ID: <20170608115604.GX8773@uda0271908>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-8-tony@atomide.com>
 <10f65a24-0459-5df7-378d-84933b83c070@ti.com>
 <20170608082432.GF3730@atomide.com>
 <20170608095618.GJ3730@atomide.com>
 <300ceefe-b015-60d2-2ebf-57dea9fd1d8b@ti.com>
 <20170608104537.GK3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170608104537.GK3730@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 08, 2017 at 03:45:38AM -0700, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170608 03:40]:
> > unfortunately we still have conflict as the
> > https://patchwork.kernel.org/patch/9734219/
> > adds entries to omap24xx_sdma_map[] for - back then - valid non DT boot
> > support.
> > 
> > I have rebased and reworked my patch locally on top of your v1, but
> > things must go in in a certain order to avoid conflict.
> > 
> > The tsub conversion series in not yet in linux-next, but afaik Bin
> > already applied it to somewhere.

Yes, the series is in my local tree which is not public available. I
plan to send them to GregKH next week.

> > Leave the mach-omap2/dma.c cleanup for -rc1?
> 
> OK I'll save this for later then.
> 
> Regards,
> 
> Tony

Regards,
-Bin.
