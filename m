From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Mon, 01 Jun 2009 16:57:35 +0300
Message-ID: <87oct8t5tc.fsf@litku.valot.fi>
References: <20090519232905.12760.15490.stgit@localhost>
	<20090519233732.12760.34595.stgit@localhost>
	<20090525092911.GC28195@n2100.arm.linux.org.uk>
	<20090525142128.17675cl0tvdr0y1k@lidskialf.net>
	<20090525174055.127744136qxu9vk0@lidskialf.net>
	<20090528182047.GF32453@atomide.com>
	<20090528195046.GW20736@n2100.arm.linux.org.uk>
	<20090529012952.104144iws1glmow0@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:50227 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbZFAN5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Jun 2009 09:57:39 -0400
Received: by fg-out-1718.google.com with SMTP id 16so2809935fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 01 Jun 2009 06:57:38 -0700 (PDT)
In-Reply-To: <20090529012952.104144iws1glmow0@lidskialf.net> (Andrew de Quincey's message of "Fri\, 29 May 2009 01\:29\:52 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Andrew de Quincey <adq_dvb@lidskialf.net> writes:

> Out of interest, what is the best practice way to pass platform
> specific GPIOs around? There are a number of other n770 related
> drivers I'm intending on cleaning up, several of which have GPIO
> numbers hardcoded in them. Should these be passed in platform
> structures, or is there something analogous to the clk_alias for
> GPIOs?

I was told that platform structures are the preferred way. For wl12xx (a
wi-fi driver) I created a set_power function pointer which will control
the power gpio line:

27 struct wl12xx_platform_data {
28         void (*set_power)(bool enable);
29 };

http://git.kernel.org/?p=linux/kernel/git/linville/wireless-testing.git;a=blob;f=include/linux/spi/wl12xx.h;h=11430cab2aad71242946ebfc7c0ce778d8bf26a1;hb=HEAD

And the irq is configured in the board file and provided to wl12xx with
struct spi_device.irq. So wl12xx doesn't use gpio code at all, it's all
done in the board file. 

Please comment if this isn't the correct way to do this.

-- 
Kalle Valo
