From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: Basic N800 support
Date: Wed, 7 Feb 2007 14:16:58 +0900
Message-ID: <000101c74a77$39e94120$c7a3580a@swcenter.sec.samsung.co.kr>
References: <13020905.97851169452503947.JavaMail.weblogic@ep_ml23>
	<20070122171254.GD7382@atomide.com>
	<20070206213648.GH9311@atomide.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070206213648.GH9311@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony, 

> > > P.S., Is it possible to change 'omap2.c' in 
> drivers/mtd/onenand to 
> > > 'n800.c' or another? It's not generic for OMAP2. :)
> > 
> > Sure, maybe there's some code that should be shared though?
> 
> Kyungmin, can you list what else makes the N800 onenand 
> support non-generic other than the GPMC timings that should 
> come from board-*.c files?

Only things are GPMC and OneNAND configuration.

GPMC timings should be set in platform file such as board-n800-onenand.c or
bootloader
and don't need to configure the OneNAND system configuration in omap2.c

In apollon, we configure GPMC timings and OneNAND configuration at
bootloader
and don't modify in the kernel code.

In the previous time, OneNAND MTD don't probe chip when sync. mode enabled.
Now it can find the chip whether sync. mode or not
In omap2.c it set OneNAND as async mode, probe it and then set sync. mode.
I think it is reasons based on this history.

Finally it don't need to configure IOBE in omap2_onenand_wait

#if 0
                /* Turn interrupts on */
                syscfg = omap2_onenand_readw(info->onenand.base +
ONENAND_REG_SYS_CFG1);
                syscfg |= ONENAND_SYS_CFG1_IOBE;
                omap2_onenand_writew(syscfg, info->onenand.base +
ONENAND_REG_SYS_CFG1);
#endif
#if 0
                /* Turn interrupts off */
                syscfg = omap2_onenand_readw(info->onenand.base +
ONENAND_REG_SYS_CFG1);
                syscfg &= ~ONENAND_SYS_CFG1_IOBE;
                omap2_onenand_writew(syscfg, info->onenand.base +
ONENAND_REG_SYS_CFG1);
#endif

Thank you,
Kyungmin Park
