From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 10/14] ARM: OMAP2+: Remove legacy data from hwmod for omap3
Date: Tue, 14 Feb 2017 10:59:42 -0600
Message-ID: <CAHCN7x+XEnu2agB6mjre8-RdS-MAE3Zh2HGPQcpohfxhmMM0PA@mail.gmail.com>
References: <20161111191711.5079-1-tony@atomide.com>
 <20161111191711.5079-11-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-11-tony@atomide.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2016 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> This data is now coming from device tree so we can remove the
> duplicate data. Let's keep the DSS and DMA related things for now
> until those have been converted to device tree completely.
>
> While at it, let's also add the trailing commas to data structures
> so further processing with scripts will be a bit easier.
>
Tony,

I am having some errors with this patch.

Smartreflex on a DM3730 drops a few errors:

[    1.209747] smartreflex smartreflex.0: invalid resource
[    1.215301] smartreflex smartreflex.0: omap_sr_probe: ioremap fail
[    1.221832] smartreflex smartreflex.1: invalid resource
[    1.227294] smartreflex smartreflex.1: omap_sr_probe: ioremap fail
[    1.233856] sr_init: platform driver register failed for SR

I used Git bisect to narrow it down to this patch, and I confirmed it
manually.  Sorry it took so long to get feedback on this, but I was on
vacation.

I attempted to just add back the smartreflex stuff for the omap36xx,
but that didn't work.  I am going to assume something is missing or
wrong in the device tree, but I could be wrong. If you  have any
suggestions before I go down a rabbit hole, I am open for ideas.

adam


> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../omap_hwmod_2xxx_3xxx_interconnect_data.c       | 149 +---
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c | 201 +-----
>  .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   4 -
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 787 +--------------------
>  arch/arm/mach-omap2/omap_hwmod_common_data.h       |  15 -
>  6 files changed, 43 insertions(+), 1114 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
> --- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
> @@ -17,156 +17,11 @@
>
[ Stuff Deleted]

> --
> 2.10.2
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
