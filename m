From: ikjn <tiffang@gmail.com>
Subject: Re: Question about armv7(cortex-a9) dcache initialization.
Date: Mon, 2 Aug 2010 18:55:31 +0900
Message-ID: <AANLkTinuU5mJA7jHpODeQFik3JFUp0u+0B-5QA24tsmh@mail.gmail.com>
References: <AANLkTilpM7DcP26kvAmtukre16alx72Rh9CcnTvWVMD5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45211 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab0HBJzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 05:55:32 -0400
Received: by qyk7 with SMTP id 7so5264459qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Aug 2010 02:55:32 -0700 (PDT)
In-Reply-To: <AANLkTilpM7DcP26kvAmtukre16alx72Rh9CcnTvWVMD5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Now I think that it is a bootloader requirement.

And in the arm linux kernel's booting requirement,
"Data cache must be off and must not contain any stale data."
And today I found a code for invalidating dcache in omap4 bootloader
source code.

So it's okay to clean & invalidate in kernel init procedure.
Boot loader should initialize all caches before use.

On Thu, Jul 22, 2010 at 10:12 AM, ikjn <tiffang@gmail.com> wrote:
> In the ARM Cortex-A9 TRM, I found a note in chapter 6.1
>
> Note:
> You must invalidate the instruction cache, the data cache, and BTAC
> before using them.
> You are not required to invalidate the main TLB, even though it is
> recommended for
> safety reasons. This ensures compatibility with future revisions of
> the processor.
>
> But the kernel does.. ( __v7_setup in proc-v7.S )
> clean & invalidate before turning on the MMU, not just 'invalidate'.
>
> If dcache tag&data ram has garbage data when power up,
> I think some dirty data lines can be flushed into to L2 or L3 memory
> because kernel does clean.
> And It can pollute the memory.
>
> Is it possible in cortex-A9?
>
> Thanks..
>
