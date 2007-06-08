From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Adding copyright header to omap24xx.h
Date: Fri, 8 Jun 2007 03:17:47 -0700
Message-ID: <20070608101746.GE28556@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701121806@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C4701121806@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <x0khasim@ti.com> [070607 16:59]:
> Adding Copyright header
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Can you please leave out this part from your patches in general?

> 
> Files:
>  omap24xx.h |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+)
> 
> =======================================================================
> 

It causes problems with git-am as it tries to add it to the commit.
If you want to use diffstat format there, please do it the same format
as git-show --pretty=email somecommitid does, that way git-am knows
how to ignore it :)

> --- linux-omap/include/asm-arm/arch-omap/omap24xx.h	2007-05-25 15:52:27.000000000 -0500
> +++ val_3430_GIT/include/asm-arm/arch-omap/omap24xx.h	2007-06-07 18:52:49.000000000 -0500
> @@ -1,3 +1,28 @@
> +/*
> + * include/asm-arm/arch-omap/omap24xx.h
> + *
> + * This file contains the processor specific definitions
> + * of the TI OMAP24XX.
> + *
> + * Copyright (C) 2007 Texas Instruments.
> + * Copyright (C) 2007 Nokia Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + */
> +
>  #ifndef __ASM_ARCH_OMAP24XX_H
>  #define __ASM_ARCH_OMAP24XX_H

Pushing today.

Tony
