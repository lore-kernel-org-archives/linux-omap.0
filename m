From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 15 Aug 2009 14:10:27 +0100
Message-ID: <20090815131027.GE29616@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com> <20090808170300.GA23481@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C64CF@dbde02.ent.ti.com> <20090813173327.GA14872@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C6586@dbde02.ent.ti.com> <366f00c80908150603m2b6f3235y7e47256adc11234a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39182 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZHONKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 09:10:47 -0400
Content-Disposition: inline
In-Reply-To: <366f00c80908150603m2b6f3235y7e47256adc11234a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sudeep K N <sudeepholla.maillist@gmail.com>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Aug 15, 2009 at 06:33:20PM +0530, Sudeep K N wrote:
> I had intially tried memmap=xxM$yyM to reserve xxM at yyM
> This has some issue with 2.6.27 and fixed in later versions(not sure
> of exact version) and I have not tried it.

memmap= is not supported on ARM - there is no code to parse or use the
option except on x86 and blackfin, so it gets passed to the init program
when userspace starts.

