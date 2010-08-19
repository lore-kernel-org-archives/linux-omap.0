From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/5] OMAP2420: McSPI: Add mcspi hwmod
Date: Thu, 19 Aug 2010 19:03:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6722CF9@dbde02.ent.ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270CAEEB4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0HSNeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 09:34:13 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270CAEEB4@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "Nayak, Rajendra" <IMCEAEX-_O=TI_OU=EXCHANGE+20ADMINISTRATIVE+20GROUP+20+28FYDIBOHF23SPDLT+29_CN=RECIPIENTS_CN=X0016154@dlee86.itg.ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Hema,

> 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org
> >[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >Varadarajan, Charulatha
> >Sent: Friday, August 13, 2010 7:35 PM
> >To: linux-omap@vger.kernel.org
> >Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson,
> >Benoit; tony@atomide.com; grant.likely@secretlab.ca;
> >dbrownell@users.sourceforge.net;
> >spi-devel-general@lists.sourceforge.net; Nayak, Rajendra;
> >Basak, Partha; Varadarajan, Charulatha; Raja, Govindraj
> >Subject: [PATCH 1/5] OMAP2420: McSPI: Add mcspi hwmod
> >
> >This patch updates the omap2420 hwmod data with the
> >McSPI info.
> >
> >Signed-off-by: Charulatha V <charu@ti.com>
> >Signed-off-by: Partha Basak <p-basak2@ti.com>
> >Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> >---
> > arch/arm/mach-omap2/omap_hwmod_2420_data.c |  138
> >++++++++++++++++++++++++++++
> > 1 files changed, 138 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >index 3cc768e..7d1a0ff 100644
> >--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >@@ -15,6 +15,7 @@
> > #include <mach/irqs.h>
> > #include <plat/cpu.h>
> > #include <plat/dma.h>
> >+#include <plat/mcspi.h>
> >
> > #include "omap_hwmod_common_data.h"
> >
> >@@ -33,6 +34,8 @@ static struct omap_hwmod omap2420_mpu_hwmod;
> > static struct omap_hwmod omap2420_iva_hwmod;
> > static struct omap_hwmod omap2420_l3_main_hwmod;
> > static struct omap_hwmod omap2420_l4_core_hwmod;
> >+static struct omap_hwmod omap2420_mcspi1_hwmod;
> >+static struct omap_hwmod omap2420_mcspi2_hwmod;
> >
> > /* L3 -> L4_CORE interface */
> > static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
> >@@ -72,6 +75,42 @@ static struct omap_hwmod omap2420_l3_main_hwmod = {
> >
> > static struct omap_hwmod omap2420_l4_wkup_hwmod;
> >
> >+/* L4 CORE -> MCSPI1 interface */
> >+static struct omap_hwmod_addr_space omap2420_mcspi1_addr_space[] = {
> >+	{
> >+		.pa_start	= 0x48098000,
> >+		.pa_end		= 0x480980ff,
> >+		.flags		= ADDR_TYPE_RT,
> >+	},
> >+};
> 
> Align all of them to one tab..

If you apply the patch, you would see them aligned to one tab.
 
> 
> >+
> >+static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 = {
> >+	.master		= &omap2420_l4_core_hwmod,
> >+	.slave		= &omap2420_mcspi1_hwmod,
> >+	.clk		= "mcspi1_ick",
> >+	.addr		= omap2420_mcspi1_addr_space,
> >+	.addr_cnt	= ARRAY_SIZE(omap2420_mcspi1_addr_space),
> >+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> >+};
> >+
> >+/* L4 CORE -> MCSPI2 interface */
> >+static struct omap_hwmod_addr_space omap2420_mcspi2_addr_space[] = {
> >+	{
> >+		.pa_start	= 0x4809a000,
> >+		.pa_end		= 0x4809a0ff,
> >+		.flags		= ADDR_TYPE_RT,
> >+	},
> >+};
> >+
> 
> Ditto align to one tab

Ditto :)

> 
> >+static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 = {
> >+	.master		= &omap2420_l4_core_hwmod,
.
.
[snip]
.
.
