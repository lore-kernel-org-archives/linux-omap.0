From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2a/5] Remove unsafe clock values from omap1_defconfig
Date: Thu, 1 Dec 2011 09:17:58 -0800
Message-ID: <20111201171758.GT31337@atomide.com>
References: <20111128174508.GO31337@atomide.com>
 <201112010310.43890.jkrzyszt@tis.icnet.pl>
 <20111201022750.GY13928@atomide.com>
 <201112011054.09878.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201112011054.09878.jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 01:20]:
> 
> If you still ask me for my opinion: with patch 3/5 omitted, then not 
> being able to run at any other frequency than 60 MHz instead of usual 
> 150 since the board support was introduced first, isn't this a 
> regression?

Yes, assuming that the behaviour for your board has changed by something
after v3.1, such as commit e9b7086b80c4d9e354f4edc9e280ae85a60df408.

> Having a choice of upgrading to 3.2 and running my 
> application on not very powerfull board at 60 MHz, or keep running 3.1 
> at 150, guess what I chose? If I were a distro kernel package 
> maintainer, guess what I would chose?

Right, that's certainly not intentional :)

> > It seems that we've had the issue of not actually changing the rate
> > for a while, right?
> 
> This was not an issue before dpll1 reprogramming has been moved out from 
> omap1_clk_init(), as an rc fix to another bug introduced in 3.2. Perhaps 
> we should rather think of reverting a few commits which caused all these 
> problems if fixing them all during rc cycle seems not possible? I 
> haven't bisected them yet, rather concentrated on providing fixes, but I 
> can still try to do it, starting back from the original issue 
> (http://www.spinics.net/lists/linux-omap/msg60052.html), if so decided.

We can't revert that because the SRAM init has been moved to later for
map_io. But if that patch changed the behaviour on your board, then that's
the problem we should fix.

If you're now stuck at 60MHz rate, care to see if the following patch
makes the kernel behave the same way as before for you? Sorry for dragging
this on, but I'd like to find out what exactly changed the behaviour for
your board.
 
> Anyway, did you mean resending those 2/5 and 5/5 without any changes, 
> only renumbered as 1/2 and 2/2?

Well the numbers will not show up in git, so no changes needed there :)

But let's figure out first what changed the behaviour for your board.

Regards,

Tony

--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -927,7 +927,7 @@ int __init omap1_clk_init(void)
 
 void __init omap1_clk_late_init(void)
 {
-	if (ck_dpll1.rate >= OMAP1_DPLL1_SANE_VALUE)
+	if (ck_dpll1.rate > OMAP1_DPLL1_SANE_VALUE)
 		return;
 
 	/* Find the highest supported frequency and enable it */
