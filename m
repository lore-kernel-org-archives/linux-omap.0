From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: omap_elm: print interrupt resource using %pr
Date: Mon, 14 Dec 2015 10:31:12 -0800
Message-ID: <20151214183112.GB10460@google.com>
References: <2101351.RbJOfbsbGX@wuerfel>
 <20151212011056.GA144873@google.com>
 <1472979.NmboBT3Vms@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472979.NmboBT3Vms@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Dec 12, 2015 at 03:41:31PM +0100, Arnd Bergmann wrote:
> On Friday 11 December 2015 17:10:56 Brian Norris wrote:
> > drivers/mtd/nand/omap_elm.c:417 elm_probe() error: '%pr' expects argument of type struct resource *, but argument 3 has type 'struct resource**' [smatch]
> 
> Ah, good catch. Do you want to fix it up yourself, or should I send a new version?

Can you send a new one?
