From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: OMAP35x GP TIMER as a wakeup trigger
Date: Mon, 27 Apr 2009 23:37:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D73E1210@dbde02.ent.ti.com>
References: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758928AbZD0SHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 14:07:20 -0400
In-Reply-To: <1f11a5490904270849j5130384avdbaa8da21bc2b668@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Ashwin,
              Please see below:
>Could someone familiar with this scheme quickly elaborate all the
>steps that I need to go through to get the system to come out of
>suspend purely on the timer? Is it is just enough to setup the timer
>correctly, enable the interrupt in the appropriate register and assume
>that the PM layer will get the interrupt and do the right thing, or is
>there more that I have to do?
[Romit] Already this is being done during the CPU Idle path. Yes you need to program the GPT 1 into oneshot mode with expiry time as appropriate. Also set the CM_CLKSEL_WKUP.CLKSEL_GPT1 to sys_32K clock. 
PM_MPUGRPSEL_WKUP.GRPSEL_GPT1, PM_WKEN_WKUP.EN_GPT1 should be set.

>
>Also, as as additional thing, if the PM layer handles the interrupt
>and begins the wake-up process, if I could know where that
>specifically happens, that'd be great since I need to know that the
>wake-up process is being triggered by the GPTIMER as opposed to the
>other wakeup triggers and deal with that differently.

 [Romit] prcm_interrupt_handler. Look for PM_WKST_WKUP.

Thanks,
-Romit

