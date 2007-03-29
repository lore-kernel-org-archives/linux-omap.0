From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Move N800 specific OneNand setup to N800 platform file,
	was: Basic N800 support
Date: Thu, 29 Mar 2007 16:15:02 -0400
Message-ID: <20070329201459.GH3638@atomide.com>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070301134533.GA15801@angel.research.nokia.com>
	<00a901c75c64$01b1e830$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070302164855.GA313@angel.research.nokia.com>
	<45EA99D0.8010103@googlemail.com>
	<20070307115754.GH21093@atomide.com>
	<004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <004201c7611f$bae52b90$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kyungmin Park <kmpark@infradead.org> [070307 21:19]:
> ARM: OMAP: Fix old interrupt handler function in omap2-onenand
> 
> Fix old interrupt handler function in omap2-onenand
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mtd/onenand/omap2.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index bbc9beb..96fcb5f 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -80,8 +80,7 @@ static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
>  	complete(&info->dma_done);
>  }
>  
> -static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id,
> -					   struct pt_regs *regs)
> +static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
>  {
>  	struct omap2_onenand *info = dev_id;
>  

Pushing this today.

Tony
