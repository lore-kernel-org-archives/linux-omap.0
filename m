From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 4/4] OMAP3: PM: export chip IDCODE, Production ID and
 Die ID
Date: Tue, 27 Apr 2010 13:13:21 +0300
Message-ID: <20100427101321.GC332@besouro.research.nokia.com>
References: <1272270293-18568-1-git-send-email-eduardo.valentin@nokia.com>
 <1272270293-18568-5-git-send-email-eduardo.valentin@nokia.com>
 <20100426182811.GI7225@atomide.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44450 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0D0KNb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 06:13:31 -0400
Content-Disposition: inline
In-Reply-To: <20100426182811.GI7225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

Hello Tony,

On Mon, Apr 26, 2010 at 08:28:12PM +0200, ext Tony Lindgren wrote:
> * Eduardo Valentin <eduardo.valentin@nokia.com> [100426 01:20]:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace
> > via /proc/cpuinfo using the system_soc_info.
> > 
> > This can be used to track down silicon specific issues. The info is
> > exported via /proc/cpuinfo because then it can be possible to include this
> > in corematic dumps.
> > 
> > This is based on Peter De Schrijver patch, which export same info via sysfs.
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  arch/arm/mach-omap2/id.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 75e36a5..887787d 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -76,6 +76,10 @@ EXPORT_SYMBOL(omap_type);
> >  /*----------------------------------------------------------------------------*/
> >  
> >  #define OMAP_TAP_IDCODE		0x0204
> > +#define OMAP_TAP_PROD_ID_0      0x0208
> > +#define OMAP_TAP_PROD_ID_1      0x020c
> > +#define OMAP_TAP_PROD_ID_2      0x0210
> > +#define OMAP_TAP_PROD_ID_3      0x0214
> >  #define OMAP_TAP_DIE_ID_0	0x0218
> >  #define OMAP_TAP_DIE_ID_1	0x021C
> >  #define OMAP_TAP_DIE_ID_2	0x0220
> > @@ -306,6 +310,7 @@ void __init omap4_check_revision(void)
> >  
> >  void __init omap3_cpuinfo(void)
> >  {
> > +	int sz;
> >  	u8 rev = GET_OMAP_REVISION();
> >  	char cpu_name[16], cpu_rev[16];
> >  
> > @@ -375,6 +380,21 @@ void __init omap3_cpuinfo(void)
> >  	OMAP3_SHOW_FEATURE(192mhz_clk);
> >  
> >  	printk(")\n");
> > +
> > +	/* Append OMAP3 IDCODE, Production ID and Die ID to system_soc_info */
> > +	sz = strlen(system_soc_info);
> > +	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
> > +			"\n\tIDCODE\t: %08x\n\tPr. ID\t: %08x %08x %08x %08x\n"
> > +			"\tDie ID\t: %08x %08x %08x %08x\n",
> > +			read_tap_reg(OMAP_TAP_IDCODE),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_0),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_1),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_2),
> > +			read_tap_reg(OMAP_TAP_PROD_ID_3),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_0),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_1),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_2),
> > +			read_tap_reg(OMAP_TAP_DIE_ID_3));
> >  }
> >  
> >  /*
> 
> We should not expose the Die ID info unless specifically compiled in
> with some Kconfig option. Please search for "pentium serial number privacy"
> or similar.

Yeah, I remember now that you actually have already asked to do it. I'll
repost this series again with this change. It will couple with the same
protection mechanism there is for x86 pn. it is not a compilation config,
but a kernel parameter:


static int __init x86_serial_nr_setup(char *s)
{
	disable_x86_serial_nr = 0;
	return 1;
}
__setup("serialnumber", x86_serial_nr_setup);


> 
> Also, this whole series should be discussed on linux-arm-kernel.

Yeah, will post v2 there as well,

> 
> Tony
