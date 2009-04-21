From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH 5/7][RFC] OMAP4: Update common omap machine specific
 sources.
Date: Tue, 21 Apr 2009 18:54:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301CCA996DA@dbde02.ent.ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48010 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbZDUNYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 09:24:19 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LDOD1I018878
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:24:19 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n3LDOCb5019102
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 18:54:12 +0530 (IST)
In-Reply-To: <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

> 	case CLOCK_EVT_MODE_ONESHOT:
>@@ -108,6 +109,9 @@ static void __init omap2_gp_clockevent_init(void)
> 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
> #endif
> 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
>+	if (cpu_is_omap44xx())
>+		/* Assuming 32kHz clk is driving GPT1 */
>+		tick_rate = 32768;

[Romit] This should be read from CM_CLKSEL_WKUP.CLKSEL_GPT1 to be proper. 

