From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Date: Wed, 8 Dec 2010 08:38:28 -0800 (PST)
Message-ID: <603978.51278.qm@web180303.mail.gq1.yahoo.com>
References: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm26-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.230]:47682 "HELO
	nm26-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751608Ab0LHQif (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 11:38:35 -0500
In-Reply-To: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

So to recapitulate ... you're agreeing with me on
my key point -- that ARM1156, a V6T2 core with
 Thumb2 support (used in fact to introduce
Thumb2), should  work for some in-kernel Thumb2
usage, degree TBD, but obviously the v7 cores
are more capable (with SIMD support in T2, etc).

And no, *I* never said anything about a V7M Linux,
that was your words.  I'm used to the advantages of using MMUs with fork() and mprotect(), etc.


But the updated reason you gave for not allowing V6T2 is
that it's an uncommon architecture (one core, not
widely manufactured today) ... not impossibility.

In short, the basic premise of $PATCH is wrong, as
I pointed out, but there may be other reasons to
merge it, related to V6T2 chip availability not the
actual architecture specs from ARM.

A similar argument would be that making the ASM code
cope with core variants would get ugly/messy.  At
least the GNU assembler is, as I recall, aware of
which instructions which cores support, so it would
provide clean errors if given instructions that are
Thumb2 (some flavor) but not accepted by the target.
But Linux code shouldn't trigger such errors in the
first place, even if they're a good backstop (and
that implies ugly core-driven conditional code.
