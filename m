From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Date: Fri, 17 Nov 2006 16:09:51 +0000
Message-ID: <20061117160951.GD28514@flint.arm.linux.org.uk>
References: <455DB297.1040009@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933690AbWKQQJ7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <455DB297.1040009@indt.org.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>, ext David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 17, 2006 at 09:01:11AM -0400, Anderson Briglia wrote:
>  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block 
>  sizes */
> +#define MMC_CAP_LOCK_UNLOCK	(1 << 3)	/* Host password support 
> capability */

What's the point of this capability.  If the host can do BYTEBLOCK transfers
it can send the password commands.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
