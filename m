From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v2] arm: omap: Fix errors and warnings when building for
	one board
Date: Fri, 28 Oct 2011 14:10:50 +0000
Message-ID: <E28AAFD00EFAA646AE3DF9B89CD24A8901CD80@DBDE01.ent.ti.com>
References: <1318522450-18425-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318522450-18425-1-git-send-email-premi@ti.com>
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
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Thursday, October 13, 2011 9:44 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Premi, Sanjeev
> Subject: [PATCH v2] arm: omap: Fix errors and warnings when 
> building for one board
> 
> When customizing omap2plus_defconfig to build for only
> one board (omap3evm), I came across these warnings and
> errors (filenames truncated):
> 
> arch/arm/mach-omap2/board-generic.c:76:20: warning: 
> 'omap4_init' defined but not used
> arch/arm/mach-omap2/built-in.o: In function `omap2420_init_early':
> arch/arm/mach-omap2/io.c:364: undefined reference to 
> `omap2_set_globals_242x'
> arch/arm/mach-omap2/io.c:366: undefined reference to 
> `omap2xxx_voltagedomains_init'
> arch/arm/mach-omap2/io.c:367: undefined reference to 
> `omap242x_powerdomains_init'
> arch/arm/mach-omap2/io.c:368: undefined reference to 
> `omap242x_clockdomains_init'
> arch/arm/mach-omap2/io.c:369: undefined reference to 
> `omap2420_hwmod_init'
> arch/arm/mach-omap2/built-in.o: In function `omap2430_init_early':
> arch/arm/mach-omap2/io.c:376: undefined reference to 
> `omap2_set_globals_243x'
> arch/arm/mach-omap2/io.c:378: undefined reference to 
> `omap2xxx_voltagedomains_init'
> arch/arm/mach-omap2/io.c:379: undefined reference to 
> `omap243x_powerdomains_init'
> arch/arm/mach-omap2/io.c:380: undefined reference to 
> `omap243x_clockdomains_init'
> arch/arm/mach-omap2/io.c:381: undefined reference to 
> `omap2430_hwmod_init'
> arch/arm/mach-omap2/built-in.o: In function `omap4430_init_early':
> arch/arm/mach-omap2/io.c:436: undefined reference to 
> `omap2_set_globals_443x'
> arch/arm/mach-omap2/io.c:438: undefined reference to 
> `omap44xx_voltagedomains_init'
> arch/arm/mach-omap2/io.c:439: undefined reference to 
> `omap44xx_powerdomains_init'
> arch/arm/mach-omap2/io.c:440: undefined reference to 
> `omap44xx_clockdomains_init'
> arch/arm/mach-omap2/io.c:441: undefined reference to 
> `omap44xx_hwmod_init'
> 
> This patch fixes them.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> 
>  Changes since v1:
>     - #if defined() to #ifdef
>     - Moved an #ifdef to take care of additional warning
>       related to sdp4430_twldata. Had missed squashing the
>       patch before sending v1.
> 
>  Adding ifdefs makes the code bit ugly and is prone to propagate
>  further. Not sure if DT will help here, but this patch would be
>  useful for people trying to build for individual boards.
> 
>  Compile tested for OMAP3EVM.
> 
>  Applies to linux-omap/master at:
>    fb4df0f : ARM: OMAP1: Fix warnings about enabling 32 KiHz timer
> 
> 
>  arch/arm/mach-omap2/board-generic.c |    8 ++++++++
>  arch/arm/mach-omap2/io.c            |    6 ++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 

Tony,

Just wanted to check the status of this patch.

~sanjeev
