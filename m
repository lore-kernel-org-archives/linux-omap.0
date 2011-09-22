From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v16 07/12] OMAP: dmtimer: add timeout to low-level routines
Date: Thu, 22 Sep 2011 11:23:34 +0530
Message-ID: <CAC83Zv+zg1LURpvRLc96sVV4sEx2CG7=1Lt+dT1VvhqEHAkj0Q@mail.gmail.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-8-git-send-email-tarun.kanti@ti.com>
	<20110922010046.GS2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:43020 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab1IVFxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 01:53:37 -0400
Received: by bkbzt12 with SMTP id zt12so2471505bkb.12
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 22:53:34 -0700 (PDT)
In-Reply-To: <20110922010046.GS2937@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

> Let's leave out these changes for now, they make the
> omap2_gp_timer_set_next_event used for system timer interrupts
> huge if you take a look at it with objdump.
>
> Later on we might want to split the posted bit check into a separate
> inline function, and then you can implement this for the device
> driver where things are more likely to go wrong with more complicated
> use scenarios.
Alright.
--
Tarun
>
> Regards,
>
> Tony
>
>
