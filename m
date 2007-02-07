From: Timo Teras <timo.teras@solidboot.com>
Subject: Re: Basic N800 support
Date: Wed, 7 Feb 2007 08:10:35 +0200
Message-ID: <20070207061035.GA10633@mail.solidboot.com>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
	<000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
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

Hi,

On Wed, Feb 07, 2007 at 02:16:58PM +0900, Kyungmin Park wrote:
> Finally it don't need to configure IOBE in omap2_onenand_wait
> 
> #if 0
>                 /* Turn interrupts on */
>                 syscfg = omap2_onenand_readw(info->onenand.base +
> ONENAND_REG_SYS_CFG1);
>                 syscfg |= ONENAND_SYS_CFG1_IOBE;
>                 omap2_onenand_writew(syscfg, info->onenand.base +
> ONENAND_REG_SYS_CFG1);
> #endif
> #if 0
>                 /* Turn interrupts off */
>                 syscfg = omap2_onenand_readw(info->onenand.base +
> ONENAND_REG_SYS_CFG1);
>                 syscfg &= ~ONENAND_SYS_CFG1_IOBE;
>                 omap2_onenand_writew(syscfg, info->onenand.base +
> ONENAND_REG_SYS_CFG1);
> #endif

Yes, this is not strictly necessery. But we noticed that using polling
instead of interrupts for some operations give slightly better
performance.

Cheers,
  Timo
