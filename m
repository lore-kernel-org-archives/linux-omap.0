From: ikjn <tiffang@gmail.com>
Subject: Question about armv7(cortex-a9) dcache initialization.
Date: Thu, 22 Jul 2010 10:12:37 +0900
Message-ID: <AANLkTilpM7DcP26kvAmtukre16alx72Rh9CcnTvWVMD5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46786 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab0GVBMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 21:12:39 -0400
Received: by bwz1 with SMTP id 1so582189bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 18:12:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

In the ARM Cortex-A9 TRM, I found a note in chapter 6.1

Note:
You must invalidate the instruction cache, the data cache, and BTAC
before using them.
You are not required to invalidate the main TLB, even though it is
recommended for
safety reasons. This ensures compatibility with future revisions of
the processor.

But the kernel does.. ( __v7_setup in proc-v7.S )
clean & invalidate before turning on the MMU, not just 'invalidate'.

If dcache tag&data ram has garbage data when power up,
I think some dirty data lines can be flushed into to L2 or L3 memory
because kernel does clean.
And It can pollute the memory.

Is it possible in cortex-A9?

Thanks..
