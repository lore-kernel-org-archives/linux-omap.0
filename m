From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 3/3] OMAP36xx PM: Updated C state latencies for OMAP3630
Date: Wed, 2 Mar 2011 22:47:04 +0530
Message-ID: <3621cbf4ab2de0ad80b3b87910b060a8@mail.gmail.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com><1297846874-18286-4-git-send-email-vishwanath.bs@ti.com>
 <871v2qikgf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59297 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753063Ab1CBRRN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 12:17:13 -0500
Received: by vws10 with SMTP id 10so123202vws.29
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 09:17:12 -0800 (PST)
In-Reply-To: <871v2qikgf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, March 02, 2011 3:15 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; patches@linaro.org
> Subject: Re: [PATCH 3/3] OMAP36xx PM: Updated C state latencies for
> OMAP3630
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > This patch has changes to update the C state latencies for OMAP3630
> and
> > disables the useless C-States, keeping only the optimized ones with
> their
> > corresponding measured latencies.
>
> I think "useless" vs. "optimized" here are not the right words, and
> doesn't summarize the problem being solved.
>
> If I understood Nicole and Vincent's summary it was that there is no
> significant power savings between some of the states, so they are not
> necessary.
Yes, also some of the C states were consuming more power than deeper C
state.

>
> Also, I believe Nicole & Vincent's research applies to both 34xx and
> 36xx.
I need to check. AFAIK, the experiments were done on OMAP3630 boards.
>
> > Only 4 C-states are kept instead of 7
> > C-States:
> > * C1 . MPU WFI clock gated + Core autogating
> > * C3 . MPU CSWR + Core inactive
> > * C5 . MPU CSWR + Core CSWR
> > * C7 . MPU OFF + Core OFF
> >
> > Thanks to Nicole Chaloub<n-chalhoub@ti.com> and Vincent Bour <v-
> bour@ti.com>
> > for their investigation.
> >
> > Tested on ZOOM3 board using latest pm branch.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-3630sdp.c |   19
> +++++++++++++++++++
> >  arch/arm/mach-omap2/board-zoom.c    |   19
> +++++++++++++++++++
>
> Why are these added as board-specific changes?
>
> If these are to be the default 3630 CPUidle states, add a default 36xx
> cpuidle_params_table along side the 34xx one and have CPUidle pick the
> right one at runtime.
Yes, I can do that.

Vishwa
>
> Kevin
>
> >  2 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> omap2/board-3630sdp.c
> > index 6264564..8d05fc9
> > --- a/arch/arm/mach-omap2/board-3630sdp.c
> > +++ b/arch/arm/mach-omap2/board-3630sdp.c
> > @@ -25,6 +25,24 @@
> >  #include "board-flash.h"
> >  #include "mux.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> > +#include "pm.h"
> > +
> > +static struct cpuidle_params omap36xx_cpuidle_params_table[] = {
> > +	/* C1 */
> > +	{1, 74, 78, 152},
> > +	/* C2 */
> > +	{0, 165, 90, 255},
> > +	/* C3 */
> > +	{1, 163, 180, 345},
> > +	/* C4 */
> > +	{0, 2852, 605, 3457},
> > +	/* C5 */
> > +	{1, 800, 366, 2120},
> > +	/* C6 */
> > +	{0, 4080, 801, 4881},
> > +	/* C7 */
> > +	{1, 4300, 8794, 159000},
> > +};
> >
> >  #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
> >
> > @@ -212,6 +230,7 @@ static void __init omap_sdp_init(void)
> >  	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
> >  	enable_board_wakeup_source();
> >  	usb_ehci_init(&ehci_pdata);
> > +	omap3_pm_init_cpuidle(omap36xx_cpuidle_params_table);
> >  }
> >
> >  MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
> > diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-
> omap2/board-zoom.c
> > index e26754c..6bd364a
> > --- a/arch/arm/mach-omap2/board-zoom.c
> > +++ b/arch/arm/mach-omap2/board-zoom.c
> > @@ -30,6 +30,24 @@
> >  #include "mux.h"
> >  #include "sdram-micron-mt46h32m32lf-6.h"
> >  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> > +#include "pm.h"
> > +
> > +static struct cpuidle_params omap36xx_cpuidle_params_table[] = {
> > +	/* C1 */
> > +	{1, 74, 78, 152},
> > +	/* C2 */
> > +	{0, 165, 90, 255},
> > +	/* C3 */
> > +	{1, 163, 180, 345},
> > +	/* C4 */
> > +	{0, 2852, 605, 3457},
> > +	/* C5 */
> > +	{1, 800, 366, 2120},
> > +	/* C6 */
> > +	{0, 4080, 801, 4881},
> > +	/* C7 */
> > +	{1, 4300, 8794, 159000},
> > +};
> >
> >  #define ZOOM3_EHCI_RESET_GPIO		64
> >
> > @@ -126,6 +144,7 @@ static void __init omap_zoom_init(void)
> >  		usb_ehci_init(&ehci_pdata);
> >  	}
> >
> > +	omap3_pm_init_cpuidle(omap36xx_cpuidle_params_table);
> >  	board_nand_init(zoom_nand_partitions,
> >  			ARRAY_SIZE(zoom_nand_partitions),
> ZOOM_NAND_CS);
> >  	zoom_debugboard_init();
