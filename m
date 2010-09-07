From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: omap3 startup memory map
Date: Tue, 7 Sep 2010 10:15:01 +0300
Message-ID: <20100907071501.GB2569@matterhorn.lan>
References: <AANLkTinMo8Z12fcvYS89DO-tKZ0KYtj43RCmnhQARoVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45105 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab0IGHPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 03:15:08 -0400
Received: by bwz11 with SMTP id 11so3854502bwz.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Sep 2010 00:15:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinMo8Z12fcvYS89DO-tKZ0KYtj43RCmnhQARoVg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Maydell <peter.maydell@linaro.org>
Cc: linaro-dev@lists.linaro.org, Richard Woodruff <richard.woodruff@linaro.org>, Steve Sakoman <steve.sakoman@linaro.org>, List Linux Omap <linux-omap@vger.kernel.org>

Adding linux-omap to CC

On 10 Sep 06, Peter Maydell wrote:
> Hi. I have a question about what the memory map of the TI OMAP3 (35xx)
> looks like on startup, which I'm hoping somebody here can answer.
> (Steve, Richard: you're on the CC: because Loic suggested that you
> would be good people to ask.)
> 
> I'm currently looking at a bug in qemu:
> https://bugs.launchpad.net/qemu-maemo/+bug/628471
> where we hang on bootup. That happens because the qemu
> implementation of NAND attached to the omap GPMC doesn't try to
> map anything into the memory space (it only does this for NOR
> devices).
> 
> From reading the OMAP35xx TRM I believe that when a NAND device
> is mapped into GPMC space (by setting GPMC_CONFIG7_i
> appropriately) then reads and writes to any address in the mapped
> region behave like accesses to GPMC_NAND_DATA_i. I have a patch
> which implements this mapping for NAND devices; however this
> causes a conflict about what should be mapped at address zero on
> startup, because:
> 
> (a) at reset GPMC_CONFIG7_i is 0xf40 for CS0 and 0xf00 for CS1..7,
> which maps CS0 to address 0. (On the Beagle board this is NAND.)
> (b) qemu also wants to map the boot ROM in at address 0
> 
> The TRM isn't terribly clear (to me :-)) about what happens at address
> zero on startup (it talks about a "1MB boot space" but doesn't say what
> this is or what address it is at or when it stops being in effect...)
> 
> It's also possible that qemu is wrong about mapping boot rom related
> things at address zero; we are emulating much of what the hardware's
> boot ROM does rather than actually executing it. However I would expect
> that there ought to be some real RAM/ROM there for the reset/exception
> vectors if nothing else...
> 
> So can anybody tell me what happens on real hardware?
> 
> -- Peter Maydell
