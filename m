From: Colin Cross <ccross@google.com>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Tue, 28 Jun 2011 16:59:57 -0700
Message-ID: <CAMbhsRRBhT5YX6E4Nkyvns5YykqzqV3-g4JhR2KPcxBhj0ABww@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
	<20110628231711.GC23312@n2100.arm.linux.org.uk>
	<CAMbhsRQUg75R=1TvqYwgcF5eCSFq3WFaAg7EsJ=yaT9VgcfJNA@mail.gmail.com>
	<20110628234621.GD23312@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:20093 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1F2AAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 20:00:01 -0400
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id p5SNxxkd005599
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:59:59 -0700
Received: from ywp17 (ywp17.prod.google.com [10.192.16.17])
	by kpbe17.cbf.corp.google.com with ESMTP id p5SNxvHP010018
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:59:58 -0700
Received: by ywp17 with SMTP id 17so335614ywp.29
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 16:59:57 -0700 (PDT)
In-Reply-To: <20110628234621.GD23312@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, Jun 28, 2011 at 4:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 28, 2011 at 04:37:08PM -0700, Colin Cross wrote:
>> I don't think it affects bogomips - loops_per_jiffy can still be
>> calibrated and updated by cpufreq, udelay just wont use them.
>
> No, you can't avoid it. =A0__delay(), udelay(), and the global
> loops_per_jiffy are all linked together - for instance this is how
> the spinlock code has a 1s timeout:
>
> static void __spin_lock_debug(raw_spinlock_t *lock)
> {
> =A0 =A0 =A0 =A0u64 loops =3D loops_per_jiffy * HZ;
> =A0 =A0 =A0 =A0int print_once =3D 1;
>
> =A0 =A0 =A0 =A0for (;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < loops; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (arch_spin_trylock(=
&lock->raw_lock))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__delay(1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> which goes wrong for all the same reasons you're pointing out about
> udelay(). =A0So just restricting your argument to udelay() is not
> realistic.
>

True, there are a few other users of loops_per_jiffy and __delay, but
it looks like __spin_lock_debug is the only one worth worrying about,
and it's timing is not as critical as udelay - worst case here is that
the warning occurs after 250 ms instead of 1s.  Leaving
loops_per_jiffy and __delay intact, and fixing udelay, would still be
a net gain.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
