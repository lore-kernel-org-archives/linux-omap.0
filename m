From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: X-loader / U-Boot query
Date: Thu, 8 Oct 2009 21:47:04 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C0037D15A4E5@dbde02.ent.ti.com>
References: <4ACDE1DF.1010303@mlbassoc.com>
 <4ACDFB52.2080100@astc-design.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A6FC720@dlee02.ent.ti.com>
 <4ACE0271.2060402@mlbassoc.com>
 <0680EC522D0CC943BC586913CF3768C0037D15A4DC@dbde02.ent.ti.com>
 <4ACE0ECA.9050703@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48147 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbZJHQRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 12:17:51 -0400
In-Reply-To: <4ACE0ECA.9050703@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Thursday, October 08, 2009 11:10 AM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: X-loader / U-Boot query
> 
> On 10/08/2009 09:54 AM, Syed Mohammed, Khasim wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Gary Thomas
> >> Sent: Thursday, October 08, 2009 10:17 AM
> >> To: Menon, Nishanth
> >> Cc: Adam Machalek; linux-omap@vger.kernel.org
> >> Subject: Re: X-loader / U-Boot query
> >>
> >> On 10/08/2009 09:14 AM, Menon, Nishanth wrote:
> >>>> -----Original Message-----
> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>>> owner@vger.kernel.org] On Behalf Of Adam Machalek
> >>>> Sent: Thursday, October 08, 2009 9:47 AM
> >>>> To: Gary Thomas
> >>>> Cc: linux-omap@vger.kernel.org
> >>>> Subject: Re: X-loader / U-Boot query
> >>>>
> >>>> The problem is located in u-boot/cpu/arm_cortexa8/omap3/mem.c
> >>>>
> >>>> Function do_sdrc_init()
> >>>>
> >>>> There is an assumption that the RAM size on each CS is maximum of 128M.
> >>>> See this line:
> >>>>
> >>>> writel(RASWIDTH_13BITS | CASWIDTH_10BITS | ADDRMUXLEGACY |
> >>>>         RAMSIZE_128 | BANKALLOCATION | B32NOT16 | B32NOT16 |
> >>>>         DEEPPD | DDR_SDRAM,&sdrc_base->cs[cs].mcfg);
> >>>>
> >>> This discussion should really be taken to u-boot mailing list. Yes, any
> >> additional patches would be good to have..
> >>
> >> Where is that list??  I did ask this question in the original
> >> email...
> >>
> > Sorry, I have not seen all the thread. Are you using x-loader? Then your
> DDR configuration happens in x-loader and not in u-boot as it skips it. In
> that case your question should be on x-loader and this is the right list to
> discuss the same.
> >
> > If you use u-boot for RAM configuration then you should be on NOR flash.
> 
> I'm definitely using x-loader (followed by U-Boot).
> 
> Where is this set in X-loader?  Is there any guidance for
> using the larger DRAM devices?
> 

I have tried upto 256MB on beagleboard, 
http://gitorious.org/x-load-omap3/mainline/commit/c0bc8cc7005abad65be07b0c64901bcfaff71971

See the DDR configuration.

I think others have tried for 512MB on other OMAP3 devices I don't know about the source location for the same.

Regards,
Khasim
