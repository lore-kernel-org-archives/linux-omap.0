From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH / RFC] Resubmitting : Basic OMAP2430 High speed I2C &
	Speed handling
Date: Thu, 26 Apr 2007 18:52:40 +0000
Message-ID: <20070426185239.GJ9764@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C47BC80EA@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47BC80EA@dlee13.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070424 00:52]:
> Resubmitting after incorporating review comments
> 
> This patch moves I2C speed parameter (from module) to platform data.
> Also added basic High Speed support based on I2C bus speed. 
> 
> This patch is tested for high speed I2C (with TWL4030 Keypad) and works as
> expected.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files:
>  drivers/i2c/busses/i2c-omap.c
>  arch/arm/mach-omap2/clock.h
>  arch/arm/mach-omap2/devices.c
>  arch/arm/plat-omap/devices.c 
>  arch/arm/mach-omap2/board-2430sdp.c
> 

Pushing today. I've split the driver into a separate patch.

Tony
