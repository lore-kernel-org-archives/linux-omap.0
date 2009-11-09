From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 0/4] OMAP3:PM: T2 keypad: Wakeup with support for OFF
 mode
Date: Mon, 9 Nov 2009 22:23:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE3B6B03@dbde02.ent.ti.com>
References: <1257784747-18059-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbZKIQxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 11:53:42 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA9GrdNC021839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 10:53:45 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA9Grc9v001839
	for <linux-omap@vger.kernel.org>; Mon, 9 Nov 2009 22:23:39 +0530 (IST)
In-Reply-To: <1257784747-18059-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Monday, November 09, 2009 10:09 PM
> To: linux-omap@vger.kernel.org
> Cc: Premi, Sanjeev
> Subject: [PATCH 0/4] OMAP3:PM: T2 keypad: Wakeup with support 
> for OFF mode
> 
> This patch series incrementally adds support for wake-up from
> TWL4030 keypad when OFF mode is hot during suspend.
> 
> In the process, it extends existing driver to support board
> specific implementation during suspend and resume operations.
> 
> The patch has been tested on OMAP3EVM and would be good to find
> if it works on the 3430SDP as well.
> 
> TODO:
>   The structire 'omap_keypad_pm_state' is being defined (and
>   duplicated) in board specific files - board-omap3evm.c and
>   board-3430sdp.c.
> 
>   This definition should ideally be in a header file, but
>   matrix_keypad.h is not the right one. Also, plat/keypad.h
>   is no longer used (inclusion results in warnings for duplicate
>   definitions).
>   
>   Possible alternatives:
>   - Cleanup plat/keypad.h - Not sure if it is being used by any
>     other platform.
>   - Create a new header file alongside the board files for TWL4030
>     keypad. (Much of existing duplication also gets addressed).
>   
>   Either of these alternatives can be taken as a separate patch.
>   OR, as follow-up to last 2 patches in this series. Thoughts?
> 

Forgot to mention that is applies over the patch-series submitted
earlier:
  [0] http://marc.info/?l=linux-omap&m=125725494430834&w=2
  [1] http://marc.info/?l=linux-omap&m=125725495630852&w=2
  [2] http://marc.info/?l=linux-omap&m=125725498430876&w=2
  Note: This series did not depend upon PM functions.

Best regards,
Sanjeev

> 
> Sanjeev Premi (4):
>   OMAP3: PM: Add suspend-resume to TWL4030 keypad
>   OMAP3: PM: T2 keypad: Add board specific suspend-resume functions
>   OMAP3: PM: Wakeup from T2 keypad with OFF mode
>   OMAP3: PM: Extend T2 wakeup support to 3430SDP
> 
>  arch/arm/mach-omap2/board-3430sdp.c     |   89 
> +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c    |   89 
> +++++++++++++++++++++++++++++++
>  drivers/input/keyboard/twl4030_keypad.c |   28 ++++++++++
>  include/linux/i2c/twl4030.h             |   12 ++++
>  4 files changed, 218 insertions(+), 0 deletions(-)
> 
> 