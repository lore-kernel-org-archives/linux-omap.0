From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
Date: Mon, 9 Aug 2010 18:05:50 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6553084@dbde02.ent.ti.com>
References: <1281097873-24094-1-git-send-email-charu@ti.com>
 <4C5C0196.3040106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50038 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0HIMf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 08:35:57 -0400
In-Reply-To: <4C5C0196.3040106@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Friday, August 06, 2010 6:06 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; 
> khilman@deeprootsystems.com; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH] OMAP4: HWMOD: Do omap_hwmod_late_init for OMAP4
> 
> Hi Charu,
> 
> On 8/6/2010 2:31 PM, Varadarajan, Charulatha wrote:
> > This patch includes "cpu_is" check for omap44xx cpu inorder to do
> > omap_hwmod_late_init() without which hwmods initialization does not
> > happen for omap4.
> >
> > Signed-off-by: Charulatha V<charu@ti.com>
> > Signed-off-by: Basak, Partha<p-basak2@ti.com>
> > ---
> >   arch/arm/mach-omap2/io.c |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> > index b89e678..9b15f46 100644
> > --- a/arch/arm/mach-omap2/io.c
> > +++ b/arch/arm/mach-omap2/io.c
> > @@ -345,7 +345,7 @@ void __init omap2_init_common_hw(struct 
> omap_sdrc_params *sdrc_cs0,
> >   #ifndef CONFIG_PM_RUNTIME
> >   	skip_setup_idle = 1;
> >   #endif
> > -	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
> > +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
> >   		omap_hwmod_late_init(skip_setup_idle);
> >
> >   	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> 
> This is already done in this patch:
> [PATCH v3 1/7] OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
> https://patchwork.kernel.org/patch/117347/

Okay. I found omap_hwmod_late_init() call missing for OMAP4 in
origin/pm-wip/hwmods-omap4 and sent this patch without noticing your
above mentioned patch. Please ignore this patch.

> 
> Benoit
> 