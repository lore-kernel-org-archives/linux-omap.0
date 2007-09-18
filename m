From: Tony Lindgren <tony@atomide.com>
Subject: Re: Problem in omap_pm_idle()
Date: Tue, 18 Sep 2007 09:58:32 -0700
Message-ID: <20070918165832.GA2521@atomide.com>
References: <46EFDF0D.8000808@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46EFDF0D.8000808@celunite.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivek Kutal <vivek.kutal@celunite.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Vivek Kutal <vivek.kutal@celunite.com> [070918 07:22]:
> Hi ,
>       I was looking at omap_pm_idle() in omap1/pm.c , at the end there is a 
> call to omap_sram_suspend , shouldn't it be omap_sram_idle() ?
>       and if CONFIG_OMAP_MPU_TIMER is set it sets  use_idlect1 = 
> use_idlect1 & ~(1 << 9) ,  but it does not go into wait for interrupt.
>       Can anyone please explain this ?

Omaps can do sleep-while-idle, so it is correct. Doing omap_sram_idle()
would just keep it in wait for interrupt state.

Regards,

Tony
