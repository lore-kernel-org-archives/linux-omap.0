From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Tue, 8 Jan 2013 13:38:53 -0700
Message-ID: <20130108203853.GB1876@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m1plsmtpa01-04.prod.mesa1.secureserver.net ([64.202.165.6]:42783
	"EHLO m1plsmtpa01-04.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab3AHUiy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 15:38:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
> Hi Mark,

Hi Paul.

> On Fri, 21 Dec 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > [This series supersedes the hwmod related patches sent in the
> >  "crypto: omap-sham updates" and "crypto: omap-aes updates"
> >  series a few weeks ago.]
> > 
> > This series adds hwmod support for the OMAP SHAM and AES
> > modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
> > adds device tree info for those modules.
> 
> Thanks for working on this, this will get us much closer to being able to 
> convert the hwmod code into an OMAP bus.  I haven't looked closely at 
> these patches yet, but a few comments/questions:

> - The patch series causes AM3517/3505 to crash.  I'd guess this is due to 
> the SHAM/AES modules being initialized on those chips, but they probably 
> don't exist there.  Can you change the initialization for those on OMAP3 
> to only take place on OMAP34xx/36xx GP?  I guess you'd need to create new 
> lists for those in the hwmod init.

All am35xx GPs have the SHAM and AES modules except some very old ones.
I've been told that there should be very few of the "old" ones around
(I don't know how to differentiate them).  We're likely safe since the
SHAM & AES modules are not enabled in omap2plus_defconfig so nobody
should be enabling them on an am35xx unless they know that they have
the modules.  Do you agree?

The issue that you're likely running into is that 'CK_AM35XX' needs to be
added for aes2_ick & sha12_ick in cclock3xxx_data.c.   The following
patch should fix it (applies to my submitted/crypto/hwmod branch):

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 582b055..aa5bdf6 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3332,10 +3332,10 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
-	CLK("omap-aes",	"ick",		&aes2_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_34XX | CK_36XX),
-	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_34XX | CK_36XX),
+	CLK("omap-aes",	"ick",		&aes2_ick,	CK_34XX | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"aes2_ick",	&aes2_ick,	CK_34XX | CK_AM35XX | CK_36XX),
+	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_34XX | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
 	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),


Please let me know if this patch works for you and, if it does, I'll respin
my patches to add those changes.

Thanks,

Mark
--
