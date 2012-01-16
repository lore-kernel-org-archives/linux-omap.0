From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled by uBoot)?
Date: Mon, 16 Jan 2012 11:18:21 +0100
Message-ID: <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41590 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195Ab2APKSn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jan 2012 05:18:43 -0500
Received: by mail-qw0-f49.google.com with SMTP id c14so318821qad.15
        for <linux-omap@vger.kernel.org>; Mon, 16 Jan 2012 02:18:42 -0800 (PST)
In-Reply-To: <WC20120116100344.4204CC@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>

+ linux-arm, Russell and Catalin

On Mon, Jan 16, 2012 at 11:03 AM, Joe Woodward <jw@terrafix.co.uk> wrot=
e:
> The latest uBoot release (2011.12) disables the L2/outer cache during=
 boot on OMAP boards.
>
> uBoot commit: "armv7: disable L2 cache in cleanup_before_linux()" on =
6th Dec 2011 by Aneesh V adds the following to
> uBootSources/arch/arm/cpu/armv7/cpu.c:cleanup_before_linux():
> =A0...
> =A0v7_out_cache_disable();
>
> The commit message implies this change was to make booting reliable o=
n OMAP4 by disabling L2 cache before jumping to Linux. Sadly
> this commit also affects OMAP3-based boards...
>
> Since switching to uBoot 2011.12 I'm seeing about half the performanc=
e on my GUSMTIX Overo (OMAP3530).
>
> In the kernel sources there seem to be OMAP4 specific functions for r=
e-enabling the L2 cache (omap4-common.c:omap_l2_cache_init()),
> but none for OMAP3.
>
> So my question is... do we expect that Linux should be re-enabling th=
e L2/outer cache during boot after uBoot has disabled it on OMAP3?
>
Yes. Kernel already does enabled L2 on A8 CPU's but OMAP3 needs a
secure call and then the patching becomes
that much difficult.

We need some kind of generic hook in proc*_setup() function where in
such secure bits can be turned ON.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
