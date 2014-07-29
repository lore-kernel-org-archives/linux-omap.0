From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 00/10] OMAP: GPMC: NAND: Introduce GPMC APIs for OMAP
 NAND
Date: Tue, 29 Jul 2014 03:39:00 -0700
Message-ID: <20140729103900.GL29045@atomide.com>
References: <1404909450-11970-1-git-send-email-rogerq@ti.com>
 <20140711065211.GK28884@atomide.com>
 <20980858CB6D3A4BAE95CA194937D5E73EB01DD5@DBDE04.ent.ti.com>
 <53BFA038.5010903@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EB01EC6@DBDE04.ent.ti.com>
 <53BFBB1F.9000901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53BFBB1F.9000901@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "javier@dowhile0.org" <javier@dowhile0.org>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "jg1.han@samsung.com" <jg1.han@samsung.com>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140711 03:25]:
> On 07/11/2014 12:42 PM, Gupta, Pekon wrote:
> >
> > Therefore, I suggest you to move following code from NAND driver to
> > GPMC driver, nothing other than. And this exported function does not
> > need any NAND framework information, except number_of_sectors.
> 
> Well I you have still not pointed out what is the benefit of that approach or what are the problems with the approach I am suggesting.
> 
> I am suggesting that the API just return the ECC/BCH result registers as it is.
> You are suggesting that the API do the calculations and return the NAND ready ECC buffer.
> 
> To do the calculations it needs to know about the ECC scheme which is NAND controller specific and this is unnecessary in the GPMC driver.
> 
> Tony, what is your opinion?

As long as the GPMC registers are exposed to drivers in a controlled
way and we have only one driver using the ECC registers, I don't care.

Regards,

Tony
