From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] twl4030: keypad: Support for suspend-resume
Date: Thu, 4 Feb 2010 11:00:17 -0800
Message-ID: <20100204190017.GS22747@atomide.com>
References: <1265299589-29998-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62174 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757832Ab0BDS7r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 13:59:47 -0500
Content-Disposition: inline
In-Reply-To: <1265299589-29998-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Sanjeev Premi <premi@ti.com> [100204 08:04]:
> This set adds suspend-resume functionality to the TWL4030
> keypad driver. It also adds the capability to wakeup from
> the OFF mode.
> 
> These 2 patches don't depend upon the code in pm branch. And
> have been tested on linux-omap/master (c6348aa):
>   twl4030: keypad: Add suspend-resume functions
>   twl4030: keypad: Hooks for board specific suspend-resume
> 
> The complete set has been tested on linux-omap/pm (c6348aa).
> 
> All testing done on OMAP3EVM.

Looks OK to me. We should get an ack from linux-input and Dmitry
to merge these via linux-omap:

INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
M:      Dmitry Torokhov <dmitry.torokhov@gmail.com>
M:      Dmitry Torokhov <dtor@mail.ru>
L:      linux-input@vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
S:      Maintained
F:      drivers/input/

Can you please send the series again with linux-input Cc'd?

Regards,

Tony

 
> Sanjeev Premi (3):
>   twl4030: keypad: Add suspend-resume functions
>   twl4030: keypad: Hooks for board specific suspend-resume
>   OMAP3: PM: Wakeup from TWL4030 keypad with OFF mode
> 
>  arch/arm/mach-omap2/board-omap3evm.c    |   86 +++++++++++++++++++++++++++++++
>  drivers/input/keyboard/twl4030_keypad.c |   28 ++++++++++
>  include/linux/i2c/twl.h                 |   12 ++++
>  3 files changed, 126 insertions(+), 0 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
