From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: X-loader / U-Boot query
Date: Thu, 8 Oct 2009 10:19:57 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A6FC736@dlee02.ent.ti.com>
References: <4ACDE1DF.1010303@mlbassoc.com>
 <4ACDFB52.2080100@astc-design.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A6FC720@dlee02.ent.ti.com>
 <4ACE0271.2060402@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZJHPUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 11:20:38 -0400
In-Reply-To: <4ACE0271.2060402@mlbassoc.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Adam Machalek <adam.machalek@astc-design.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Gary Thomas [mailto:gary@mlbassoc.com]
> Sent: Thursday, October 08, 2009 10:17 AM
> To: Menon, Nishanth
> Cc: Adam Machalek; linux-omap@vger.kernel.org
> Subject: Re: X-loader / U-Boot query
> 
> On 10/08/2009 09:14 AM, Menon, Nishanth wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Adam Machalek
> >> Sent: Thursday, October 08, 2009 9:47 AM
> >> To: Gary Thomas
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: X-loader / U-Boot query
> >>
> >> The problem is located in u-boot/cpu/arm_cortexa8/omap3/mem.c
> >>
> >> Function do_sdrc_init()
> >>
> >> There is an assumption that the RAM size on each CS is maximum of 128M.
> >> See this line:
> >>
> >> writel(RASWIDTH_13BITS | CASWIDTH_10BITS | ADDRMUXLEGACY |
> >>        RAMSIZE_128 | BANKALLOCATION | B32NOT16 | B32NOT16 |
> >>        DEEPPD | DDR_SDRAM,&sdrc_base->cs[cs].mcfg);
> >>
> > This discussion should really be taken to u-boot mailing list. Yes, any
> additional patches would be good to have..
> 
> Where is that list??  I did ask this question in the original
> email...
Please see [1] and the specific list [2] and also see [3]
Regards,
Nishanth Menon
Ref:
[1] http://www.google.com/search?sourceid=navclient&ie=UTF-8&rlz=1T4GGLL_enUS306US306&q=u-boot+mailing+list
[2] http://lists.denx.de/mailman/listinfo/u-boot
[3] http://www.denx.de/wiki/U-Boot 

