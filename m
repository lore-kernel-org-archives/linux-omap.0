From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] OMAP3: PM: export chip IDCODE, Production ID and
 Die ID
Date: Tue, 27 Apr 2010 07:51:21 -0700
Message-ID: <20100427145121.GY7225@atomide.com>
References: <1272270293-18568-1-git-send-email-eduardo.valentin@nokia.com>
 <1272270293-18568-5-git-send-email-eduardo.valentin@nokia.com>
 <20100426182811.GI7225@atomide.com>
 <20100427101321.GC332@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56569 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0D0OvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 10:51:19 -0400
Content-Disposition: inline
In-Reply-To: <20100427101321.GC332@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "De-Schrijver Peter (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>

* Eduardo Valentin <eduardo.valentin@nokia.com> [100427 03:08]:
> Hello Tony,
> 
> On Mon, Apr 26, 2010 at 08:28:12PM +0200, ext Tony Lindgren wrote:
> > * Eduardo Valentin <eduardo.valentin@nokia.com> [100426 01:20]:
> > > +
> > > +	/* Append OMAP3 IDCODE, Production ID and Die ID to system_soc_info */
> > > +	sz = strlen(system_soc_info);
> > > +	snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
> > > +			"\n\tIDCODE\t: %08x\n\tPr. ID\t: %08x %08x %08x %08x\n"
> > > +			"\tDie ID\t: %08x %08x %08x %08x\n",
> > > +			read_tap_reg(OMAP_TAP_IDCODE),
> > > +			read_tap_reg(OMAP_TAP_PROD_ID_0),
> > > +			read_tap_reg(OMAP_TAP_PROD_ID_1),
> > > +			read_tap_reg(OMAP_TAP_PROD_ID_2),
> > > +			read_tap_reg(OMAP_TAP_PROD_ID_3),
> > > +			read_tap_reg(OMAP_TAP_DIE_ID_0),
> > > +			read_tap_reg(OMAP_TAP_DIE_ID_1),
> > > +			read_tap_reg(OMAP_TAP_DIE_ID_2),
> > > +			read_tap_reg(OMAP_TAP_DIE_ID_3));
> > >  }
> > >  
> > >  /*
> > 
> > We should not expose the Die ID info unless specifically compiled in
> > with some Kconfig option. Please search for "pentium serial number privacy"
> > or similar.
> 
> Yeah, I remember now that you actually have already asked to do it. I'll
> repost this series again with this change. It will couple with the same
> protection mechanism there is for x86 pn. it is not a compilation config,
> but a kernel parameter:
> 
> 
> static int __init x86_serial_nr_setup(char *s)
> {
> 	disable_x86_serial_nr = 0;
> 	return 1;
> }
> __setup("serialnumber", x86_serial_nr_setup);

Sounds good to me.

Tony
