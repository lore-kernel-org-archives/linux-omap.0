From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2' undeclared
 here
Date: Mon, 10 Jan 2011 14:30:44 -0800
Message-ID: <20110110223044.GN4957@atomide.com>
References: <1294611373-1992-1-git-send-email-santosh.shilimkar@ti.com>
 <4D2B0B86.3010201@ti.com>
 <32cc9f4ba82187480f1e4d15d4e93dc0@mail.gmail.com>
 <alpine.DEB.2.00.1101101156220.5731@utopia.booyaka.com>
 <alpine.DEB.2.00.1101101158360.5731@utopia.booyaka.com>
 <20110110190718.GF4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12833 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab1AJWat (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 17:30:49 -0500
Content-Disposition: inline
In-Reply-To: <20110110190718.GF4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110110 11:06]:
> * Paul Walmsley <paul@pwsan.com> [110110 10:58]:
> > On Mon, 10 Jan 2011, Paul Walmsley wrote:
> > 
> > > Looks good to me.  Tony, do you want to merge this one as part of the -rc 
> > > series?  If so then it is:
> > > 
> > > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > (once Santosh reposts the updated fix, that is)
> 
> OK thanks will queue.

I've queued the following updated version.

Regards,

Tony

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 9 Jan 2011 22:16:13 +0000
Subject: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2' undeclared here

At latest mainline commit 0c21e3aaf6a,  omap2plus build is broken. This
patch is trivial fix for the missed usb clock node for CK_3430ES2PLUS
flag update.

 CHK     include/generated/compile.h
  CC      arch/arm/mach-omap2/clock3xxx_data.o
arch/arm/mach-omap2/clock3xxx_data.c:3289: error: 'CK_3430ES2' undeclared
here (not in a function)
make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
[tony@atomide.com: updated mask to include CK_36XX]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3286,7 +3286,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
