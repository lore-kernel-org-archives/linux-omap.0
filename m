From: Tony Lindgren <tony@atomide.com>
Subject: Re: n8x0 idle power problem
Date: Tue, 3 Nov 2009 09:19:13 -0800
Message-ID: <20091103171913.GK8981@atomide.com>
References: <f25d86460910231640i22e5da83q1094e60c2e4df05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52168 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZKCRTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:19:10 -0500
Content-Disposition: inline
In-Reply-To: <f25d86460910231640i22e5da83q1094e60c2e4df05@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felix Xiaozhu Lin <xzl@rice.edu>
Cc: linux-omap@vger.kernel.org

* Felix Xiaozhu Lin <xzl@rice.edu> [091023 16:41]:
> I am trying to compile a linux-omap kernel for n810 that can do good
> idle power management.
> 
> However, this seems to be harder than I expected. I've done all
> following measurements with /sys/power/sleep_while_idle set to 1.
> Compiler is arm-linux-gnueabi-gcc 4.2. I use n8x0_defconfig.
> 
>   * Maemo kernel (2.6.21) consumes ~0mA@3.8V when idle. This seems to
> be perfect. However, it has no pm regarding serial port. Whenever
> serial port is enabled, idle power is ~50mA@3.8V.
> 
>   * I've compiled 2.6.28/2.6.29 from l-o git. Serial port pm works
> fine. However the idle power is ~20mA@3.8V. That is quite strange.
> 
>   * For kernel >= 2.6.30 I didn't manage to boot my N810.
> 
> I also dig out a thread discussing about N8x0 idle power:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11954.html
> 
> where Kalle mentioned 2.6.29 idle power is OK. But I never get the same result.
> 
> I'm wondering if I did something wrong in the measurement. Anybody did
> the same thing? You suggestion is highly appreciated.

It sounds like something is blocking the deeper idle states.
The way to debug is to see what clocks and domains are on
before entering idle.

Maybe do a register dump on a working system and compare that
to the current system?

Regards,

Tony
