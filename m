From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/12] OMAP3430 support in mach-omap2 folder
Date: Tue, 12 Jun 2007 11:23:42 -0700
Message-ID: <20070612182341.GA29514@atomide.com>
References: <9C23CDD79DA20A479D4615857B2E2C4701063213@dlee13.ent.ti.com>
	<5d5443650705312321m4b381090yec02078b45d0540c@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C470810E4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470810E4@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [070601 05:39]:
> Hi Trilok,
>  
> > We have now common debug card interface. Check
> > arch/arm/plat-omap/debug-devices.c and do similar calls like
> > board-h4.c {debug_card_init}.
> 
> For now, I would like to continue with this. I will incorporate this comment as a separate clean up patch.

Can you please fix what Trilok suggested? Remember, we want to use
the same patch for sending it upstream eventually.

Regards,

Tony
