From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
Date: Wed, 29 Sep 2010 18:44:03 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD02B1E@dbde02.ent.ti.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
	<877hi5740v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <877hi5740v.fsf@deeprootsystems.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak,
	Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson,
	Benoit" <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, September 29, 2010 6:36 AM
> To: Varadarajan, Charulatha
> Cc: tony@atomide.com; wim@iguana.be; linux-omap@vger.kernel.org; linux-
> watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> paul@pwsan.com; Cousson, Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH v8 0/6] OMAP: WDT: Implement WDT in hwmod way
> 
> Hi Charu,
> 
> "Varadarajan, Charulatha" <charu@ti.com> writes:
> 
> > Series of patches to port watchdog module to use hwmod APIs
> > for OMAP2PLUS chips and use runtime APIs for all OMAP chips.
> > For this hwmod database for OMAP2PLUS watchdog instances are
> > populated and implements watchdog module to use PM runtime APIs.
> >
> > This patch series is generated on "origin/pm-core" which
> > has Kevin's pm-next series, the runtime PM core patch series,
> > and a collection of hwmod fixes that Paul/Benoit have lined up
> > for 2.6.37.
> >
> > Tested on OMAP2430, OMAP4430 (ES1.0 & ES2.0), OMAP3430 SDP boards
> > and zoom3 board. Also verified that this patch series does not
> > break the OMAP1 build.
> 
> I found a little snag with this series.  Try testing with
> omap2plus_defconfig and changing CONFIG_OMAP_WATCHDOG=n.
> 
> If CONFIG_OMAP_WATCHDOG is not enabled in the kernel config, the system
> will reboot soon after bootup. 

Thanks for finding this issue.

After watchdog module reset, the WDTs are enabled. The default time
for a system reset after a watchdog module reset is ~10s as per the
default value of the WDT registers. Hence the above problem is observed.

If CONFIG_OMAP_WATCHDOG is defined, wdt's probe is called within this
10s time and watchdog_disable is called during probe. Hence we are not
finding this issue if CONFIG_OMAP_WATCHDOG is defined.

Ideally, because of the above, watchdog should be with
HWMOD_INIT_NO_RESET flag.

If agreed, I would send the below patch (extended to other OMAPs)
on top of my watchdog timer hwmod series with proper change log.

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-
omap2/omap_hwmod_3xxx_data.c
index 5bfe9c9..c567b24 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -260,6 +260,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
        .slaves         = omap3xxx_wd_timer2_slaves,
        .slaves_cnt     = ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
        .omap_chip      = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+       .flags          = HWMOD_INIT_NO_RESET,
 };

-V Charulatha

<<snip>>
