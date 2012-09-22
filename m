From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4+: wakeupgen: fix memory corruption
Date: Sat, 22 Sep 2012 18:52:46 +0530
Message-ID: <CAMQu2gyW4Dp0tVWab60no57XH1LOUb+jzo7xLDNjwBk8UNU+uQ@mail.gmail.com>
References: <alpine.DEB.2.00.1209220732400.23491@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:43002 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522Ab2IVNXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Sep 2012 09:23:08 -0400
Received: by vbbff1 with SMTP id ff1so4775345vbb.19
        for <linux-omap@vger.kernel.org>; Sat, 22 Sep 2012 06:23:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209220732400.23491@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

On Sat, Sep 22, 2012 at 1:41 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
>
> Fix a memory corruption bug caused by commit
> 247c445c0fbd52c77e497ff5bfcf0dceb8afea8d ("ARM: OMAP5: Add the
> WakeupGen IP updates") and commit
> ec2c0825ca3183a646a24717966cc7752e8b0393 ("ARM: OMAP2+: Remove
> hardcoded IRQs and enable SPARSE_IRQ").
>
> The first commit, in the OMAP4+ wakeupgen code, has an implicit
> dependency on !SPARSE_IRQ.  It allocates a static array with NR_IRQS
> elements, then proceeds to iterate over 128 or 160 elements of
> that array, clearing them to zero.
>
> The second commit switched OMAP2+ to use sparse IRQs, but missed the
> NR_IRQS reference in the wakeupgen code.  Before the second commit,
> NR_IRQS was 474 on OMAP4430; but afterwards, it became 16.
>
> This resulted in the wakeupgen code allocating a 16 element array, and
> then attempting to write to 128 or 160 of those elements, depending on the
> type of SoC.  This trashed a chunk of whatever was allocated after the
> array.
>
> The immediate manifestation was a set of boot warnings similar to the
> following:
>
>    WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1941 _enable+0x1bc/0x204()
>    omap_hwmod: mpu: could not enable clockdomain mpuss_clkdm: -22
>    ...
>
> since it blew away arch_clkdm.  Ultimately the kernel crashed during boot.
>
> Fix the problem in the OMAP4+ wakeupgen code by removing the reference to
> NR_IRQS, allocating a larger array, and warning if the iteration is larger
> than the array.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Applies on arm-soc omap/cleanup-sparseirq and should ideally be merged
> there before the 3.7 merge window.
>
The issue is already fixed by commit e534e87 {ARM: OMAP4: Fix array size for
irq_target_cpu} in mainline. The fix got merged after 3.6-rc5 tag and hence
not appearing in the 'omap/cleanup-sparseirq' branch which seems to be based
of 3.6-rc5.

If you merge 3.6-rc6 tag or the latest mainline with omap/cleanup-sparseirq, the
issue should go away. So from 3.7 merge window point of view, the fix is already
in place.

Regards
Santosh
