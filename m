From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Wed, 29 Jun 2011 00:46:21 +0100
Message-ID: <20110628234621.GD23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com> <CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com> <20110628225523.GA23312@n2100.arm.linux.org.uk> <CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com> <20110628231711.GC23312@n2100.arm.linux.org.uk> <CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57253 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1F1Xqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 19:46:34 -0400
Content-Disposition: inline
In-Reply-To: <CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Jun 28, 2011 at 04:37:08PM -0700, Colin Cross wrote:
> I don't think it affects bogomips - loops_per_jiffy can still be
> calibrated and updated by cpufreq, udelay just wont use them.

No, you can't avoid it.  __delay(), udelay(), and the global
loops_per_jiffy are all linked together - for instance this is how
the spinlock code has a 1s timeout:

static void __spin_lock_debug(raw_spinlock_t *lock)
{
        u64 loops = loops_per_jiffy * HZ;
        int print_once = 1;

        for (;;) {
                for (i = 0; i < loops; i++) {
                        if (arch_spin_trylock(&lock->raw_lock))
                                return;
                        __delay(1);
                }

which goes wrong for all the same reasons you're pointing out about
udelay().  So just restricting your argument to udelay() is not
realistic.
