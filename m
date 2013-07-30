From: Chen Baozi <baozich@gmail.com>
Subject: Re: Linux kernel for OMAP5432 uEVM
Date: Tue, 30 Jul 2013 20:38:38 +0800
Message-ID: <8D21D1B6-4270-4F2E-A4A3-47E846DF810D@gmail.com>
References: <20130730033808.GA23486@cbz-workstation> <51F7387B.9060304@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56071 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3G3Mio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 08:38:44 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so5548429pad.28
        for <linux-omap@vger.kernel.org>; Tue, 30 Jul 2013 05:38:43 -0700 (PDT)
In-Reply-To: <51F7387B.9060304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Lokesh & list,

On Jul 30, 2013, at 11:52 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:

> Clk data might be missing here. Try merging the below branch and test it
> https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=for_3.11/out_of_tree/omap5_clk_data
> 
> You can also use Linus's kernel with the above clk data branch.( OMAP5 uEVM boots)
> Please let me know if you need more info.
> 
> Thanks and regards,
> Lokesh

I've ported the two patches on the top of clk data branch to both of linux-omap tree and Linus's kernel. They all work now. Thanks a lot.

And a few more questions, ;-)

I read the timer initialization codes in kernel. It looks like the Linux kernel does not use the architected timer of Cortex-A15 MPCore. I tried to use arch_timer_get_cntfrq() to get its rate, but failed(returned frequency is 0). I'm wondering if it is because of lack of initialization or other issues.

Another question is about UART on OMAP5432. This is origin from my attempt to porting Xen to OMAP5432. Now Xen has already had a 8250 compatible driver. What I have done is to hook it with Xen's arm initialization codes (for example, hook it with device tree). Xen's original driver is rather simple compared to the Linux omap-serial.c. It enables receive and transmit interrupts in the end of initialization. Once the interrupt is enabled, it would generate nested interrupt of THRE and make the system dead loop in the interrupt handler. I have been digging this problem for nearly a month and haven't got a clue yet. I guess it might be caused by uninitialized architected timer, which then lead me to the previous question. Any idea?

Cheers,

Baozi