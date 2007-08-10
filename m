From: Tony Lindgren <tony@atomide.com>
Subject: Re: Why does it increase the dsor value in MMC?
Date: Fri, 10 Aug 2007 00:48:22 -0700
Message-ID: <20070810074821.GI8658@atomide.com>
References: <002701c7bc4e$b1c70670$e1ac580a@swcenter.sec.samsung.co.kr>
	<9C23CDD79DA20A479D4615857B2E2C47013BFAF2@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47013BFAF2@dlee13.ent.ti.com>
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
Cc: Tuukka.Tikkanen@elektrobit.com, linux-omap-open-source@linux.omap.com, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070701 20:05]:
> Hi,
> 
> >Then how about to append the following code?
> >
> >/* If the dsor is zero, we increase the dsor value to enable the clock */
> >if (dsor == 0)
> >	dsor++;
> >
> >It not only assigns the correct dsor values, but also enables the other
> >platform.
> >
> 
> In TI's code we do the following, we don't add the extra dsor increment. This works for 2420 / 2430 and 3430 processors for all different types of MMC/SD cards.
>        if (ios->clock) {
>                 /* Enable MMC_SD_CLK */
>                 dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
>                 if (dsor < 1)
>                         dsor = 1;
> 
>                 if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
>                         dsor++;
> 
>                 if (dsor > 250)
>                         dsor = 250;
>         }
> 
> As Tuukka suggested we might have to check the history and see if this line was mistakenly added. I was not able to browse history through muru.com / source.mvista.com looks like some server problem.

I'll remove the extra dsor++ line as suggested. Let's see
if anything breaks.

Tony
