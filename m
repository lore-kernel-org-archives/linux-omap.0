From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 10/13 v3] OMAP: GPIO: Add gpio dev_attr and correct clks
 in OMAP4 hwmod struct
Date: Wed, 16 Jun 2010 12:24:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5B4B62A@dbde02.ent.ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
 <1276614348-5201-2-git-send-email-charu@ti.com>
 <1276614348-5201-3-git-send-email-charu@ti.com>
 <1276614348-5201-4-git-send-email-charu@ti.com>
 <1276614348-5201-5-git-send-email-charu@ti.com>
 <1276614348-5201-6-git-send-email-charu@ti.com>
 <1276614348-5201-7-git-send-email-charu@ti.com>
 <1276614348-5201-8-git-send-email-charu@ti.com>
 <1276614348-5201-9-git-send-email-charu@ti.com>
 <1276614348-5201-10-git-send-email-charu@ti.com>
 <1276614348-5201-11-git-send-email-charu@ti.com> <4C17ACE8.6000805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab0FPGyk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 02:54:40 -0400
In-Reply-To: <4C17ACE8.6000805@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "david-b@pacbell.net" <david-b@pacbell.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Tuesday, June 15, 2010 10:10 PM
> To: Varadarajan, Charulatha
> Cc: david-b@pacbell.net; broonie@opensource.wolfsonmicro.com; akpm@linux-
> foundation.org; linux-omap@vger.kernel.org; paul@pwsan.com; Nayak, Rajendra;
> khilman@deeprootsystems.com; tony@atomide.com
> Subject: Re: [PATCH 10/13 v3] OMAP: GPIO: Add gpio dev_attr and correct clks in
> OMAP4 hwmod struct
> 
> Hi Charu,
> 
> On 6/15/2010 5:05 PM, Varadarajan, Charulatha wrote:
> > From: Charulatha V<charu@ti.com>
> >
> > This patch adds gpio_dev_attr to OMAP4 gpio hwmod structure. This patch
> > also corrects the gpio .main_clk and .clk fields in gpio hwmod structures.
> >
> > Signed-off-by: Charulatha V<charu@ti.com>
> > ---
> >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   37 +++++++++++++++++++---------
> >   1 files changed, 25 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_44xx_data.c
> > index 20f5f8c..b4c0878 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -22,6 +22,7 @@
> >
> >   #include<plat/omap_hwmod.h>
> >   #include<plat/cpu.h>
> > +#include<plat/gpio.h>
> >
> >   #include "omap_hwmod_common_data.h"
> >
> > @@ -1272,6 +1273,12 @@ static struct omap_hwmod omap44xx_fdif_hwmod = {
> >    * general purpose io module
> >    */
> >
> > +static struct omap_gpio_dev_attr gpio_dev_attr = {
> > +	.gpio_bank_count = 6,
> 
> Why do you need that information?
> The point is that this struct is in theory a per instance data not a
> global one. If needed, you should be able to get that from the number of
> iteration done during the init of hwmods.

Even though it is possible to get it through number of iterations, more efficient approach would be to keep this information here. My point is that this information can be auto-generated and hence it is better to keep it in hwmod database itself. 

FYI, in a meeting we recently had with Kevin, we discussed about "global data" information getting duplicated for each instance and it was agreed that it is okay to have pointers duplicated for each instance.

> 
> > +	.gpio_bank_bits = 32,
> > +	.dbck_flag = true,
> > +};
> 
> Since this structure is the same than OMAP3, you should maybe consider
> sharing it.

They are in different _data.c files. I feel that it will be good if they are kept decoupled as we need not have to mix up different SoC data. Here it's only a coincidence that OMAP3 and OMAP4 have same data.

> 
> > +
> >   static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
> >   	.rev_offs	= 0x0000,
> >   	.sysc_offs	= 0x0010,
> > @@ -1305,7 +1312,7 @@ static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[]
> = {
> >   static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
> >   	.master		=&omap44xx_l4_wkup_hwmod,
> >   	.slave		=&omap44xx_gpio1_hwmod,
> > -	.clk		= "l4_wkup_clk_mux_ck",
> > +	.clk		= "gpio1_ick",
> >   	.addr		= omap44xx_gpio1_addrs,
> >   	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
> >   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> > @@ -1325,7 +1332,7 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
> >   	.class		=&omap44xx_gpio_hwmod_class,
> >   	.mpu_irqs	= omap44xx_gpio1_irqs,
> >   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
> > -	.main_clk	= "gpio1_ick",
> > +	.main_clk	= NULL,
> 
> Removing the line is enough. It will be null by default.

Agreed.

> I'm still not 100% sure that this is the good way to control the GPIO
> module mode, but at least this is cleaner than the previous clock mapping.
> 
> Benoit

