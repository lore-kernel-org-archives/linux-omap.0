From: Tony Lindgren <tony@atomide.com>
Subject: Re: What is the correct approach for common board devices...?
Date: Tue, 12 Jun 2007 23:02:57 -0700
Message-ID: <20070613060256.GB4030@atomide.com>
References: <20070612181652.GS28834@atomide.com>
	<9C23CDD79DA20A479D4615857B2E2C47011E5951@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47011E5951@dlee13.ent.ti.com>
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

* Syed Mohammed, Khasim <x0khasim@ti.com> [070612 21:01]:
> Hi Tony,
> 
> There are some devices like TS, Keypad, I2C, Flash, etc that are almost common between 2430 and 3430 SDPs. 
> 
> Today in tree we have files like board-2430sdp-flash.c which can be reused for 3430 too.
> 
> The board-2430sdp.c has Keymap that holds good for 3430 too.
> 
> Can you please suggest the correct way to organize these kind of devices in mach-omap2 directory?

How about creating something like arch/arm/mach-omap2/sdp-common.c
for them?

Tony
