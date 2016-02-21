From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix onenand initialization to avoid
 filesystem corruption
Date: Sun, 21 Feb 2016 20:13:55 +0200
Message-ID: <56C9FE63.3070602@gmail.com>
References: <linux-kernel@vger.kernel.org>
 <1454683028-4193-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160208193644.GU19432@atomide.com>
 <20160210211226.GB1640@darkstar.musicnaut.iki.fi>
 <20160211001220.GM19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160211001220.GM19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: rogerq@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, pali.rohar@gmail.com, sre@kernel.org, pavel@ucw.cz, nm@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 11.02.2016 02:12, Tony Lindgren wrote:
>
> Also.. There's a chance somebody has created a onenand file system
> with recent mainline kernels that did the reset and disabled ECC.
> So with Ivaylo's patch fixing that, those may not mount properly
> any longer. Most likely people just keep their maemo rootfs there
> though with the MMC being available.

I guess this is possible, but what worries me more is that the longer 
the patch is not pushed, the higher the chance somebody to end-up with 
broken rootfs. Wouldn't it be better to push it, thus preventing that 
happening?

BTW the differences for N9/50 come from ONENAND_SYS_CFG1_HF bit and 
ONENAND_SYS_CFG1_BRL_6 vs ONENAND_SYS_CFG1_BRL_4. Both are changed 
(later in the code) anyway, so I guess it is safe to reset them to 
default values.

Or, maybe the correct fix is to issue RESET command to onenand 
controller after GPMC reset? RESET command is supposed to put all the 
bits to their default values.

Ivo.
