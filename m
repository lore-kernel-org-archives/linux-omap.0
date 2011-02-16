From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/6] trivial compile warning fixes
Date: Wed, 16 Feb 2011 21:48:10 +0200
Message-ID: <20110216194810.GB2451@legolas.emea.dhcp.ti.com>
References: <1297774156-23312-1-git-send-email-balbi@ti.com>
 <20110216173033.GG20795@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54753 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135Ab1BPTss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:48:48 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so1961105bwz.38
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 11:48:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110216173033.GG20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 16, 2011 at 09:30:33AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [110215 04:47]:
> > Hi Tony,
> > 
> > following are a few compile warning fixes for your
> > consideration.
> 
> I already got youre previous set queued in devel-cleanup
> branch. Care to see if that needs further patching?

attached patch is needed.

-- 
balbi

--ZPt4rx8FFjLCG7dd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm-omap2-clksel-fix-compile-warning.diff"

>From b1487889dc0e6d3c328d658e5d6730373785a49c Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Sun, 16 Jan 2011 13:22:03 +0200
Subject: [PATCH] arm: omap2: clksel: fix compile warning
Organization: Texas Instruments\n

Fix the following compile warning:
arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
used uninitialized in this function

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index a781cd6..e25364d 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
 				u32 *field_val)
 {
 	const struct clksel *clks;
-	const struct clksel_rate *clkr, *max_clkr;
+	const struct clksel_rate *clkr, *max_clkr = NULL;
 	u8 max_div = 0;
 
 	clks = _get_clksel_by_parent(clk, src_clk);
-- 
1.7.4.rc2


--ZPt4rx8FFjLCG7dd--
