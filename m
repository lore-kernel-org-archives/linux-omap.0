From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 28/30] ARM: omap: select CPU_FREQ_TABLE where needed
Date: Mon, 03 Oct 2011 11:15:17 +0200
Message-ID: <5173921.eT2vCfT35d@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-29-git-send-email-arnd@arndb.de>
	<4E894A95.5030107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E894A95.5030107@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 03 October 2011 11:09:33 Santosh Shilimkar wrote:
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index bb8f4a6..f7ef9f4 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -217,6 +217,11 @@ config OMAP_PM_NOOP
> >  
> >  endchoice
> >  
> > +config OMAP_CPU_FREQ
> > +     def_bool "y"
> > +     depends on CPU_FREQ
> > +     select CPU_FREQ_TABLE
> > +
> >  endmenu
> With CPUFREQ series from Kevin [1], I don't think we need this any-more.

I guess if it's needed, it should at least be moved to the new cpufreq
location.

> More so, I didn't find OMAP_CPU_FREQ is being used anywhere on mainline.

Yes, OMAP_CPU_FREQ is a symbol that is intentionally unused, with the
only purpose of selecting CPU_FREQ_TABLE if any omap platform together
with CPU_FREQ is enabled.

Let's drop this patch for now, if it is still needed as I think, I can
do a patch during the 3.2 cycle for the right location.

	Arnd
