From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Mon, 26 Sep 2011 16:10:05 -0700
Message-ID: <8739fi99yq.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:39693 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884Ab1IZXKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 19:10:12 -0400
Received: by yxt33 with SMTP id 33so4852721yxt.3
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 16:10:11 -0700 (PDT)
In-Reply-To: <CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Sat, 24 Sep 2011 16:11:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

[...]

> As pointed out by Kevin, debounce clock was not getting disabled.
> In my testing I was somehow grepping CORE power domain instead
> of PER power domain and hence missed it. The fix for the debounce
> clock issue is at the end of the email.
>
> - Have re-based the for_3.2/gpio-cleanup branch against 3.1-rc6.
> - Dropped [PATCH 26/26] gpio/omap: add dbclk aliases for all gpio modules
> as suggested by Kevin since it's already taken care by hwmod.
> - Added the debounce clock fix in the end.

That debounce fix definitely makes things look better, but it's not
solving the problem...

> With above, PER is hitting low power state in Suspend and Idle path.
>
> Have pushed a branch at below URL with mentioned changes.
> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
> for_3.2/kevin/gpio-cleanup

I tested your branch on my 3430/n900 and PER is still not hitting
retention.  Setting all debounce values in the board file to zero using
the patch below[1] makes PER hit retention again.

Assuming you don't have an n900 to test with, I suggest you just copy
the GPIO keys init from board-rx51-peripherals.c (or some of it) into
the board file you are testing with.

The problem is most likely be related to having more than one GPIO in a
bank with debounce enabled, or more than one bank with GPIOs enabled and
your current test is not be catching it.

Kevin

[1]
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5a886cd..1853194 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -207,7 +207,7 @@ static void __init rx51_charger_init(void)
 #define RX51_GPIO_LOCK_BUTTON		113
 #define RX51_GPIO_PROXIMITY		89
 
-#define RX51_GPIO_DEBOUNCE_TIMEOUT	10
+#define RX51_GPIO_DEBOUNCE_TIMEOUT	0
 
 static struct gpio_keys_button rx51_gpio_keys[] = {
 	{
