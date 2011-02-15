From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Mon, 14 Feb 2011 20:11:23 -0800
Message-ID: <AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:45630 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BOEL1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 23:11:27 -0500
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p1F4BPf8008783
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 20:11:25 -0800
Received: from yxt3 (yxt3.prod.google.com [10.190.5.195])
	by wpaz13.hot.corp.google.com with ESMTP id p1F4BNhl010745
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 20:11:24 -0800
Received: by yxt3 with SMTP id 3so2507473yxt.33
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 20:11:23 -0800 (PST)
In-Reply-To: <AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 14, 2011 at 5:21 PM, Colin Cross <ccross@google.com> wrote:
> On Fri, Feb 11, 2011 at 8:17 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> This adds core support for saving and restoring CPU coprocessor
>> registers for suspend/resume support. =A0This contains support for s=
uspend
>> with ARM920, ARM926, SA11x0, PXA25x, PXA27x, PXA3xx, V6 and V7 CPUs.
>
> I would like to use cpu_suspend in a case where the L2 is still
> enabled. =A0When cpu_resume is called, the MMU and cache bits in SCTL=
R
> are disabled, so the reads skip the L2 cache, and the data that was
> saved (sleep_save_sp and *sleep_save_sp) is not read back.
>
> Is it possible to call the outer_cache functions from cpu_suspend to
> flush sleep_save_sp and the saved data?

Even with a cache flush, cpu_resume_turn_on_mmu fails because the page
table modification, done with the cache off, ends up in memory, but
the L2 contains the old value.  When the MMU and cache are enabled,
the 1:1 mapping disappears.  The page table would need to be
invalidated during suspend.

I can avoid the problem entirely by leaving the MMU on and skipping
cpu_resume when the CPU does not go through reset.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
