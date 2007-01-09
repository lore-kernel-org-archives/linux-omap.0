From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending December (January) patches
Date: Tue, 9 Jan 2007 15:59:12 -0800
Message-ID: <20070109235912.GX7384@atomide.com>
References: <459E6FE4.5030208@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <459E6FE4.5030208@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070105 07:36]:
> Hi,
> 
> I had some problems with mail to the list, so instead of a 
> pending december patches mail an update which includes 
> already our patches from yesterday. Yes, it's clear that 
> they can't be applied yet ;)
> 
> December 2006 pending patches
> -----------------------------
> 
> 1. [RFC][PATCH] Update MMC response types
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-December/008643.html
> 
> Note: Is this already merged anywhere else? Or should this 
> be applied against OMAP git?

I've applied this to omap tree, should go also into Pierre's queue.

<snip>
 
>  Pending OMAP patches January 2007
> ---------------------------------
> 
> 1. [PATCH] ARM: OMAP: Fix missing workqueue include in 
> board-h2.c
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008757.html
> 
> 2. [PATCH] ARM: OMAP: Update omap_h2_1610_defconfig
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008760.html
> 
> 3. [PATCH] ARM: OMAP: Workqueue changes for board-h4.c
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008761.html
> 
> 4. [PATCH] ARM: OMAP: Add missing includes to board-nokia770
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008762.html
> 
> 5. [PATCH] ARM: OMAP: Add missing include to dsp/mblog.c
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008763.html
> 
> 6. [PATCH] ARM: OMAP: Workqueue changes for tahvo-usb
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008764.html
> 
> 7. [PATCH] ARM: OMAP: Workqueue changes for retu-rtc
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008765.html
> 
> 8. [PATCH] ARM: OMAP: Fix section mismatch warnings in omap-rng
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008769.html
> 
> 9. [PATCH] ARM: OMAP: Make board-palmz71 compile again
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008770.html
> 
> 10. [PATCH] ARM: OMAP: Fix warnings in lcd_palmz71
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008771.html
> 
> 11. innovator_ps2 broken
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008772.html
> 
> 12. [PATCH] Make omap-ir build with workqueue changes.
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008773.html
> 
> 13. [PATCH] Make omap_bl build again after API change.
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/008776.html

These should be applied now, everybody please check your patches got
applied OK.

Regards,

Tony
