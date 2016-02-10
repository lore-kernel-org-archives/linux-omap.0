From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid
 filesystem corruption
Date: Wed, 10 Feb 2016 23:12:26 +0200
Message-ID: <20160210211226.GB1640@darkstar.musicnaut.iki.fi>
References: <linux-kernel@vger.kernel.org>
 <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160208193644.GU19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160208193644.GU19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, rogerq@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, sre@kernel.org, pavel@ucw.cz, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Feb 08, 2016 at 11:36:45AM -0800, Tony Lindgren wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160205 06:38]:
> > Commit <e7b11dc7b77bfce0a351230a5feeadc1d0bba997> ("ARM: OMAP2+: Fix
> > onenand rate detection to avoid filesystem corruption") partially fixed
> > onenand configuration when GPMC module is reset. Finish the job by also
> > providing the correct values in ONENAND_REG_SYS_CFG1 register.
> 
> OK. So probably the INT or RDY polarity made the ECC not work.
> 
> Aaro, care to dump out also the nolo configured CFG1 value from
> n8x0 and n9(50)?
> 
> You can do it by adding something like this to the beginning
> of set_onenand_cfg():
> 
> pr_info("CFG1: 0x%04x\n", readw(onenand_base + ONENAND_REG_SYS_CFG1));
> 
> And presumably the values are the same as on n900. If not, we
> should do the legacy file system flash test on all of them
> before committing this fix.

I got these (with CONFIG_OMAP_GPMC_DEBUG also enabled):

N800:
[    2.803100] CFG1: 0x46c0
[    3.150115] CFG1: 0x06c0

N810:
[    2.802368] CFG1: 0x46c0
[    3.148620] CFG1: 0x06c0

N900:
[    4.965576] CFG1: 0x46c0
[    5.333740] CFG1: 0x06c0

N950:
[    4.217193] CFG1: 0x66c4
[    4.583221] CFG1: 0x06c0

N9:
[    4.212677] CFG1: 0x66c4
[    4.578613] CFG1: 0x06c0

A.
