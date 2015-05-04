From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] bus: omap_l3_noc: Fix master id address decoding for
 OMAP5
Date: Mon, 4 May 2015 09:31:14 -0700
Message-ID: <20150504163113.GP24469@atomide.com>
References: <1429898060-51944-1-git-send-email-s-anna@ti.com>
 <553A8C68.5080903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49021 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbEDQbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:31:16 -0400
Content-Disposition: inline
In-Reply-To: <553A8C68.5080903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [150424 11:34]:
> On 04/24/2015 12:54 PM, Suman Anna wrote:
> > The L3 Error handling on OMAP5 for the most part is very similar
> > to that of OMAP4, and had leveraged common data structures and
> > register layout definitions so far. Upon closer inspection, there
> > are a few minor differences causing an incorrect decoding and
> > reporting of the master NIU upon an error:
> > 
> >   1. The L3_TARG_STDERRLOG_MSTADDR.STDERRLOG_MSTADDR occupies
> >      11 bits on OMAP5 as against 8 bits on OMAP4, with the master
> >      NIU connID encoded in the 6 MSBs of the STDERRLOG_MSTADDR
> >      field.
> >   2. The CLK3 FlagMux component has 1 input source on OMAP4 and 3
> >      input sources on OMAP5. The common DEBUGSS source is at a
> >      different input on each SoC.
> > 
> > Fix the above issues by using a OMAP5-specific compatible property
> > and using SoC-specific data where there are differences.
> > 
> > Cc: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Suman Anna <s-anna@ti.com>
...
 
> If tony does not mind dts+driver patch, then except for the above comment:
> 
> Acked-by: Nishanth Menon <nm@ti.com>

Looks OK to me for a fix. In general we want to have the .dts
changes separated from the driver changes though.

Applying into omap-for-v4.1/fixes.

Regards,

Tony
