From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 6/6] ARM: OMAP: fix cpufreq build
Date: Mon, 26 Mar 2012 15:07:22 -0700
Message-ID: <87ehsfrp7p.fsf@ti.com>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
	<E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk>
	<20120326083256.GC22608@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:58640 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755851Ab2CZWH0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Mar 2012 18:07:26 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so7189890pbc.18
        for <linux-omap@vger.kernel.org>; Mon, 26 Mar 2012 15:07:25 -0700 (PDT)
In-Reply-To: <20120326083256.GC22608@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 26 Mar 2012 09:32:56 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Kevin,
>
> I only just found this via the arm-soc tree, while trying to merge the
> kautobuildv2 build tree.
>
> You changed my patch and broke it:
>
> config ARM_OMAP2PLUS_CPUFREQ
>         bool "TI OMAP2+"
>         default ARCH_OMAP2PLUS
>         select CPU_FREQ_TABLE
>
> So now, OMAP2 CPUFREQ is selectable on ANYTHING but it will only build
> successfully on OMAP.

Yes, I screwed it up.

I wanted it to be selectable, but majorly screwed it up and it is
certainly not randconfig friendly.

This was also pointed out by Grazvydas soon after merging[1], and I was
expecting a patch from him to remedy that, but I will take care of it
and submit a patch for v3.4-rc right away.
 
> If you're going to change someone elses patch, do them the favour of
> re-posting it back to them for comment *BEFORE* you commit it and send
> it upstream, 

I did.  On Feb 16th, I posted my modified version with you and
linux-arm-kernel Cc'd:

   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/085053.html

and then I didn't send the pull request for this for another 3 weeks.

> rather than making it look like they're a total tosser for
> authoring a patch which fucks up other architecture builds.

/me has cache miss on tosser in American jargon cache
/me looks up in urban dictionary.

> Many thanks for that.

Many apologies.

Kevin

[1] http://marc.info/?l=linux-omap&m=133174677506294&w=2

